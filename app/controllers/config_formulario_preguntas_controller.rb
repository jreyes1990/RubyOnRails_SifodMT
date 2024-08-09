class ConfigFormularioPreguntasController < ApplicationController
  before_action :set_config_formulario_pregunta, only: %i[ show edit update destroy ]

  # GET /config_formulario_preguntas or /config_formulario_preguntas.json
  def index
    @config_formulario_preguntas = ConfigFormularioPregunta.all
  end

  # GET /config_formulario_preguntas/1 or /config_formulario_preguntas/1.json
  def show
  end

  # GET /config_formulario_preguntas/new
  def new
    @config_formulario_pregunta = ConfigFormularioPregunta.new
  end

  # GET /config_formulario_preguntas/1/edit
  def edit
  end

  # POST /config_formulario_preguntas or /config_formulario_preguntas.json
  def create
    @config_formulario_pregunta = ConfigFormularioPregunta.new(config_formulario_pregunta_params)

    respond_to do |format|
      if @config_formulario_pregunta.save
        format.html { redirect_to config_formulario_pregunta_url(@config_formulario_pregunta), notice: "Config formulario pregunta was successfully created." }
        format.json { render :show, status: :created, location: @config_formulario_pregunta }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @config_formulario_pregunta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /config_formulario_preguntas/1 or /config_formulario_preguntas/1.json
  def update
    respond_to do |format|
      if @config_formulario_pregunta.update(config_formulario_pregunta_params)
        format.html { redirect_to config_formulario_pregunta_url(@config_formulario_pregunta), notice: "Config formulario pregunta was successfully updated." }
        format.json { render :show, status: :ok, location: @config_formulario_pregunta }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @config_formulario_pregunta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /config_formulario_preguntas/1 or /config_formulario_preguntas/1.json
  def destroy
    @config_formulario_pregunta.destroy

    respond_to do |format|
      format.html { redirect_to config_formulario_preguntas_url, notice: "Config formulario pregunta was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_config_formulario_pregunta
      @config_formulario_pregunta = ConfigFormularioPregunta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def config_formulario_pregunta_params
      params.require(:config_formulario_pregunta).permit(:empresa_id, :area_id, :config_formulario_id, :config_pregunta_id, :config_sub_pregunta_id, :unidad_medida_id, :requerido, :posicion, :user_created_id, :user_updated_id, :usr_grab, :usr_modi, :estado)
    end
end
