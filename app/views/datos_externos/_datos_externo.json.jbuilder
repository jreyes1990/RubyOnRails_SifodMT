json.extract! datos_externo, :id, :nombre, :url_api, :token, :estado, :user_created_id, :user_updated_id, :created_at, :updated_at
json.url datos_externo_url(datos_externo, format: :json)
