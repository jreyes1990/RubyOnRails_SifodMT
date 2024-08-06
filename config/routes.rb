Rails.application.routes.draw do
  resources :tipo_campos
  #Manejo de gema Devise
  devise_for :users
  root 'home#index'
  get 'home/index'
  get 'home/mostrar/:id' => "home#mostrar_parametro", as: 'mostrar_parametro'
  post 'home/cambio_password_user' => "home#cambio_password_user", as: 'cambio_password_user'
  get "salir/modal_salir" => "home#modal_salir", as: "modal_salir"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "/admin", :path_names => {new: 'n', edit: 'e'} do
    resources :persona_empresa_formularios
    get "permisos/" => "persona_empresa_formularios#index_permisos", :as => "permisos"
    post "persona_empresa_formularios/consulta_permisos"
    get "/permisos/search" => "persona_empresa_formularios#search_usuario", as: "search_usuarios"
    get "/permisos/show" => "persona_empresa_formularios#mostrar_permisos", as: "mostrar_permisos"
    get "/permisos/add" => "persona_empresa_formularios#agregar_permiso", as: "agregar_permisos"
    get "/permisos/showadd" => "persona_empresa_formularios#mostrar_agregar_permisos", as: "mostrar_agregar_permisos"
    post "persona_empresa_formularios/guardar_permisos"
    get "/permisos/opc_perfil" => "persona_empresa_formularios#obtener_opciones_por_perfil", as: "obtener_opciones_por_perfil"
    get "/permisos/opc_individual" => "persona_empresa_formularios#obtener_opciones_por_individual", as: "obtener_opciones_por_individual"
    delete "/permisos/remove/:id" => "persona_empresa_formularios#eliminar_permiso", as: "eliminar_permiso"
    post 'persona_empresa_formularios/eliminar_seleccionados', to: 'persona_empresa_formularios#eliminar_seleccionados', as: :eliminar_seleccionados_componentes

    #routs datos externos
    get "/detalle/datosexterno/:dato_externo_id" => "datos_externos#index_detalle_datos_externo", as: "index_detalle_datos_externo"
    get "/nuevo/datos_externo/:id" => "datos_externos#nuevo_detalle_dato", as: "nuevo_detalle_dato"
    post "datos_externos/crea_detalle_de"

    #routs datos apis
    get "/detalle/datosapi/:datos_api_id" => "datos_apis#index_detalle_datos_api", as: "index_detalle_datos_api"
    get "/nuevo/datos_api/:id" => "datos_apis#nuevo_detalle_datos_api", as: "nuevo_detalle_datos_api"
    post "datos_apis/registro_detalle_dato_api"
    get "/editar/datos_api/:id" => "datos_apis#editar_detalle_datos_api", as: "editar_detalle_datos_api"
    post "datos_apis/actualizar_detalle_dato_api"
    get "/inactivar/datos_api/:id" => "datos_apis#inactivar_detalle_datos_api", as: "inactivar_detalle_datos_api"


    get "/empresas/search" => "usuarios#search_empresa", as: "search_empresa"
    get "/areas/search" => "usuarios#search_areas", as: "search_areas"
    get "/persona/modal_cambio_contra/:persona_id" => "personas#modal_cambiar_contrasena", as: "modal_cambiar_contrasena"
    post "personas/registrar_cambio_contrasena"
    get "/persona/registrar_token/:persona_id" => "personas#registrar_token_persona", as: "registrar_token_persona"
    get "/persona/generar_token/" => "personas#generar_token", as: "generar_token"
    get "search_area_empresa_usuario" => "usuarios#search_area_empresa_usuario", as: "search_area_empresa_usuario"

    resources :datos_apis
    resources :detalle_datos_externos
    resources :datos_externos

    #Manejo controller Usuarios
    post 'usuarios/crear_usuario'
    get 'usuarios/index'
    get 'usuarios/agregar_usuario'

    #Manejo controller Personas
    resources :personas, :path => 'pers' do
      member do
        get 'i' => "personas#inactivar", as: 'inactivar'
        get 'a' => "personas#activar", as: 'activar'
        get 'cp' => "personas#conservar_password", as: 'conservar_password'
        get 'mec' => "personas#modal_edit_email", as: 'edit_email'
        patch 'update_email' => 'personas#update_email', as: 'update_email'
        get 'reu' => "personas#remitente_email", as: 'remitente_email'
      end
    end
    get 'personas/show/:id' => "personas#show", as: 'ver_perfil'
    #get 'personas/edit/:id' => "personas#edit", as: 'edit_persona'
    patch 'personas/update'
    # get 'inactivar/:id' => "personas#inactivar", as: 'inactivar_user'
    # get 'activar/:id' => "personas#activar", as: 'activar_user'
    # get 'conservar_password/:id' => "personas#conservar_password", as: 'conservar_password_usuario'
    #resources :personas , only: [:show, :edit, :update]


    post 'home/registrar_parametro'
    post "home/registrar_area_temporal"

    #Manejo controller empresas
    resources :empresas, :path => 'empresa' do
      member do
        get 'i' => "empresas#inactivar", as: 'inactivar'
        get 'a' => "empresas#activar", as: 'activar'
      end
    end

    #Manejo controller areas
    resources :areas, :path => 'area' do
      member do
        get 'i' => "areas#inactivar", as: 'inactivar'
        get 'a' => "areas#activar", as: 'activar'
      end
    end

    #Manejo controller rol
    resources :roles, :path => 'rol' do
      member do
        get 'i' => "roles#inactivar", as: 'inactivar'
        get 'a' => "roles#activar", as: 'activar'
      end
    end

    #manejo de controller peresonas - areas
    resources :personas_areas
    get 'usuario_area/inactivar/:id' => "personas_areas#inactivar_usuario_area", as: 'inactivar_usuario_area'
    get "personas_areas/search_areas_by_empresa"

    #Manejo de controller menu
    resources :menus, :path => 'menu' do
      member do
        get 'i' => "menus#inactivar", as: 'inactivar'
        get 'a' => "menus#activar", as: 'activar'
      end
    end

    resources :sub_opciones, :path => 'sub_opcion' do
      member do
        get 'i' => "sub_opciones#inactivar", as: 'inactivar'
        get 'a' => "sub_opciones#activar", as: 'activar'
      end
    end

    #Manejo de controller Opciones
    resources :opciones, :path => 'opcion' do
      member do
        get 'i' => "opciones#inactivar", as: 'inactivar'
        get 'a' => "opciones#activar", as: 'activar'
      end
    end

    #Manejo de controller menu por rol
    resources :menu_roles, :path => 'menu_rol' do
      member do
        get 'i' => "menu_roles#inactivar", as: 'inactivar'
        get 'a' => "menu_roles#activar", as: 'activar'
      end
    end

    #Manejo de controller atributo
    resources :atributos
    get 'atributo/inactivar/:id' => "atributos#inactivar_atributo", as: 'inactivar_atributo'

    #Manejo de controller componente
    resources :componentes
    get 'componente/inactivar/:id' => "componentes#inactivar_componente", as: 'inactivar_componente'

    #Manejo de controller opcion componentes - atributos
    resources :opcion_cas
    get 'opcion_ca/inactivar/:id' => "opcion_cas#inactivar_opcion_ca", as: 'inactivar_opcion_ca'

    #Manejo de controller persona, empresa, formularios
    get 'personas/search/' => "persona_empresa_formularios#search", as: 'search'

    #Para buscar las areas por empresa por persona de un usuario
    get '/permisos/searchemp/' => "persona_empresa_formularios#search_areas_persona", as: 'searchemp'
  end

  scope "/catalogos", :path_names => {new: 'n', edit: 'e'} do
    resources :unidad_medidas, :path => 'unidad_medida' do
      collection do 
        get 'search_empresa', to: 'unidad_medidas#search_empresa', as: 'search_empresa'
        get 'search_datos', to: 'unidad_medidas#search_datos', as: 'search_datos'
      end
      
      member do
        get 'i' => "unidad_medidas#inactivar", as: 'inactivar'
        get 'a' => "unidad_medidas#activar", as: 'activar'
      end
    end

    resources :tipo_selecciones, :path => 'tipo_seleccion' do
      member do
        get 'i' => "tipo_selecciones#inactivar", as: 'inactivar'
        get 'a' => "tipo_selecciones#activar", as: 'activar'
      end
    end

    resources :tipo_contenidos, :path => 'tipo_contenido' do
      member do
        get 'i' => "tipo_contenidos#inactivar", as: 'inactivar'
        get 'a' => "tipo_contenidos#activar", as: 'activar'
      end
    end
  end

  scope "/modulos" do

  end

  scope "/configuraciones" do

  end

  namespace "api" do
    namespace "v1" do
      post '/apiauthenticate' => 'login_apps#authenticate'
    end
  end
end
