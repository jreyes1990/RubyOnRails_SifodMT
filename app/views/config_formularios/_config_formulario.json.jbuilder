json.extract! config_formulario, :id, :empresa_id, :area_id, :tipo_formulario_id, :nombre, :descripcion, :tiene_app_siga, :labor_id, :documento_iso_id, :user_created_id, :user_updated_id, :usr_grab, :usr_modi, :estado, :created_at, :updated_at
json.url config_formulario_url(config_formulario, format: :json)
