json.extract! datos_api, :id, :nombre, :url_api, :token, :estado, :user_created_id, :user_updated_id, :created_at, :updated_at
json.url datos_api_url(datos_api, format: :json)
