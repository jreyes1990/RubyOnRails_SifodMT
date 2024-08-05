require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EjemploTemplate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    config.i18n.default_locale = :es
    config.active_record.default_timezone = :local
    config.time_zone = "Central America"

    config.session_store :active_record_store,
      :key => '_redmine_session'

    # Configuración para evitar la generación de archivos no deseados al generar scaffolds y controllers
    config.generators do |g|
      g.test_framework :rspec   # Especifica que el marco de pruebas utilizado es RSpec (en lugar de Minitest)
      g.helper false            # Evita la generación de archivos helper.
      g.assets false            # Evita la generación de archivos de assets (como CSS y JavaScript).
      g.view_specs false        # Evita la generación de archivos de prueba para vistas.
      g.helper_specs false      # Evita la generación de archivos de prueba para helpers.
      g.controller_specs false  # Evita la generación de archivos de prueba para controladores.
      g.models_specs false      # Evita la generación de modelos.
      g.requests_specs false    # Evita la generación de requests.
      g.routing_specs false     # Evita la generación de archivos de prueba para rutas.
      g.stylesheets false       # Evita la generación de archivos de estilos (CSS/SCSS).
      g.javascripts false       # Evita la generación de archivos de JavaScript.
      g.system_tests false      # Evita la generación de archivos de pruebas de sistema.
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

  end
end
