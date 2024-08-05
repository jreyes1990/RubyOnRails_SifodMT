class HomeController < ApplicationController
  
  def index
    #flash[:success] = "Bienvenido "
    #flash[:alert] = "Bienvenido "
    #flash[:notice] = "Bienvenido "
    #flash[:error] = "Bienvenido "
    @areas = PersonasArea.joins("inner join personas on personas.id = personas_areas.persona_id 
      where personas.user_id = #{current_user.id}
      and personas_areas.estado = 'A'")
    @valida_password_user = User.select(:id, :password_changed ).where(:id => current_user.id).first
    @valida_parametro = Parametro.where(:user_id => current_user.id).first
    session[:permisosSidebar] = nil
  end

  def registrar_area_temporal
    area_id = params[:set_area_form][:area_id]
    area = Area.find(area_id)
    empresa = Empresa.find(area.empresa_id)
    @parametro_nuevo = Parametro.new
    @parametro_nuevo.user_id = current_user.id
    @parametro_nuevo.area_id = area_id
    @parametro_nuevo.nombre_area = area.nombre
    @parametro_nuevo.empresa_id = area.empresa_id
    @parametro_nuevo.nombre_empresa =empresa.nombre
    @parametro_nuevo.ruta_predeterminada =''
    if @parametro_nuevo.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Asignación creada exitosamente." }
        format.json { render :show, status: :created, location: @caracteristica_equipo }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Error área no asignada." }
        format.json { head :no_content }
      end 
    end   
  end 

  def mostrar_parametro
    @parametro = Parametro.where(:user_id => params[:id]).first
    @areas = PersonasArea.joins("inner join personas on personas.id = personas_areas.persona_id 
                                  where personas.user_id = #{current_user.id}
                                  and personas_areas.estado = 'A'")

                

  end 

  def registrar_parametro
    area_id = params[:actualizar_parametro_form][:area_id]
    area_antigua_id = params[:actualizar_parametro_form][:area_antigua_id]
    area = Area.find(area_id)
    empresa = Empresa.find(area.empresa_id)
    @parametro = Parametro.where('user_id = ? and area_id = ?',current_user.id, area_antigua_id ).first 
    @prueba = Parametro.find(@parametro.id)
    @prueba.user_id = current_user.id
    @prueba.area_id = area_id
    @prueba.nombre_area = area.nombre
    @prueba.empresa_id = area.empresa_id
    @prueba.nombre_empresa = empresa.nombre
    @prueba.ruta_predeterminada = params[:actualizar_parametro_form][:ruta_predeterminada]
    if @prueba.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Parámetro actualizado exitosamente." }
        format.json { render :show, status: :created, location: @prueba }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Error área no actualizada." }
        format.json { head :no_content }
      end 
    end  
    
      
  end 

  def modal_salir

    respond_to do |format|
      format.html
      format.js
    end
  end 

  def modal_codeqr
    respond_to do |format|
      format.html
      format.js
    end
  end 

  def cambio_password_user
    puts set_password_change
    @user = current_user
    @passwords_params = set_password_change
    respond_to do |format|
      if @user.valid_password?(@passwords_params[:password_actual])
        if @passwords_params[:password_nueva] == @passwords_params[:password_confirmada]
          if @passwords_params[:password_nueva] != @passwords_params[:password_actual]
            #validar que la contraseña nueva sea segura, 8 digitos minimos, una letra mayuscula, una minuscula, un numero y un caracter especial
            if @passwords_params[:password_nueva].length >= 8 && @passwords_params[:password_nueva].match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(_|[^\w])).+$/).present?
              @user.password = @passwords_params[:password_nueva]
              @user.password_changed = true
              if @user.save
                  session[:password_change_success] = "Nueva contraseña registrada exitosamente."
                  format.html { redirect_to home_index_path, notice: "Nueva contraseña registrada exitosamente." }
              else
                  @valida_password_user = User.select(:id, :password_changed ).where(:id => current_user.id).first
                  format.js { flash.now[:error] = "Error al cambiar la contraseña" }
              end
            else 
              @valida_password_user = User.select(:id, :password_changed ).where(:id => current_user.id).first
              format.js { flash.now[:error] = "La nueva contraseña no es segura" }
            end
          else 
            @valida_password_user = User.select(:id, :password_changed ).where(:id => current_user.id).first
            format.js { flash.now[:error] = "La nueva contraseña no puede ser la actual" }
          end
        else
          @valida_password_user = User.select(:id, :password_changed ).where(:id => current_user.id).first
          format.js { flash.now[:error] = "La contraseña nueva no coinciden" }
        end
      else 
        @valida_password_user = User.select(:id, :password_changed ).where(:id => current_user.id).first
        format.js { flash.now[:error] = "Contaseña actual incorrecta" }
      end
    end
  end

  private

  def set_password_change
    params.require(:set_password_change).permit(:password_actual, :password_nueva, :password_confirmada)
  end
end
