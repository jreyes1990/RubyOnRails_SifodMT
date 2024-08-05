module Api::V1
    class LoginAppsController < ApplicationController
        skip_before_action :authenticate_user!
        skip_before_action :verify_authenticity_token
        
        def authenticate
            user = login_apps_params[:email]
            pass = login_apps_params[:password]

            usuario = User.find_by_email(user)

            unless usuario.nil?
                usuario_valido = usuario.valid_password?(pass)

                if usuario_valido
                    persona = Persona.find_by_user_id(usuario.id)
                    #persona = custom_query("select id, nombre ||' '|| apellido as nombre_completo, direccion, telefono, user_id, token  from personas where user_id = #{usuario.id}")

                    datos_respuesta = { id: persona.id, nombre_completo: persona.nombre_completo, direccion: persona.direccion, telefono: persona.telefono, user_id: persona.user_id, token: persona.token }                  
                    render json: { code: 200, error: false, message: "AUTENTICADO", usuario: datos_respuesta } 

                    genera_bitacora_movil("AUTENTICACION_MOVIL", usuario.id, user , "AUTENTICACIÓN","SE INICIA SESION CON EMAIL #{user.upcase} EXITOSAMENTE")
                else
                    render json: { code: 400, error: true, message: "Password Inválido" }
                    genera_bitacora_movil("AUTENTICACION_MOVIL", usuario.id, user , "PASSWORD INVALIDO","SE INTENTA INICIAR SESION CON #{user.upcase}, PASSWORD INCORRECTO")
                end
            else
                render json: { code: 400, error: true, message: "El usuario no existe" }
                genera_bitacora_movil("AUTENTICACION_MOVIL", "", user , "EMAIL INCORRECTO","SE INTENTA INICIAR SESION CON #{user.upcase}, EMAIL INCORRECTO")
            end
            
        end

        def login_apps_params
            params.require(:login_app).permit(:email, :password)
        end
    end
end