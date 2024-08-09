source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>=2.7.2'

#oracle
gem "ruby-oci8"
gem "ruby-plsql"
gem "activerecord-oracle_enhanced-adapter"
gem 'composite_primary_keys'

#PostreSql
gem 'pg'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
#gem 'rails', '~> 6.0.6', '>= 6.0.6.1'
gem 'rails', '~> 6.0.4', '>= 6.0.4.1'

# gema para manejo de sessiones
gem 'activerecord-session_store'

#consumir API
gem 'rest-client', '~> 2.1'

# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

#Generación de reportes PDF
gem 'wicked_pdf'

#Generacion de codigos QR
gem 'rqrcode'

gem 'wkhtmltopdf-binary'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

#Usa devise para administrar la autenticación
gem 'devise'
gem 'devise-security'

gem 'wdm', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Uso para manejo de fotografias,  Enlace:  https://github.com/carrierwaveuploader/carrierwave
gem 'carrierwave'

#Usa para pasar variables de controlador a javascript
gem 'gon'

#gem 'active_admin_datetimepicker'

gem 'ajax-datatables-rails'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-livereload', require: false
  gem 'annotate'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper', '1.2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'simple_form'
gem 'seed_dump'

gem "net-http"
gem 'net-ssh', '>= 6.0.2'
gem 'ed25519', '>= 1.2', '< 2.0'
gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
gem 'scenic-oracle_adapter'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'
# GEMA PARA IMAGEN
gem 'mini_magick'

# Leer correos electronicos sin tener que enviarlos
gem "letter_opener", group: :development

#GEMAS PARA GENERACION DE EXCELES
gem 'caxlsx'
gem 'caxlsx_rails'

#GEMA PARA PROCESAMIENTO DE ARCHIVOS EXCEL
gem "roo"

# GEMA PARA USAR BOOTSTRAP SWITCH CON SIMPLE_FORM
gem 'bootstrap-toggle-rails'

gem 'cocoon'