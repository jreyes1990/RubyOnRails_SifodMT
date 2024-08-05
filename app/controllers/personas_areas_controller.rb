class PersonasAreasController < ApplicationController
  include ManageStatus
  before_action :set_personas_area, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /personas_areas or /personas_areas.json
  def index
    @personas_areas = PersonasArea.where(estado: ['A', 'I']).order(:id)
   
  end

  # GET /personas_areas/1 or /personas_areas/1.json
  def show
  end

  # GET /personas_areas/new
  def new
    @personas_area = PersonasArea.new
  end

  # GET /personas_areas/1/edit
  def edit
  end

  # POST /personas_areas or /personas_areas.json
  def create
    @personas_area = PersonasArea.new(personas_area_params)
    @personas_area.estado = "A"
    @personas_area.user_created_id = current_user.id

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@personas_area, "No se pudo asignar la persona - área", "Error de base de datos al asignar la persona - área")

      respond_to do |format|
        format.html { redirect_to personas_areas_url, notice: "La asignacion [ <strong>#{@personas_area.persona.nombre.upcase} - #{@personas_area.area.nombre.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: personas_areas_url }
      end
    end
  end

  # PATCH/PUT /personas_areas/1 or /personas_areas/1.json
  def update
    persona_id = params[:personas_area][:persona_id]
    area_id = params[:personas_area][:area_id]

    @valida_enparametro = Parametro.joins("inner join users on parametros.user_id = users.id
                                            inner join personas on users.id = personas.user_id
                                            inner join personas_areas on personas_areas.persona_id = personas.id
                                            where personas_areas.persona_id = #{persona_id}
                                             and personas_areas.area_id = #{area_id}").first

    @trae_user = Persona.where('id = ?', persona_id)

    if @valida_enparametro.blank?

      @existencia_parametro = Parametro.joins("inner join users on parametros.user_id = users.id
                                            inner join personas on users.id = personas.user_id
                                            inner join personas_areas on personas_areas.persona_id = personas.id
                                            where personas_areas.persona_id = #{persona_id}").first

        
      if @existencia_parametro.blank?
        #ACTUALIZA PORQUE NO EXISTE EN PARAMETRO 
        @personas_area.user_updated_id = current_user.id

        ActiveRecord::Base.transaction do
          actualizar_con_manejo_de_excepciones(@personas_area, personas_area_params, "No se pudo actualizar el área", "Error de base de datos al actualizar el área")
          respond_to do |format|
            format.html { redirect_to personas_areas_url, notice: "La asignacion [ <strong>#{@personas_area.persona.nombre.upcase} - #{@personas_area.area.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
            format.json { render :show, status: :ok, location: personas_areas_url }
          end
        end       
      else
        #ELIMINA PRIMERO PARAMETROS Y DESPUES MODIFICA PERSONA AREA 
        @usuario_existe_parametro = Parametro.find(@existencia_parametro.id)
                 
        if @usuario_existe_parametro.destroy
          #YA ELIMINO AHORA MODIFICA PERSONA AREA
          @personas_area.user_updated_id = current_user.id

          ActiveRecord::Base.transaction do
            actualizar_con_manejo_de_excepciones(@personas_area, personas_area_params, "No se pudo actualizar el área", "Error de base de datos al actualizar el área")
            respond_to do |format|
              format.html { redirect_to personas_areas_url, notice: "La asignacion [ <strong>#{@personas_area.persona.nombre.upcase} - #{@personas_area.area.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
              format.json { render :show, status: :ok, location: personas_areas_url }
            end
          end
        end 
      end 
    else
      #SOLO ACTUALIZA SIN MODIFICAR PARAMETROS ES IGUAL
      @personas_area.user_updated_id = current_user.id

      ActiveRecord::Base.transaction do
        actualizar_con_manejo_de_excepciones(@personas_area, personas_area_params, "No se pudo actualizar el área", "Error de base de datos al actualizar el área")
        respond_to do |format|
          format.html { redirect_to personas_areas_url, notice: "La asignacion [ <strong>#{@personas_area.persona.nombre.upcase} - #{@personas_area.area.nombre.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
          format.json { render :show, status: :ok, location: personas_areas_url }
        end
      end
    end
  end

  # DELETE /personas_areas/1 or /personas_areas/1.json
  def destroy
    @personas_area.destroy
    respond_to do |format|
      format.html { redirect_to personas_areas_url, notice: "Personas area was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Inactivar Usuario - Area
  def inactivar_usuario_area
    @personas_area = PersonasArea.find(params[:id])
    @cantidad_personas_area = PersonasArea.where('persona_id = ?', @personas_area.persona_id).count
    
    if @cantidad_personas_area > 1
      @personas_area.user_updated_id = current_user.id
      @personas_area.estado = "I"

      respond_to do |format|
        if @personas_area.save
          @existencia_parametro = Parametro.joins("inner join users on parametros.user_id = users.id
                                                  inner join personas on users.id = personas.user_id
                                                  inner join personas_areas on personas_areas.persona_id = personas.id
                                                  where personas_areas.persona_id = #{@personas_area.persona_id}
                                                  and personas_areas.area_id = #{@personas_area.area_id}").first
          if @existencia_parametro.blank?
              format.html { redirect_to personas_areas_path, notice: "Asignación Usuario-Área Inactivada" }
              format.json { render :show, status: :created, location: @personas_area }
          else 
            @parametro = Parametro.where('user_id = ? and area_id = ?',@existencia_parametro.id, @existencia_parametro.area_id).first
            if @parametro.blank?
                format.html { redirect_to personas_areas_path, notice: "Asignación Usuario-Área Inactivada" }
                format.json { render :show, status: :created, location: @personas_area }
            else
              if @parametro.destroy
                format.html { redirect_to personas_areas_path, notice: "Asignación Usuario-Área Inactivada" }
                format.json { render :show, status: :created, location: @personas_area }
              else 
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @parametro.errors, status: :unprocessable_entity }
              end  
            end 
          end         
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @personas_area.errors, status: :unprocessable_entity }
        end
      end
    else 
      respond_to do |format|
        format.html { redirect_to personas_areas_path, alert: "La persona no puede estar sin un área asignada." }
        format.json { render :show, status: :created, location: @personas_area }
      end 
    end 
  end

#METODO PARA BUSCAR LAS AREAS POR EMPRESA
def search_areas_by_empresa
  empresa_id = params[:empresa_id]
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personas_area
      @personas_area = PersonasArea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def personas_area_params
      params.require(:personas_area).permit(:persona_id, :area_id )
    end
end
