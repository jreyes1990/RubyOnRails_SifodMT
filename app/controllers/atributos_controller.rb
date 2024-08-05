class AtributosController < ApplicationController
  before_action :set_atributo, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /atributos or /atributos.json
  def index
    @atributos = Atributo.where(:estado => 'A').order(:id)
  end

  # GET /atributos/1 or /atributos/1.json
  def show
  end

  # GET /atributos/new
  def new
    @atributo = Atributo.new
  end

  # GET /atributos/1/edit
  def edit
  end

  # POST /atributos or /atributos.json
  def create
    @atributo = Atributo.new(atributo_params)
    @atributo.estado = "A"
    @atributo.user_created_id = current_user.id

    respond_to do |format|
      if @atributo.save
        format.html { redirect_to atributos_path, notice: "Atributo creado" }
        format.json { render :show, status: :created, location: @atributo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @atributo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /atributos/1 or /atributos/1.json
  def update
    @atributo.user_updated_id = current_user.id
    respond_to do |format|
      if @atributo.update(atributo_params)
        format.html { redirect_to atributos_path, notice: "Atributo actualizado" }
        format.json { render :show, status: :ok, location: @atributo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @atributo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /atributos/1 or /atributos/1.json
  def destroy
    @atributo.destroy
    respond_to do |format|
      format.html { redirect_to atributos_url, notice: "Atributo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

# Inactivar atributos
def inactivar_atributo
  @atributo = Atributo.find(params[:id])
  @atributo.user_updated_id = current_user.id
  @atributo.estado = "I"
  respond_to do |format|
    if @atributo.save
      format.html { redirect_to atributos_path, notice: "Atributo Inctivado" }
      format.json { render :show, status: :created, location: @atributo }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @atributo.errors, status: :unprocessable_entity }
    end
  end

end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_atributo
      @atributo = Atributo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def atributo_params
      params.require(:atributo).permit(:nombre, :descripcion, :estado, :user_created_id, :user_updated_id)
    end
end
