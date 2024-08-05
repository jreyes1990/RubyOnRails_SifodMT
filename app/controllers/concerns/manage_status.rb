# app/controllers/concerns/manage_status.rb
module ManageStatus
  extend ActiveSupport::Concern
  include Utilidades
  include ExceptionHandler

  def change_status_to(status_description, model, params_id, redirect_to_path = nil)
    record = model.find(params_id)
    record.user_updated_id = current_user.id
    record.estado = status_description

    begin
      ActiveRecord::Base.transaction do
        guardar_con_manejo_de_excepciones(record, "No se pudo actualizar el estado", "Error de base de datos al actualizar el estado del registro")

        unless redirect_to_path.nil?
          respond_to do |format|
            format.html { redirect_to redirect_to_path, notice: "El registro ha cambiado a estado #{desc_estado(record.estado)}".html_safe }
            format.json { render :show, status: :created, location: record }
          end
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      handle_standard_error(e, redirect_to_path)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid => e
      handle_standard_error(e, redirect_to_path)
    rescue StandardError => e
      handle_standard_error(e, redirect_to_path)
    end

    # respond_to do |format|
    #   begin
    #     ActiveRecord::Base.transaction do
    #       guardar_con_manejo_de_excepciones(record, "No se pudo actualizar el estado", "Error de base de datos al actualizar el estado del registro")
    #       format.html { redirect_to redirect_to_path, notice: "El registro ha cambiado a estado #{desc_estado(record.estado)}".html_safe }
    #       format.json { render :show, status: :created, location: record }
    #     end
    #   rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid => e
    #     Rails.logger.error("ERROR EN CONSOLA: #{e.message}")
    #     flash[:error] = e.message
    #     format.html { redirect_to redirect_to_path }
    #     format.json { render json: { error: e.message }, status: :unprocessable_entity }
    #   rescue StandardError => e
    #     Rails.logger.error("ERROR EN CONSOLA: #{e.message}")
    #     flash[:error] = e.message
    #     format.html { redirect_to redirect_to_path }
    #     format.json { render json: { error: e.message }, status: :unprocessable_entity }
    #   end
    # end
  end

  def guardar_con_manejo_de_excepciones(registro, mensaje_error, mensaje_error_bd)
    begin
      registro.save!
    rescue ActiveRecord::RecordInvalid => e
      raise StandardError.new("#{mensaje_error}: #{e.message}")
    rescue ActiveRecord::StatementInvalid => e
      raise StandardError.new("#{mensaje_error_bd}: #{e.message}")
    end
  end

  def actualizar_con_manejo_de_excepciones(registro, atributos, mensaje_error, mensaje_error_bd)
    begin
      registro.update!(atributos)
    rescue ActiveRecord::RecordInvalid => e
      raise StandardError.new("#{mensaje_error}: #{e.message}")
    rescue ActiveRecord::StatementInvalid => e
      raise StandardError.new("#{mensaje_error_bd}: #{e.message}")
    end
  end
end
