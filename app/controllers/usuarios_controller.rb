class UsuariosController < ApplicationController
  include ManageStatus
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  before_action :comprobar_permiso

  def index
    @personas = Persona.select("personas.*, users.password_changed as cambio_password, users.sign_in_count, users.current_sign_in_at, users.last_sign_in_at, users.current_sign_in_ip, users.last_sign_in_ip").joins(:user).order("personas.id")
  end

  def search_area_empresa_usuario
    if params[:search_empresa_usuario_params].present?
      parametro = params[:search_empresa_usuario_params].upcase

      @empresa =  Empresa.where("(upper(id|| ' ' ||nombre) like upper('%#{parametro}%')) and estado = 'A' ").limit(50).distinct

      respond_to do |format|
        format.json { render json: @empresa.map { |p| { valor_id: p.id, valor_text: p.informacion_empresa } } }
      end
    elsif params[:empresa_usuario_params].present?
      empresa_id = params[:empresa_usuario_params]

      @area =  Area.joins("inner join empresas on (areas.empresa_id = empresas.id)")
                      .where("areas.empresa_id = #{empresa_id} and areas.estado = 'A'").limit(50).distinct

      respond_to do |format|
        format.json {
          render json: {
            area_empresa: @area.map { |p| { valor_id: p.id, valor_text: p.area_con_codigo } }
          }
        }
      end
    end
  end

  def new
    @usuario = User.new
    @persona = Persona.new
    @persona_areas = PersonasArea.new
  end

  def agregar_usuario
    @empresa = Empresa.where(:estado =>'A').limit(10)
    @usuario = User.new
    @persona = Persona.new
    @persona_areas = PersonasArea.new
  end

  def crear_usuario
    @usuario = User.new(usuario_params)
    @usuario.password = generate_temp_password
    @nombre_completo = params[:usuario_form][:nombre] + " " + params[:usuario_form][:apellido]

    ActiveRecord::Base.transaction do
      guardar_con_manejo_de_excepciones(@usuario, "No se pudo crear el usuario", "Error de base de datos al crear el usuario")

      @persona = Persona.new(persona_params)
      @persona.user_id = @usuario.id

      guardar_con_manejo_de_excepciones(@persona, "No se pudo crear la persona", "Error de base de datos al crear la persona")

      @persona_areas = PersonasArea.new(persona_area_params)
      @persona_areas.persona_id = @persona.id
      @persona_areas.area_id = params[:usuario_form][:area_id]

      guardar_con_manejo_de_excepciones(@persona_areas, "No se pudo asignar la persona a una área", "Error de base de datos al asignar a la persona a una área")

      respond_to do |format|
        # Envío de correo electrónico
        UserMailer.registro_exitoso(@nombre_completo, @usuario.password, @usuario.email).deliver_now
        format.html { redirect_to usuarios_index_path, notice: "El usuario [ <strong>#{@nombre_completo.upcase}</strong> ] se ha creado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: usuarios_index_path }
      end
    end
  end

  private
    def set_usuario
    end

    def usuario_params
      params.require(:usuario_form).permit(:email, :password, :user_created_id, :estado)
    end

    def persona_params
      params.require(:usuario_form).permit(:user_id, :nombre, :apellido, :telefono, :direccion, :user_created_id, :estado)
    end

    def persona_area_params
      params.require(:usuario_form).permit(:persona_id, :area_id, :rol_id, :user_created_id, :estado)
    end
end
