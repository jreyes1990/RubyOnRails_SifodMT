module Permisos 
    public
    
    def cargar_permisos_de_usuario(persona_id, empresa_id)
        controlador = params[:controller]
        
        @permisosConfigurados =  custom_query("SELECT
                                                    com.NOMBRE AS COMPONENTE,
                                                    atr.NOMBRE AS ATRIBUTO
                                                FROM
                                                    PERSONA_EMPRESA_FORMULARIOS a
                                                INNER JOIN personas_areas b ON
                                                    a.personas_area_id = b.id
                                                INNER JOIN areas c ON
                                                    b.area_id = c.id
                                                INNER JOIN empresas d ON
                                                    d.id = c.empresa_id
                                                INNER JOIN personas e ON
                                                    b.persona_id = e.id
                                                INNER JOIN opcion_cas oc ON
                                                    oc.id = a.opcion_ca_id
                                                INNER JOIN opciones o ON
                                                    o.id = oc.opcion_id
                                                INNER JOIN atributos atr ON
                                                    atr.id = oc.atributo_id
                                                INNER JOIN COMPONENTES com ON
                                                    com.id = oc.COMPONENTE_ID 
                                                WHERE
                                                    e.id = #{persona_id}
                                                    AND c.empresa_id = #{empresa_id.to_i}
                                                    AND upper(o.controlador) = upper('#{controlador}')")
               

        @permisos = []
        
        if !@permisosConfigurados.nil?
            @permisosConfigurados.each do |h|
                componente = h['componente']
                atributo = h['atributo']
                permiso = Permiso.new(componente, atributo)
                @permisos.push(permiso)
            end
            return @permisos
        end
        
    end

    def cargar_permisos_de_menus_sidebar(persona_id, empresa_id)

      if !empresa_id.blank?  
            #query para cargar los menus del sidebar
        @permisosConfiguradosSidebar = custom_query("SELECT
                                                    com.NOMBRE AS COMPONENTE,
                                                    atr.NOMBRE AS ATRIBUTO
                                                FROM
                                                    PERSONA_EMPRESA_FORMULARIOS a
                                                INNER JOIN personas_areas b ON
                                                    a.personas_area_id = b.id
                                                INNER JOIN areas c ON
                                                    b.area_id = c.id
                                                INNER JOIN empresas d ON
                                                    d.id = c.empresa_id
                                                INNER JOIN personas e ON
                                                    b.persona_id = e.id
                                                INNER JOIN opcion_cas oc ON
                                                    oc.id = a.opcion_ca_id
                                                INNER JOIN opciones o ON
                                                    o.id = oc.opcion_id
                                                INNER JOIN atributos atr ON
                                                    atr.id = oc.atributo_id
                                                INNER JOIN COMPONENTES com ON
                                                    com.id = oc.COMPONENTE_ID 
                                                WHERE
                                                    e.user_id = #{persona_id}
                                                    AND c.empresa_id = #{empresa_id.to_i}
                                                    AND atr.nombre = 'VER OPCION'")
                                                                                                    
        
        session[:permisosSidebar] = []
        i = 0

        if !@permisosConfiguradosSidebar.nil?

            @permisosConfiguradosSidebar.each do |h|                    
                componente = h['componente']
                atributo = h['atributo']            
                permiso = Permiso.new(componente, atributo)
                session[:permisosSidebar].push(permiso)
            end
            return session[:permisosSidebar]

        end 


        
      else
        return session[:permisosSidebar] = []
      end  

    end

    def tiene_permiso(componente, atributo)
        atributo_encontrado = false
        
        if !@permisos.nil?
        @permisos.each do |p|
        
            if (p.componente.upcase.eql?(componente.upcase)) && (p.atributo.upcase.eql?(atributo.upcase))
                atributo_encontrado = true
            end
        end
        return atributo_encontrado
        end
    end


  def tiene_permiso_sidebar(componente, atributo)
    return false if componente.nil? || atributo.nil?

    atributo_encontrado = false
    
    session[:permisosSidebar].each do |p|
      if (p.componente.upcase.eql?(componente.upcase)) && (p.atributo.upcase.eql?(atributo.upcase))
        atributo_encontrado = true
      end
    end
    return atributo_encontrado
  end
end