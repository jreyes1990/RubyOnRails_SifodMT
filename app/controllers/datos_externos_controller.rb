class DatosExternosController < ApplicationController
  before_action :set_datos_externo, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /datos_externos or /datos_externos.json
  def index
    @datos_externos = DatosExterno.where('estado = ?','A')
    
    
  end

  # GET /datos_externos/1 or /datos_externos/1.json
  def show
  end

  # GET /datos_externos/new
  def new
    @datos_externo = DatosExterno.new
  end

  # GET /datos_externos/1/edit
  def edit
  end

  # POST /datos_externos or /datos_externos.json
  def create
    @datos_externo = DatosExterno.new(datos_externo_params)
    @datos_externo.estado = 'A'
    @datos_externo.user_created_id = current_user.id

    respond_to do |format|
      if @datos_externo.save
        format.html { redirect_to datos_externos_path, notice: "Datos externo creado exitosamente." }
        format.json { render :show, status: :created, location: @datos_externo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @datos_externo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datos_externos/1 or /datos_externos/1.json
  def update
    respond_to do |format|
      @datos_externo.user_updated_id = current_user.id
      if @datos_externo.update(datos_externo_params)
        format.html { redirect_to datos_externos_path, notice: "Datos externo actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @datos_externo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @datos_externo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datos_externos/1 or /datos_externos/1.json
  def destroy
    @datos_externo.destroy
    respond_to do |format|
      format.html { redirect_to datos_externos_path, notice: "Datos externo inactivado exitosamente." }
      format.json { head :no_content }
    end
  end

  def index_detalle_datos_externo
    @dato_externos = DatosExterno.find(params[:dato_externo_id])
 
    @detalle_datos_externos = DetalleDatosExterno.where('datos_externo_id = ? and estado = ?',params[:dato_externo_id], 'A')
  end 

  def nuevo_detalle_dato
    @dato_externos = DatosExterno.find(params[:id])
  end 

  def crea_detalle_de
    @detalle_datos = DetalleDatosExterno.new(detalle_datos_externo_params)
    @detalle_datos.estado = 'A'
    @detalle_datos.user_created_id = current_user.id

    respond_to do |format|
      if @detalle_datos.save
        format.html { redirect_to index_detalle_datos_externo_path(:dato_externo_id => params[:nuevo_detalle_de][:datos_externo_id] ), notice: "Detalle datos externo creado exitosamente." }
        format.json { render :show, status: :created, location: @detalle_datos }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @detalle_datos.errors, status: :unprocessable_entity }
      end
    end

  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datos_externo
      @datos_externo = DatosExterno.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def datos_externo_params
      params.require(:datos_externo).permit(:nombre, :url_api, :token, :estado, :user_created_id, :user_updated_id)
    end
    def detalle_datos_externo_params
      params.require(:nuevo_detalle_de).permit(:datos_externo_id, :nombre, :param1, :param2, :param3, :param4, :param5, :tipo, :body, :estado, :user_created_id, :user_updated_id)
    end
end
