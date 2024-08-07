json.extract! config_pregunta, :id, :empresa_id, :area_id, :tipo_campo_id, :nombre, :descripcion, :tiene_parametro, :tiene_sub_pregunta, :user_created_id, :user_updated_id, :usr_grab, :usr_modi, :estado, :created_at, :updated_at
json.url config_pregunta_url(config_pregunta, format: :json)
