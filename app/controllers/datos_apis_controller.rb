class DatosApisController < ApplicationController
  before_action :set_datos_api, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /datos_apis or /datos_apis.json
  def index
    @datos_apis = DatosApi.where('estado = ?', 'A')
  end

  # GET /datos_apis/1 or /datos_apis/1.json
  def show
  end

  # GET /datos_apis/new
  def new
    @datos_api = DatosApi.new
  end

  # GET /datos_apis/1/edit
  def edit
  end

  # POST /datos_apis or /datos_apis.json
  def create
    @datos_api = DatosApi.new(datos_api_params)
    @datos_api.estado = 'A'
    @datos_api.user_created_id = current_user.id

    respond_to do |format|
      if @datos_api.save
        format.html { redirect_to datos_apis_path, notice: "Dato de API creado exitosamente." }
        format.json { render :show, status: :created, location: @datos_api }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @datos_api.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datos_apis/1 or /datos_apis/1.json
  def update
    respond_to do |format|
      @datos_api.user_updated_id = current_user.id
      if @datos_api.update(datos_api_params)
        format.html { redirect_to datos_api_url(@datos_api), notice: "Datos API actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @datos_api }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @datos_api.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datos_apis/1 or /datos_apis/1.json
  def destroy
    @datos_api.destroy

    respond_to do |format|
      format.html { redirect_to datos_apis_url, notice: "Datos API inactivado exitosamente." }
      format.json { head :no_content }
    end
  end

  def index_detalle_datos_api
    datos_api_id = params[:datos_api_id]
    @datos_api = DatosApi.find(datos_api_id)
    @detalle_datos_api = DetalleDatosApi.where('estado =? and datos_api_id =?', 'A', datos_api_id )
  end 

  def nuevo_detalle_datos_api
    datos_api_id = params[:id]
    @datos_api = DatosApi.find(datos_api_id)
  end 

  def registro_detalle_dato_api
    @detalle_datos_api = DetalleDatosApi.new(detalle_datos_api_params)
    @detalle_datos_api.estado = 'A'
    @detalle_datos_api.user_created_id = current_user.id

    respond_to do |format|
      if @detalle_datos_api.save
        format.html { redirect_to index_detalle_datos_api_path(:datos_api_id => params[:nuevo_detalle_dato_api][:datos_api_id]), notice: "Detalle de API creado exitosamente." }
        format.json { render :show, status: :created, location: @detalle_datos_api }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @detalle_datos_api.errors, status: :unprocessable_entity }
      end
    end
  end 

  def editar_detalle_datos_api
    detalle_datos_api_id = params[:id]
    @detalle_datos_api = DetalleDatosApi.find(detalle_datos_api_id)


  end 

  def actualizar_detalle_dato_api

    @detalle_dato_api = DetalleDatosApi.find(params[:editar_detalle_dato_api][:datos_api_id])
    @detalle_dato_api.nombre = params[:editar_detalle_dato_api][:nombre]
    @detalle_dato_api.param1 = params[:editar_detalle_dato_api][:param1]
    @detalle_dato_api.param2 = params[:editar_detalle_dato_api][:param2]
    @detalle_dato_api.param3 = params[:editar_detalle_dato_api][:param3] 
    @detalle_dato_api.param4 = params[:editar_detalle_dato_api][:param4]
    @detalle_dato_api.param5 = params[:editar_detalle_dato_api][:param5]
    @detalle_dato_api.tipo = params[:editar_detalle_dato_api][:tipo]
    @detalle_dato_api.body = params[:editar_detalle_dato_api][:body]
    @detalle_dato_api.user_updated_id = current_user.id

    respond_to do |format|
      if @detalle_dato_api.save
        format.html { redirect_to index_detalle_datos_api_path(:datos_api_id => params[:editar_detalle_dato_api][:datos_api_id]), notice: "Detalle de API actualizado exitosamente." }
        format.json { render :show, status: :created, location: @detalle_dato_api }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @detalle_dato_api.errors, status: :unprocessable_entity }
      end
    end 
  end
  
  def inactivar_detalle_datos_api
    detalle_datos_api_id = params[:id]
    @detalle_dato_api = DetalleDatosApi.find(detalle_datos_api_id)

    @detalle_dato_api.estado = 'I'
    @detalle_dato_api.user_updated_id = current_user.id

    respond_to do |format|
      if @detalle_dato_api.save
        format.html { redirect_to index_detalle_datos_api_path(:datos_api_id => @detalle_dato_api.datos_api_id), notice: "Detalle de API inactivado exitosamente." }
        format.json { render :show, status: :created, location: @detalle_dato_api }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @detalle_dato_api.errors, status: :unprocessable_entity }
      end
    end 
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datos_api
      @datos_api = DatosApi.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def datos_api_params
      params.require(:datos_api).permit(:nombre, :url_api, :token, :estado, :user_created_id, :user_updated_id)
    end

    def detalle_datos_api_params
      params.require(:nuevo_detalle_dato_api).permit(:datos_api_id, :nombre, :param1, :param2, :param3, :param4, :param5, :tipo, :body)
    end

    def editar_detalle_datos_api_params
      params.require(:editar_detalle_dato_api).permit(:datos_api_id, :nombre, :param1, :param2, :param3, :param4, :param5, :tipo, :body)
    end
end
