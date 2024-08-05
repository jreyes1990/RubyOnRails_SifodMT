json.extract! opcion, :id, :nombre, :descripcion, :icono, :path, :controlador, :estado, :menu_id, :user_created_id, :user_updated_id, :created_at, :updated_at
json.url opcion_url(opcion, format: :json)
