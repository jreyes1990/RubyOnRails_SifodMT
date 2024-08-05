class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    layout :layout_by_resource
    before_action :set_empresa_session_area
    include Permisos  
    include Utilidades  
    

    def current_user_empresa_id
        id_empresa_actual = 0
        parametros = Parametro.where(:user_id => current_user.id).first

        if (parametros != nil) then
            id_empresa_actual = parametros.empresa_id        
            return id_empresa_actual
        else
            return id_empresa_actual = ''
        end

    end

    def current_codigo_empresa_area
      codigo_empresa = 0      
      @area_configurada = Empresa.joins("inner join parametros on parametros.empresa_id  = empresas.id 
                                            where parametros.user_id = #{current_user.id}").first

      if @area_configurada.present?
          codigo_empresa = @area_configurada.codigo_empresa
          return codigo_empresa
      else
          return nil
      end
    end 


    def helper_current_area_id_user
        id_area = 0
        @area = Area.joins("inner join personas_areas on personas_areas.area_id = areas.id
            inner join personas on personas.id = personas_areas.persona_id
            inner join empresas on empresas.id = areas.empresa_id
            where personas.user_id = #{current_user.id}").first
            id_area = @area.id
            return id_area
    end

    def helper_current_areas_x_usuario
      id_area = []
      @area = Area.joins("inner join personas_areas on personas_areas.area_id = areas.id
          inner join personas on personas.id = personas_areas.persona_id
          inner join empresas on empresas.id = areas.empresa_id
          where personas.user_id = #{current_user.id}")
          id_area = @area.ids
          return id_area
    end

    def comprobar_permiso
        cargar_permisos_de_usuario(current_user.persona.id, current_user_empresa_id)
        if !tiene_permiso("OPCION", "ACCESAR")
        flash[:error] = "No tienes autorización para ver esta sección"
        redirect_to home_index_path
        end
    end

    def set_empresa_session_area
      if current_user.present?
        @empresa_session_area = current_codigo_empresa_area()
        @nombre_empresa_session_area = PgEmpresa.where(id_empresa: current_codigo_empresa_area()).first
      end
    end
    

    private
    def layout_by_resource
        if devise_controller?
            "devise"
        else
            "application"
        end
    end
 
end
