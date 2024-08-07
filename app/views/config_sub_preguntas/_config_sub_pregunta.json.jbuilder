json.extract! config_sub_pregunta, :id, :empresa_id, :area_id, :nombre, :descripcion, :user_created_id, :user_updated_id, :usr_grab, :usr_modi, :estado, :created_at, :updated_at
json.url config_sub_pregunta_url(config_sub_pregunta, format: :json)
