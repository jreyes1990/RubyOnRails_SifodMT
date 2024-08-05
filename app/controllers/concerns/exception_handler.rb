module ExceptionHandler
  extend ActiveSupport::Concern # Facilita la inclusión de métodos y bloques de código en otros módulos o clases.

  included do # Se ejecuta cuando el módulo se incluye en otra clase (como un controlador). Dentro de este bloque, definimos qué excepciones rescatar y cómo manejarlas.
    # Indica que si se lanza una excepción ActiveRecord::RecordInvalid, se llamará al método handle_record_invalid.
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
    # Indica que si se lanza una excepción ActiveRecord::StatementInvalid, se llamará al método handle_statement_invalid.
    rescue_from ActiveRecord::StatementInvalid, with: :handle_statement_invalid
  end

  private
    def handle_record_invalid(exception)
      respond_to do |format|
        puts "======================================================================================================================================"
        Rails.logger.error("ERROR EN CONSOLA: #{exception.message}")
        puts "======================================================================================================================================"
        flash[:error] = exception.message
        format.html { render appropriate_template, status: :unprocessable_entity }
        format.json { render json: { error: exception.message }, status: :unprocessable_entity }
      end
    end

    def handle_statement_invalid(exception)
      respond_to do |format|
        puts "======================================================================================================================================"
        Rails.logger.error("ERROR EN CONSOLA: #{exception.message}")
        puts "======================================================================================================================================"
        flash[:error] = exception.message
        format.html { render appropriate_template, status: :unprocessable_entity }
        format.json { render json: { error: exception.message }, status: :unprocessable_entity }
      end
    end

    def handle_standard_error(exception, redirect_to_path)
      respond_to do |format|
        puts "======================================================================================================================================"
        Rails.logger.error("ERROR EN CONSOLA: #{exception.message}")
        puts "======================================================================================================================================"
        flash[:error] = exception.message
        format.html { redirect_to redirect_to_path }
        format.json { render json: { error: exception.message }, status: :unprocessable_entity }
      end
    end

    def appropriate_template
      if action_name == 'crear_usuario'
        :agregar_usuario
      else
        action_name == 'create' ? :new : :edit
      end
    end
end
