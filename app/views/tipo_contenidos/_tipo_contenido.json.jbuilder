json.extract! tipo_contenido, :id, :nombre, :content_type, :user_created_id, :user_updated_id, :usr_grab, :usr_modi, :estado, :created_at, :updated_at
json.url tipo_contenido_url(tipo_contenido, format: :json)
