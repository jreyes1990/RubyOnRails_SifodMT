class UserMailer < ApplicationMailer
  before_action :set_base_url

  def set_base_url
    if Rails.env.development?
      @base_url = 'http://localhost:3000'
      @from_url = 'developer.madretierragt@gmail.com'
    else
      @base_url = 'https://poscoope.sistemasmt.com.gt'
      @from_url = 'sistemas@madretierra.com.gt'
    end
  end

  def registro_exitoso(usuario, temp_password, correo_electronico)
    initialize_email_variables(usuario, temp_password, correo_electronico)
    mail(to: correo_electronico, from: @from_url, subject: 'Bienvenido a sistema de formularios de calidad: tus credenciales de acceso.')
  end

  def remitente_exitoso(usuario, temp_password, correo_electronico)
    initialize_email_variables(usuario, temp_password, correo_electronico)
    mail(to: @email, from: @from_url, subject: 'Bienvenido a sistema de proyectos y actividades: tus credenciales de acceso.')
  end

  private

  def initialize_email_variables(usuario, temp_password, correo_electronico)
    @usuario = usuario
    @temp_password = temp_password
    @correo_electronico = correo_electronico
    @ruta_url = "#{@base_url}/users/sign_in"
    @titulo_correo = "sistema de formularios de calidad - SIFOC"
    @titulo_bienvenida = "Bienvenido, #{@usuario}, a #{@titulo_correo}."
    @logo_correo = ""
  end
end
