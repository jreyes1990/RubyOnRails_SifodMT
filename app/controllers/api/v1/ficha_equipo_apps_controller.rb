module Api::V1
    class FichaEquipoAppsController < ApplicationController
        include ActionController::HttpAuthentication::Token::ControllerMethods
        before_action :authenticate         
        skip_before_action :authenticate_user!

                
        def get_ficha_equipo
            codigo_qr = params[:codigo]
            codigo = ''

            #buscar el codigo qr en las caracterisitcas y traer el codigo equipo.
            valida_equipo = custom_query("select a.equipo_id 
                                        from detalle_equipos a
                                        where a.nombre_caracteristica = 'Código QR'
                                        and a.valor_caracteristica = '#{codigo_qr}'") 

            if valida_equipo == nil

              render json: { code: 400, error: true, message: "Equipo no encontrado" }
              genera_bitacora_movil("CONSULTA_MOVIL", @user.id, "", "CONSULTA EQUIPO","SE EJECUTA CONSULTA DEL EQUIPO #{codigo_qr}, TOKEN AUTORIZADO #{@user.token}, EQUIPO NO ENCONTRADO")                       

            else 
              #asignacion de codigo equipo ala variable codigo.
              valida_equipo.each do |p|
                codigo = p['equipo_id']
              end 

              equipo = Equipo.find(codigo)

              equipoRespuesta = {id: equipo.id, nombre: equipo.tipo_equipo.nombre, orden_trabajo_id:  equipo.orden_trabajo_id, codigo_empleado: equipo.codigo_empleado, nombre_empleado: equipo.nombre_empleado, estado_asignacion: equipo.estado_asignacion, observacion: equipo.observacion}
             

              detalle_orden_equipo = custom_query("select      
                                                        DISTINCT a.orden_trabajo_id, c.nombre, b.fecha_referencia
                                                        from detalle_orden_trabajos a , orden_trabajos b, tipo_transaccions c 
                                                        where a.equipo_id = #{codigo}
                                                        and a.orden_trabajo_id = b.id
                                                        and b.tipo_transaccion_id = c.id
                                                        and b.estado = 'A'
                                                        and a.estado = 'A'")

              
              caracteristicas = custom_query("select a.caracteristica_id, a.nombre_caracteristica, a.valor_caracteristica
                                              from detalle_equipos as a
                                              where a.equipo_id = #{codigo}")
                                                          
              mantenimiento_equipo = custom_query("select DISTINCT b.id, c.nombre as nombre_transaccion, a.nombre_tipo_mantenimiento as tipo_mantenimiento, d.nombre as nombre_responsable, d.apellido as apellido_responsable, b.observaciones, b.fecha_referencia
                                                    from detalle_orden_trabajos as a, orden_trabajos as b, tipo_transaccions as c, personas as d
                                                    where a.equipo_id = #{codigo}
                                                    and a.orden_trabajo_id = b.id
                                                    and b.tipo_transaccion_id = c.id
                                                    and d.user_id = b.user_id
                                                    and b.tipo_transaccion_id = 3
                                                    and b.estado_orden_trabajo_id = 3")
              labores = custom_query("select
                                        distinct nombre_labor,
                                        orden_trabajo_id
                                      from
                                        detalle_orden_trabajos dot
                                      where
                                        equipo_id = #{codigo}
                                        and mantenimiento_id is not null	
                                      order by
                                        2 asc,
                                        1 asc")
                                          
              asignacion_equipo = custom_query("select a.orden_trabajo_id, a.codigo_empleado, a.nombre_empleado, b.created_at as fecha_referencia
                                                from detalle_orden_trabajos as a, orden_trabajos as b, equipos as c
                                                where a.equipo_id = #{codigo}
                                                and a.orden_trabajo_id = b.id
                                                and a.equipo_id = c.id
                                                and b.tipo_transaccion_id = 2
                                                and b.estado_orden_trabajo_id = 3
                                                and a.codigo_empleado is not null")
                                          
              garantias = custom_query("select
                                              a.orden_trabajo_id,
                                              c.nombre,
                                              a.proveedor_id,
                                              a.nombre_proveedor,
                                              a.observacion_falla,
                                              a.observacion_envio,
                                              a.created_at as fecha_referencia
                                            from
                                              detalle_orden_trabajos as a,
                                              orden_trabajos as b,
                                              tipo_transaccions c
                                            where
                                              a.equipo_id = #{codigo}
                                              and b.tipo_transaccion_id in (7, 8)
                                              and a.orden_trabajo_id = b.id
                                              and b.tipo_transaccion_id = c.id")
                                                                                         
              render json: { code: 200, error: false, message: "Equipo #{codigo}", equipo: equipoRespuesta, ordenes: detalle_orden_equipo, caracteristicas: caracteristicas, mantenimientos: mantenimiento_equipo, labores: labores, asignaciones: asignacion_equipo, garantias: garantias } 
              genera_bitacora_movil("CONSULTA_MOVIL", @user.id, "", "CONSULTA EQUIPO","SE EJECUTA CONSULTA DEL EQUIPO #{codigo}, TOKEN AUTORIZADO #{@user.token}, EXITOSAMENTE")                       
            end 
        end

        private
        
        def authenticate
            tk = 0
            authenticate_or_request_with_http_token do |token, options|                    
                tk = token
                @user = Persona.find_by(token: token)                
            end            
        end
    end
end