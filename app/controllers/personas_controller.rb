class PersonasController < ApplicationController
  include ManageStatus
  before_action :set_persona, only: [:show, :edit, :update, :destroy]
  # before_action :comprobar_permiso

  def show
      @empresa = Empresa.joins("inner join areas on empresas.id = areas.empresa_id
                                inner join personas_areas on personas_areas.area_id = areas.id
                                inner join personas on personas_areas.persona_id = personas.id
                                WHERE
                                personas.id = #{@persona.id}
                                and areas.empresa_id = #{current_user_empresa_id}").first

      @areas = Area.joins(" inner join empresas on empresas.id = areas.empresa_id
                            inner join personas_areas on personas_areas.area_id = areas.id
                            inner join personas on personas_areas.persona_id = personas.id
                            WHERE
                            personas.id = #{@persona.id}
                            and areas.empresa_id = #{current_user_empresa_id}").all

      @nombresAreas = ""

      @areas.each do |a|

        if @areas.count == 1
        @nombresAreas = @nombresAreas + a.nombre
        elsif @nombresAreas == ""
        @nombresAreas = @nombresAreas + a.nombre + ','
        else
        @nombresAreas = @nombresAreas+ ', ' + a.nombre
        end
        @nombresAreas.sub!(',,', ',')

        end
      end

  def edit
  end

  #Proceso para actualizar una persona
  def update
    image_data = params[:persona][:foto]


    if image_data.present?
      resized_image = resize_image(image_data, 300, 180)  # Tamaño deseado: 800x600
      @persona.foto = convert_to_clob(resized_image)
      puts "DATO DE LA FOTO: #{@persona.foto.inspect}"
    end

    respond_to do |format|
      if image_data.present?
        if @persona.save
          format.html { redirect_to @persona, notice: 'La imagen de la persona se ha creado correctamente' }
          format.json { render :show, status: :ok, location: @persona }
        else
          format.html { render :edit }
          format.json { render json: @persona.errors, status: :unprocessable_entity }
        end
      else
        if @persona.update(persona_params)
          format.html { redirect_to @persona, notice: 'Persona modficada' }
          format.json { render :show, status: :ok, location: @persona }
        else
          format.html { render :edit }
          format.json { render json: @persona.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  #Proceso para inactivar una persona
  def inactivar
    begin
      ActiveRecord::Base.transaction do
        change_status_to("I", Persona, params[:id])

        @persona = Persona.find(params[:id])
        @nombre_completo = @persona.nombre + " " + @persona.apellido
        @usuario = User.find(@persona.user_id)
        change_status_to("I", User, @usuario.id)
      end

      respond_to do |format|
        format.html { redirect_to usuarios_index_path, notice: "El usuario [ <strong>#{@nombre_completo.upcase}</strong> ] se ha inactivado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @persona }
      end
    rescue ActiveRecord::RecordNotFound => e
      handle_standard_error(e, usuarios_index_path)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid => e
      handle_standard_error(e, usuarios_index_path)
    rescue StandardError => e
      handle_standard_error(e, usuarios_index_path)
    end
  end

  def activar
    begin
      ActiveRecord::Base.transaction do
        change_status_to("A", Persona, params[:id])

        @persona = Persona.find(params[:id])
        @nombre_completo = @persona.nombre + " " + @persona.apellido
        @usuario = User.find(@persona.user_id)
        change_status_to("A", User, @usuario.id)
      end

      respond_to do |format|
        format.html { redirect_to usuarios_index_path, notice: "El usuario [ <strong>#{@nombre_completo.upcase}</strong> ] se ha activado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @persona }
      end
    rescue ActiveRecord::RecordNotFound => e
      handle_standard_error(e, usuarios_index_path)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid => e
      handle_standard_error(e, usuarios_index_path)
    rescue StandardError => e
      handle_standard_error(e, usuarios_index_path)
    end
  end

  def conservar_password
    begin
      @persona = Persona.find(params[:id])
      @persona.user_updated_id = current_user.id

      ActiveRecord::Base.transaction do
        guardar_con_manejo_de_excepciones(@persona, "No se pudo actualizar los datos del usuario", "Error de base de datos al actualizar los datos del usuario")

        @usuario = User.find(@persona.user_id)
        @usuario.password_changed = 't' || true
        @usuario.user_updated_id = current_user.id
        guardar_con_manejo_de_excepciones(@usuario, "No se pudo conservar la contraseña del usuario", "Error de base de datos al conservar la contraseña del usuario")

        respond_to do |format|
          format.html { redirect_to usuarios_index_path, notice: "Se ha restablecido a las credenciales actuales" }
          format.json { render :show, status: :ok, location: @personas }
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      handle_standard_error(e, usuarios_index_path)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid => e
      handle_standard_error(e, usuarios_index_path)
    rescue StandardError => e
      handle_standard_error(e, usuarios_index_path)
    end
  end

  def remitente_email
    @persona = Persona.find(params[:id])
    @usuario = User.find(@persona.user_id)
    @usuario.password = generate_temp_password
    @usuario.user_updated_id = current_user.id
    @nombre_completo = @persona.nombre + " " + @persona.apellido
    @bandera_estado_password = params[:flag_cambio_password].to_i

    if @bandera_estado_password == 1
      @usuario.password_changed = "f" || false
    end

    begin
      ActiveRecord::Base.transaction do
        guardar_con_manejo_de_excepciones(@usuario, "No se pudo generar las credenciales del usuario", "Error de base de datos al generar las credenciales del usuario")

        respond_to do |format|
          # Envío de correo electrónico
        UserMailer.registro_exitoso(@nombre_completo, @usuario.password, @usuario.email).deliver_now
          format.html { redirect_to usuarios_index_path, notice: "Las credenciales del usuario [ <strong>#{@nombre_completo.upcase}</strong> ] se ha generado y enviado exitosamente".html_safe }
          format.json { render :show, status: :ok, location: @usuario }
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      handle_standard_error(e, usuarios_index_path)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid => e
      handle_standard_error(e, usuarios_index_path)
    rescue StandardError => e
      handle_standard_error(e, usuarios_index_path)
    end
  end

  def modal_edit_email
    @datos_persona = Persona.find(params[:id])
    @datos_usuario = User.find(@datos_persona.user_id)

    puts "=================================="
    puts @datos_persona.inspect
    puts @datos_usuario.inspect
    puts "=================================="

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update_email
    begin
      ActiveRecord::Base.transaction do
        @persona = Persona.find(params[:id])
        @usuario = User.find(@persona.user_id)

        actualizar_con_manejo_de_excepciones(@usuario, user_params, "No se pudo actualizar el correo del usuario", "Error de base de datos al actualizar el correo del usuario")

        respond_to do |format|
          format.html { redirect_to usuarios_index_path, notice: "El correo electronico del usuario [ <strong>#{@persona.nombre.upcase} #{@persona.apellido.upcase}</strong> ] se ha actualizado correctamente.".html_safe }
          format.json { render :show, status: :ok, location: usuarios_index_path }
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      handle_standard_error(e, usuarios_index_path)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid => e
      handle_standard_error(e, usuarios_index_path)
    rescue StandardError => e
      handle_standard_error(e, usuarios_index_path)
    end
  end

  def modal_cambiar_contrasena
    @persona_id = params[:persona_id]

    respond_to do |format|
      format.html
      format.js
    end
  end

  def registrar_cambio_contrasena
    contrasena_nueva = params[:cambio_contrasena_form][:password_nueva]
    confirma_contrasena = params[:cambio_contrasena_form][:password_confirmada]
    @user = User.find(current_user.id)

    respond_to do |format|
      if contrasena_nueva == confirma_contrasena
        contrasena_nueva_encriptada = BCrypt::Password.create(contrasena_nueva)
        @user.encrypted_password = contrasena_nueva_encriptada

        if @user.save
          format.html { redirect_to persona_path(current_user.persona), notice: "Contraseña actualizada correctamente." }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { redirect_to persona_path(current_user.persona), alert: "Error al actualizar la contraseña." }
          format.json { render :show, status: :created, location: @user }
        end
      else
        format.html { redirect_to persona_path(current_user.persona), alert: "Las nueva contraseña y la confirmación no coinciden, intente de nuevo." }
        format.json { render :show, status: :created, location: @user }
      end
    end
  end

  def generate_token
    loop do
        token = SecureRandom.hex
        return token unless Persona.exists?({token: token})
    end
  end

  def registrar_token_persona

    validacion = params[:validacion]
    persona = Persona.find(params[:persona_id])
        if validacion == "ACTIVAR"
          token = generate_token
          persona.token = token
        else validacion == "DESACTIVAR"
          persona.token = ""
        end

      respond_to do |format|
        if persona.save
          genera_bitacora_movil("GESTION_TOKEN", params[:persona_id], "" , "SE PROCEDE A #{validacion}, TOKEN PARA APLICACIÓN MÓVIL", token)
          format.html { redirect_to persona_path(current_user.persona), notice: "Token para Aplicación Móvil Actualizado correctamente." }
          format.json { render :show, status: :created, location: persona }
        else
          format.html { redirect_to persona_path(current_user.persona), notice: "Error al generar token para aplicación Móvil." }
          format.json { render :show, status: :created, location: persona }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_persona
      @persona = Persona.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def persona_params
      params.require(:persona).permit(:foto, :nombre, :apellido, :direccion, :telefono, :user_updated_id)
    end

    def user_params
      params.require(:user).permit(:email)
    end
end
