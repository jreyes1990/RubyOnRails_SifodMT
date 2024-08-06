json.extract! tipo_formulario, :id, :empresa_id, :area_id, :nombre, :descripcion, :user_created_id, :user_updated_id, :usr_grab, :usr_modi, :estado, :created_at, :updated_at
json.url tipo_formulario_url(tipo_formulario, format: :json)
