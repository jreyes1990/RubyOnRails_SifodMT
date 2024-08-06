class TipoCamposController < ApplicationController
  before_action :set_tipo_campo, only: %i[ show edit update destroy ]

  # GET /tipo_campos or /tipo_campos.json
  def index
    @tipo_campos = TipoCampo.all
  end

  # GET /tipo_campos/1 or /tipo_campos/1.json
  def show
  end

  # GET /tipo_campos/new
  def new
    @tipo_campo = TipoCampo.new
  end

  # GET /tipo_campos/1/edit
  def edit
  end

  # POST /tipo_campos or /tipo_campos.json
  def create
    @tipo_campo = TipoCampo.new(tipo_campo_params)

    respond_to do |format|
      if @tipo_campo.save
        format.html { redirect_to tipo_campo_url(@tipo_campo), notice: "Tipo campo was successfully created." }
        format.json { render :show, status: :created, location: @tipo_campo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tipo_campo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_campos/1 or /tipo_campos/1.json
  def update
    respond_to do |format|
      if @tipo_campo.update(tipo_campo_params)
        format.html { redirect_to tipo_campo_url(@tipo_campo), notice: "Tipo campo was successfully updated." }
        format.json { render :show, status: :ok, location: @tipo_campo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tipo_campo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_campos/1 or /tipo_campos/1.json
  def destroy
    @tipo_campo.destroy

    respond_to do |format|
      format.html { redirect_to tipo_campos_url, notice: "Tipo campo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_campo
      @tipo_campo = TipoCampo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tipo_campo_params
      params.require(:tipo_campo).permit(:nombre, :tipo_dato, :descripcion, :tiene_respuesta, :tipo_seleccion_id, :tipo_contenido_id, :user_created_id, :user_updated_id, :usr_grab, :usr_modi, :estado)
    end
end
