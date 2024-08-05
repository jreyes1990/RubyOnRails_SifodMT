class DetalleDatosExternosController < ApplicationController
  before_action :set_detalle_datos_externo, only: %i[ show edit update destroy ]
  #before_action :comprobar_permiso

  # GET /detalle_datos_externos or /detalle_datos_externos.json
  def index
    @detalle_datos_externos = DetalleDatosExterno.all
  end

  # GET /detalle_datos_externos/1 or /detalle_datos_externos/1.json
  def show
  end

  # GET /detalle_datos_externos/new
  def new
    @detalle_datos_externo = DetalleDatosExterno.new
  end

  # GET /detalle_datos_externos/1/edit
  def edit
  
  end

  # POST /detalle_datos_externos or /detalle_datos_externos.json
  def create
    @detalle_datos_externo = DetalleDatosExterno.new(detalle_datos_externo_params)
    @detalle_datos_externo.estado = 'A'
    @detalle_datos_externo.user_created_id = current_user.id
    respond_to do |format|
      if @detalle_datos_externo.save
        format.html { redirect_to index_detalle_datos_externos_path, notice: "Detalle datos externo creado exitosamente." }
        format.json { render :show, status: :created, location: @detalle_datos_externo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @detalle_datos_externo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /detalle_datos_externos/1 or /detalle_datos_externos/1.json
  def update
    @detalle_datos_externo.user_updated_id = current_user.id
    @dato_externo_id = params[:datos_externo_id]
    respond_to do |format|
      if @detalle_datos_externo.update(detalle_datos_externo_params)
        format.html { redirect_to index_detalle_datos_externo_path(:dato_externo_id => @detalle_datos_externo.datos_externo.id), notice: "Detalle datos externo actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @detalle_datos_externo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @detalle_datos_externo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /detalle_datos_externos/1 or /detalle_datos_externos/1.json
  def destroy
    @detalle_datos_externo.destroy
    respond_to do |format|
      format.html { redirect_to index_detalle_datos_externos_path, notice: "Detalle datos externo inactivado exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detalle_datos_externo
      @detalle_datos_externo = DetalleDatosExterno.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def detalle_datos_externo_params
      params.require(:detalle_datos_externo).permit(:datos_externo_id, :nombre, :param1, :param2, :param3, :param4, :param5, :tipo, :body, :estado, :user_created_id, :user_updated_id, :datos_externo_id)
    end
end
