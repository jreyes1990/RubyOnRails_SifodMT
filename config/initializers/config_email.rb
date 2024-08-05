Rails.application.configure do
  if Rails.env.development?
    @base_domain = "gmail.com"
    @base_user_name = "developer.madretierragt@gmail.com"
    @base_password = "wkozbnzuwkmrgzmc"
    @base_host = "http://localhost:3000"
  else
    @base_domain = "madretierra.com.gt"
    @base_user_name = "sistemas@madretierra.com.gt"
    @base_password = "victorinox123"
    @base_host = "https://sifod.sistemasmt.com.gt"
  end

  config.action_mailer.perform_caching = false
  config.assets.raise_runtime_errors = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp      # Establece el método de entrega de correo electrónico, en este caso, SMTP
  config.action_mailer.default :charset => "utf-8"
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",                      # Reemplaza con la dirección del servidor SMTP que utilizarás
    port: 587,                                      # Reemplaza con el puerto adecuado
    domain: @base_domain,                           # Reemplaza con tu propio dominio
    user_name: @base_user_name,
    password: @base_password,
    authentication: "plain",
    enable_starttls_auto: true,
    openssl_verify_mode: "none"
  }

  config.action_mailer.default_url_options = { host: @base_host }
end