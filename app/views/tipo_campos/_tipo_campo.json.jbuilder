json.extract! tipo_campo, :id, :nombre, :tipo_dato, :descripcion, :tiene_respuesta, :tipo_seleccion_id, :tipo_contenido_id, :user_created_id, :user_updated_id, :usr_grab, :usr_modi, :estado, :created_at, :updated_at
json.url tipo_campo_url(tipo_campo, format: :json)
