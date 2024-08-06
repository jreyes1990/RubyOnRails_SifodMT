module Utilidades
  require 'mini_magick'
  public

  def current_area_id_parametro
    parametros_area = Parametro.where(:user_id => current_user.id).first
    if (parametros_area != nil) then
      area_id = parametros_area.area_id
      return area_id
    else
      return area_id = ''
    end
  end

  def genera_bitacora(bitacora, ot_id, accion, descripcion, user)
    t = Time.now
    fechaHora = t.strftime("%d/%m/%Y %H:%M:%S")
    hora = t.strftime("%H:%M:%S")

    if bitacora == "ORDEN_TRABAJO"
      bita = BitacoraOt.new
      bita.orden_trabajo_id = ot_id

    elsif bitacora == "DETALLE_ORDEN_TRABAJO"
      bita = BitacoraDetalleOt.new
      bita.detalle_orden_trabajo_id = ot_id

    end
      bita.accion = accion
      bita.descripcion = descripcion
      bita.user = user
      bita.fecha = fechaHora
      bita.hora = hora
      bita.equipo = request.remote_ip
      bita.save
  end

  def genera_bitacora_movil(bitacora, persona_id, email, accion, descripcion)
    t = Time.now
    fechaHora = t.strftime("%d/%m/%Y")
    hora = t.strftime("%H:%M:%S")

      if bitacora == "GESTION_TOKEN"
        bita = BitacoraTokenPersona.new
      elsif bitacora == "AUTENTICACION_MOVIL"
        bita = BitacoraAutenticacionMovil.new
        bita.email = email
      elsif bitacora = "CONSULTA_MOVIL"
        bita = BitacoraConsultaMovil.new
      end

      bita.persona_id = persona_id
      bita.accion = accion
      bita.descripcion = descripcion
      bita.fecha = fechaHora
      bita.hora = hora
      bita.save


  end

  def custom_query(sql)
    results = ActiveRecord::Base.connection.exec_query(sql)

    if results.present?
      return results
    else
      return nil
    end
  end

  def anio_actual
    t = Time.now
    anio = t.strftime("%Y")
    return anio
  end

  def fecha_actual
    t = Time.now
    fecha = t.strftime("%d/%m/%Y")
    return fecha
  end

  def fecha_actual_ot
    t = Time.now
    fecha = t.strftime("%Y-%m-%d")
    return fecha
  end

  def current_empresa_id_permisos(persona_id)
    @persona = Persona.find(persona_id)
    id_empresa = 0
    @area = Area.joins("inner join personas_areas on personas_areas.area_id = areas.id
                            inner join personas on personas.id = personas_areas.persona_id
                            inner join empresas on empresas.id = areas.empresa_id
                            where personas.user_id = #{@persona.user_id}").first
    id_empresa = @area.empresa_id
    return id_empresa
  end

  def fecha_actual_ot
    t = Time.now
    fecha = t.strftime("%Y-%m-%d")
    return fecha
  end

  #reporteria
  def fecha_hora_actual
    t = Time.now
    fecha = t.strftime("%d/%m/%Y %H:%M:%S")
    return fecha
  end

  def ano_actual
    t = Time.now
    fecha = t.strftime("%Y")
    return fecha
  end

  def set_usr_grab(current_user)
    usr_grab = nil

    if current_user.present?
      usr_grab = "#{current_user.email.split('@').first.upcase.gsub('OPS$', '')}-#{Time.now.strftime('%d/%m/%Y %H:%M')}"
    else
      usr_grab = "SYSTEM-#{Time.now.strftime('%d/%m/%Y %H:%M')}"
    end

    return usr_grab
  end

  def set_usr_modi(current_user)
    usr_modi = nil

    if current_user.present?
      usr_modi = "#{current_user.email.split('@').first.upcase.gsub('OPS$', '')}-#{Time.now.strftime('%d/%m/%Y %H:%M')}"
    else
      usr_modi = "SYSTEM-#{Time.now.strftime('%d/%m/%Y %H:%M')}"
    end

    return usr_modi
  end

  def current_user_name_reportes
    persona = Persona.where("user_id = ? ", current_user.id).first
    if (persona != nil) then
        if (persona.nombre != nil || persona.apellido != nil )
        return persona.nombre.upcase + " " + persona.apellido.upcase

        else
            return current_user.email

        end
    else
        return current_user.email
    end
  end

  def response_api_ordencompra(url, autorizacion, orden_compra, user ,codigo_empresa)

    response = RestClient.get url, {Authorization: autorizacion , params: {orden_compra: orden_compra, user: user, codigo_empresa: codigo_empresa}}

    if response.present?
      return response
    else
      return nil
    end
  end

  # Tamaño a imagen
  def resize_image(image, width, height)
    image = MiniMagick::Image.new(image.tempfile.path)
    image.resize "#{width}x#{height}"
    image
  end

  # Convertir imagen a base64 "CLOB"
  def convert_to_clob(image)
    base64_image = Base64.encode64(image.to_blob)
    "data:image/png;base64,#{base64_image}"
  end

  def format_estado(status, convertir="N")
    if status == "A"
      badge_estado = "badge badge-success"
      nombre_estado = convertir=="N" ? "Activo" : convertir=="S" ? "Activo".upcase : "No Aplica"
    elsif status == "I"
      badge_estado = "badge badge-danger"
      nombre_estado = convertir=="N" ? "Inactivo" : convertir=="S" ? "Inactivo".upcase : "No Aplica"
    end

    return "<div class='text-center'><span class='#{badge_estado}'>#{nombre_estado}</span></div>".html_safe
  end

  def desc_estado(status)
    descripcion_estado = nil

    if status == "A"
      descripcion_estado = "ACTIVO"
    elsif status == "I"
      descripcion_estado = "INACTIVO"
    elsif status == "C"
      descripcion_estado = "CANCELADO"
    elsif status == "P"
      descripcion_estado = "EN PROCESO"
    elsif status == "F"
      descripcion_estado = "FINALIZADO"
    end
  end

  def valida_pregunta(valor)
    if valor == 'N' || valor == false
      respuesta = 'NO'
    elsif valor == 'S' || valor == true
      respuesta = 'SI'
    end

    return respuesta
  end

  def format_digitos(correlativo, formato)
    if !correlativo.nil?
      respuesta = correlativo.to_s.rjust(formato,"0")
    end

    return respuesta
  end

  def generate_temp_password(length = 12)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a + %w(! @ # $ % & *)
    password = Array.new(length) { chars.sample }.join
    password
  end

  def genera_bitacora_catalogos(id_empresa, nombre_catalogo)

    t = Time.now
    # fechaHora = t.strftime("%d/%m/%Y")
    # hora = t.strftime("%H:%M:%S")
    bitacora_carga_catalogo = BitacoraCargaCatalogo.new
    bitacora_carga_catalogo.nombre_catalogo = nombre_catalogo
    bitacora_carga_catalogo.fecha_carga = t
    bitacora_carga_catalogo.id_empresa = id_empresa
    bitacora_carga_catalogo.user_created_id = current_user.id
    bitacora_carga_catalogo.estado = 'A'
    bitacora_carga_catalogo.save

    return bitacora_carga_catalogo.id
  end

  def genera_det_bitacora_catalogos(id_empresa, bita_id, codigo, descripcion)
    puts "ENTRO A GENERAR DETALLE"
    puts "ID EMPRESA: #{id_empresa}"
    puts "ID BITACORA: #{bita_id}"
    puts "CODIGO: #{codigo}"
    puts "DESCRIPCION: #{descripcion}"
    puts "USER CREATED: #{current_user.id}"
    begin
      det_bitacora_carga_catalogo = DetBitacoraCargaCatalogo.new
      det_bitacora_carga_catalogo.bitacora_carga_catalogos_id = bita_id
      det_bitacora_carga_catalogo.codigo = codigo
      det_bitacora_carga_catalogo.descripcion = descripcion
      det_bitacora_carga_catalogo.id_empresa = id_empresa
      det_bitacora_carga_catalogo.user_created_id = current_user.id
      det_bitacora_carga_catalogo.estado = 'A'
      det_bitacora_carga_catalogo.save
    rescue Exception => e
      puts "ERROR: #{e.message}"
    ensure

    end

  end

end
