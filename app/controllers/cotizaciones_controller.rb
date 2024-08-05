class CotizacionesController < ApplicationController
  before_action :set_cotizacion, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso
  before_action :set_cotizacion_modal, only: [:index, :detalle_cotizacion, :agregar_productos, :editar_detalle, :cotizacion_pdf, :set_precios]
  before_action :set_detalle_cotizacion_modal, only: [:index, :detalle_cotizacion, :editar_detalle, :cotizacion_pdf, :set_precios]
  before_action :set_precio_cotizacion_params, only: [:actualizar_precios]

  include ManageStatus


  DetallePedidoMail = Struct.new(:cotizacion_id, :razon_social, :fecha_cotizacion)
  
  # GET /cotizaciones or /cotizaciones.json
  def index
    
    @estado_a_mostrar = EstadoXProcesoView.find_by(desc_proceso: 'COTIZACIONES',desc_estado: 'ACTIVO').id

    @cotizacion_activa = Cotizacion.where(:estado_x_proceso_id => @estado_a_mostrar).first
    if !@cotizacion_activa.present?
      @estado_a_mostrar = EstadoXProcesoView.find_by(desc_proceso: 'COTIZACIONES',desc_estado: 'COTIZADO').id
    end 

    if params[:id]

      if @cotizacion_not_found
        #redireccionar 
        redirect_to cotizaciones_url, alert: "La cotización que desea ver no existe, Verifique!"
      end

      @open_modal = true
      #@cotizacion = Cotizacion.find(params[:id])
      @contador = 0
      @estado = EstadoXProcesoView.where(:estado_registro => 'A', :desc_proceso => 'COTIZACIONES', :desc_estado => 'COTIZADO').first
      @estado_activo_id = EstadoXProcesoView.where(:estado_registro => 'A', :desc_proceso => 'COTIZACIONES', :desc_estado => 'ACTIVO').first
      @comprobacion_estado = Cotizacion.where(:id => @cotizacion.id, :estado_x_proceso_id => @estado.id).first
      #comprobar que todos los detalle de la cotizacion tengan un precio cotizado
      @validar = DetCotizacion.where(:cotizacion_id => @cotizacion.id, :precio_cotizado => nil, :estado_x_proceso_id => @estado_activo_id.id)

      @comprobar_estado_activo = Cotizacion.where(:id => @cotizacion.id, :estado_x_proceso_id => @estado_activo_id.id).first

      @estado_a_mostrar = @cotizacion.estado_x_proceso_id

      if @validar.present?
        @validar = true
      else 
        @validar = false
      end
    else 
      @open_modal = false
    end
    @estado_filtro = EstadoXProcesoView.where(desc_proceso: 'COTIZACIONES', estado_registro: 'A').pluck(:desc_estado, :id).map { |desc_estado, id| [desc_estado, id] }

    #buscar en cotizaciones si al menos alguno de los encabezados tiene un estado de @estado_filtro, si no no mostrarlo en @estado_filtro
    @estado_filtro = @estado_filtro.select { |desc_estado, id| Cotizacion.where(estado_x_proceso_id: id).present? }




    respond_to do |format|    
      format.html
      format.json { render json: CotizacionDatatable.new(params, view_context: view_context) }
    end
  end

  def data 
    render json:  CotizacionDatatable.new(params, view_context: view_context) 
   
  end

  # GET /cotizaciones/1 or /cotizaciones/1.json
  def show
  end

  # GET /cotizaciones/new
  def new
    @cotizacion = Cotizacion.new
  end

  # GET /cotizaciones/1/edit
  def edit
  end

  # POST /cotizaciones or /cotizaciones.json
  def create
    
    @cotizacion = Cotizacion.new(cotizacion_params)
    @cotizacion.user_created_id = current_user.id
    @cotizacion.fecha_cotizacion = Time.now
    @cotizacion.fecha_validez = nil 

    @estado = EstadoXProcesoView.where(:estado_registro => 'A', :desc_proceso => 'COTIZACIONES', :desc_estado => 'ACTIVO').first
    @cotizacion.estado_x_proceso_id = @estado.id

    respond_to do |format|
    #   if @cotizacion.save
    #     format.html { redirect_to cotizacion_url(@cotizacion), notice: "Cotizacion was successfully created." }
    #     format.json { render :show, status: :created, location: @cotizacion }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @cotizacion.errors, status: :unprocessable_entity }
    #   end
    # end
      if @cotizacion.save
        format.json { render json: { success: true, id: @cotizacion.id  }, status: :created }
        format.html { redirect_to cotizaciones_url(id: @cotizacion.id), notice: "Cotizacion was successfully created." }
      else
          # Aquí capturamos los errores
          Rails.logger.error(@cotizacion.errors.full_messages.to_sentence)
          format.json { render json: { success: false, error: @cotizacion.errors.full_messages.to_sentence }, status: :unprocessable_entity }
      end
    end 
  end

  # PATCH/PUT /cotizaciones/1 or /cotizaciones/1.json
  def update
    respond_to do |format|
      if @cotizacion.update(cotizacion_params)
        format.html { redirect_to cotizacion_url(@cotizacion), notice: "Cotizacion was successfully updated." }
        format.json { render :show, status: :ok, location: @cotizacion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cotizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cotizaciones/1 or /cotizaciones/1.json
  def destroy
    @cotizacion.destroy

    respond_to do |format|
      format.html { redirect_to cotizaciones_url, notice: "Cotizacion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def sugerencia_proveedor

    @id_empresa = params[:id_empresa]
    # @necesidad_mercaderia = NecesidadMercaderia.find(params[:necesidad_mercaderia_id])
    @necesidad_mercaderia = NecesidadMercaderia.joins('JOIN PG_EMPRESA ON PG_EMPRESA.ID_EMPRESA = NECESIDADES_MERCADERIAS.ID_EMPRESA').select('NECESIDADES_MERCADERIAS.*, PG_EMPRESA.DESCRIPCION AS NOMBRE_EMPRESA').find(params[:necesidad_mercaderia_id])


    # Obtener IDs de productos de la necesidad (eliminando los nil)
    productos_ids = @necesidad_mercaderia.det_necesidades_mercaderias.pluck(:prod_producto_id).compact

    #obtener el estado por proces de proveedores_x_productos
    estado_x_proceso_id = EstadoXProcesoView.select(:id).where(:estado_registro => 'A', :desc_proceso => 'PROVEEDOR POR PRODUCTO', :desc_estado => 'ACTIVO')

    # Obtener proveedores y sus productos asociados
    proveedores_con_productos = Proveedor.joins(proveedores_x_productos: :prod_producto)
                                        .where(proveedores_x_productos: { prod_producto_id: productos_ids, 
                                                                          estado_x_proceso_id: estado_x_proceso_id }) 
                                        .select('proveedores.*, proveedores_x_productos.prod_producto_id, prod_productos.nombre as producto_nombre')
                                        .order('proveedores.razon_social, prod_productos.id')

    #Obtener todos los proveedor_ids de las cotizaciones existentes para la necesidad de mercadería específica.
    cotizaciones_con_proveedor_ids = Cotizacion.where(necesidad_mercaderia_id: @necesidad_mercaderia.id).pluck(:proveedor_id)   

    # Obtener el último precio de compra para cada proveedor y producto
    ultimo_precio_compra = PrecioCompraProducto.where(id_empresa: @id_empresa, proveedor_id: proveedores_con_productos.pluck(:id), prod_producto_id: productos_ids).select('MAX(id) as max_id').group(:proveedor_id, :prod_producto_id).map(&:max_id)

    precios_compra = PrecioCompraProducto.find(ultimo_precio_compra)
    
    precios_compra_hash = precios_compra.each_with_object({}) do |precio, hash|
      hash[[precio.proveedor_id, precio.prod_producto_id]] = precio.precio_compra
    end


    # Crear un hash para almacenar la relación proveedor-productos
    @proveedores_y_sus_productos = {}

    proveedores_con_productos.each do |proveedor_con_producto|
      proveedor_id = proveedor_con_producto.id
      producto_id = proveedor_con_producto.prod_producto_id
      producto_nombre = proveedor_con_producto.producto_nombre 

      # Verificar si este proveedor ya está en una cotización para la necesidad de mercadería dada
      next if cotizaciones_con_proveedor_ids.include?(proveedor_id)

      @proveedores_y_sus_productos[proveedor_id] ||= {
        nombre: proveedor_con_producto.razon_social,
        productos: []
      }

      precio_compra = precios_compra_hash[[proveedor_id, producto_id]]

      @proveedores_y_sus_productos[proveedor_id][:productos] << { id: producto_id, nombre: producto_nombre, precio_compra: precio_compra }
      
    end

    puts "Proveedores y sus productos ==========================="
    puts @proveedores_y_sus_productos.inspect

    @id_proveedores = @proveedores_y_sus_productos.keys
    @id_proveedores = @id_proveedores.join(',')
    @cotizacion = Cotizacion.new

  end

  def search_proveedor
   
    if params[:empresa_id].present? && params[:search].present?
      proveedores_query = Proveedor.where("lower(razon_social) LIKE ? AND id_empresa = ?", "%#{params[:search].downcase}%", params[:empresa_id])
    
      if params[:proveedores_id].present?
        proveedores_id_to_exclude = params[:proveedores_id].split(',')  # Dividir la lista de IDs en un array
        proveedores_query = proveedores_query.where.not(id: proveedores_id_to_exclude)
      end
    
      @proveedores = proveedores_query.select("id, razon_social")
     
    else
      @proveedores = [{ valor_id: '', valor_text: 'Error: Faltan parámetros' }]
    end
    
    respond_to do |format|
      format.json { render json: @proveedores.map { |p| { valor_id: p.id.to_s + '-' + params[:empresa_id].to_s, valor_text: p.razon_social } } }
    end
    

  end

  def agregar_productos
    if @cotizacion_not_found
      redirect_to cotizaciones_url, alert: "El registro no existe, Verifique!"
      return
    end
    # Obtener el estado por proceso de proveedores_x_productos
    estado_x_proceso_id = EstadoXProcesoView.select(:id).where(estado_registro: 'A', desc_proceso: 'PROVEEDOR POR PRODUCTO', desc_estado: 'ACTIVO')
    #Inicio obtener los productos registrados en la necesidad de mercaderia para el proveedor
    proveedor_id = @cotizacion.proveedor_id
    necesidad_mercaderia_id = @cotizacion.necesidad_mercaderia_id
    
    # Obtiene los IDs de productos para el proveedor
    productos_de_proveedor_ids = ProveedorXProducto.where(proveedor_id: proveedor_id, estado_x_proceso_id: estado_x_proceso_id).pluck(:prod_producto_id)

    # Obtiene los IDs de productos para la necesidad de mercaderia
    productos_de_necesidad_ids = DetNecesidadMercaderia.where(necesidad_mercaderia_id: necesidad_mercaderia_id).pluck(:prod_producto_id).compact

    # Obtener los IDs de productos que ya están configurados para este proveedor y cotización
    productos_ya_configurados_ids = DetCotizacion.where(cotizacion_id: @cotizacion.id).pluck(:prod_producto_id).compact
  
    # Intersección de ambos conjuntos para obtener los productos que se pueden agregar
    @productos_permitidos_ids = (productos_de_proveedor_ids & productos_de_necesidad_ids) - productos_ya_configurados_ids

    # Crear un array para guardar la información completa de los productos
    @productos_completos = []

    # Recorrer cada producto permitido y obtener su cantidad necesitada
    @productos_permitidos_ids.each do |producto_id|
      producto = ProdProducto.find(producto_id)

      # Encuentra el detalle de la necesidad de mercadería para este producto
      detalle_necesidad = DetNecesidadMercaderia.find_by(necesidad_mercaderia_id: necesidad_mercaderia_id, prod_producto_id: producto_id)
      
      # Si existe, obtenemos la cantidad necesitada
      cantidad_necesitada = detalle_necesidad ? detalle_necesidad.cantidad : 0
      
      # Agregamos un hash con toda la información al array
      @productos_completos << { id: producto.id, nombre: producto.nombre, cantidad_necesitada: cantidad_necesitada, det_necesidades_mercaderias_id: detalle_necesidad&.id }
    end

    # Fin obtener los productos registrados en la necesidad de mercaderia para el proveedor
    #Inicio obtener los productos sin previo registro en el sistema pero que estan en la necesidad de mercaderia

    @det_necesidades_mercaderias = DetNecesidadMercaderia.select(:id, :prod_producto_id, :nombre_producto, :cantidad )
    .where(necesidad_mercaderia_id: necesidad_mercaderia_id, prod_producto_id: nil)
    .where.not(id: DetCotizacion.where(cotizacion_id: @cotizacion.id).pluck(:det_necesidad_mercaderia_id).compact)

  end

  def insertar_detalle
    @params = set_detalle_cotizacion_params
    @id_empresa = @params[:id_empresa]
    @cotizacion_id = @params[:cotizacion_id]
    
    @necesidad_mercaderia_id = @params[:necesidad_mercaderia_id]
    @productos_no_registrados = @params[:productos_no_registrados]
    @productos_registrados = @params[:productos_registrados]
    @estado_id = EstadoXProcesoView.select(:id).where(estado_registro: 'A', desc_proceso: 'COTIZACIONES', desc_estado: 'ACTIVO').first.id
    detalles_a_guardar = []
  
    # Insertar productos registrados
    if @productos_registrados.present?
      @productos_registrados.each do |index, producto|
        detalle = DetCotizacion.new(
          id_empresa: @id_empresa,
          cotizacion_id: @cotizacion_id,
          det_necesidad_mercaderia_id: producto["det_nec_mercaderia_id"],
          prod_producto_id: producto["prod_producto_id"],
          cantidad_cotizada: producto["cantidad_a_cotizar"],
          user_created_id: current_user.id,
          estado_x_proceso_id: @estado_id
        )
        detalles_a_guardar << detalle
      end
    end
  
    # Insertar productos no registrados
    if @productos_no_registrados.present?
      @productos_no_registrados.each do |index, producto|
        detalle = DetCotizacion.new(
          id_empresa: @id_empresa,
          cotizacion_id: @cotizacion_id,
          det_necesidad_mercaderia_id: producto["det_nec_mercaderia_id"],
          nombre_producto: producto["nombre"],
          cantidad_cotizada: producto["cantidad_a_cotizar"],
          user_created_id: current_user.id,
          estado_x_proceso_id: @estado_id
        )
        detalles_a_guardar << detalle
      end
    end
    
    respond_to do |format|
      if detalles_a_guardar.present?
        DetCotizacion.transaction do
          detalles_a_guardar.each(&:save!)
        end
        flash[:success] = "Se ha guardado correctamente el detalle de la cotización"
        format.html { redirect_to cotizaciones_url(id: @cotizacion_id)}
      else
        flash[:error] = "No se ha podido guardar el detalle de la cotización, Verifique!"
        format.html { redirect_to cotizaciones_url(id: @cotizacion_id)}
      end
    end
    
  end
  
  def editar_detalle

  end

  def actualizar_detalle
    @params = set_detalle_cotizacion_params

    @id_empresa = @params[:id_empresa]
    @cotizacion_id = @params[:cotizacion_id]
    @necesidad_mercaderia_id = @params[:necesidad_mercaderia_id]

    @productos_no_registrados = @params[:productos_no_registrados]
    @productos_registrados = @params[:productos_registrados]
    # Buscar la cotización por ID
    cotizacion = Cotizacion.find(@params[:cotizacion_id])
    puts "Cotizacion encontrada: #{cotizacion.inspect}"

    # Inicializas un array vacío para almacenar errores
    errores = []
    # Inicializas un array vacío para almacenar los detalles a guardar
    detalles_a_guardar = []

    # Para productos registrados
    if @productos_registrados.present?
      
      puts "Productos registrados presentes"
      @productos_registrados.each do |index, producto_params|
        detalle = DetCotizacion.where(det_necesidad_mercaderia_id: producto_params[:det_nec_mercaderia_id], cotizacion_id: @cotizacion_id).first
        if detalle.present?
          detalle.assign_attributes(cantidad_cotizada: producto_params[:cantidad_a_cotizar].to_i, user_updated_id: current_user.id)
          if detalle.cantidad_cotizada_changed?
            if detalle.valid?
              detalles_a_guardar << detalle
            else
              errores << "Error al actualizar detalle con ID_DETALLE_NECESIDAD_MERCADERIA #{producto_params[:det_nec_mercaderia_id]}: #{detalle.errors.full_messages.join(', ')}"
            end
          end
        else
          errores << "Detalle con ID_DETALLE_NECESIDAD_MERCADERIA #{producto_params[:det_nec_mercaderia_id]} no encontrado."
        end
      end
    end
    
    # Para productos no registrados
    if @productos_no_registrados.present?
      puts "Productos no registrados presentes"
      @productos_no_registrados.each do |index, producto_params|
        detalle = DetCotizacion.where(det_necesidad_mercaderia_id: producto_params[:det_nec_mercaderia_id], cotizacion_id: @cotizacion_id).first
        if detalle.present?
          detalle.assign_attributes(cantidad_cotizada: producto_params[:cantidad_a_cotizar].to_i, user_updated_id: current_user.id)
          if detalle.cantidad_cotizada_changed?
            if detalle.valid?
              detalles_a_guardar << detalle
            else
              errores << "Error al actualizar detalle con ID_DETALLE_NECESIDAD_MERCADERIA #{producto_params[:det_nec_mercaderia_id]}: #{detalle.errors.full_messages.join(', ')}"
            end
          end
        else
          errores << "Detalle no registrado con ID_DETALLE_NECESIDAD_MERCADERIA #{producto_params[:det_nec_mercaderia_id]} no encontrado."
        end
      end
    end

    respond_to do |format|
      if detalles_a_guardar.present?
        begin
          DetCotizacion.transaction do
            detalles_a_guardar.each(&:save!)
          end
          flash[:success] = "Se ha actualizado correctamente el detalle de la cotización"
          format.html { redirect_to cotizaciones_url(id: @cotizacion_id) }
        rescue => e
          errores << "Hubo un error al actualizar los detalles: #{e.message}"
          flash[:error] = "Errores: #{errores.join(', ')}"
          format.html { redirect_to cotizaciones_url(id: @cotizacion_id) }
        end
      else
        if errores.present?
          flash[:error] = "Errores: #{errores.join(', ')}"
          format.html { redirect_to cotizaciones_url(id: @cotizacion_id) }
        else
          flash[:error] = "No se ha podido guardar el detalle de la cotización, Verifique!"
          format.html { redirect_to cotizaciones_url(id: @cotizacion_id) }
        end
      end
    end
  end

  #Manejo de estados inactivar y activar cotizacion

  def inactivar_cotizacion
    change_status_to('INACTIVO', Cotizacion, 'COTIZACIONES', cotizaciones_path, params[:id])
  end

  def activar_cotizacion
    change_status_to('ACTIVO', Cotizacion, 'COTIZACIONES', cotizaciones_path, params[:id])
  end
  #Fin manejo de estados inactivar y activar cotizacion
  #Manejo de estados inactivar y activar detalle cotizacion
  def inactivar_detalle
    change_status_to('INACTIVO', DetCotizacion, 'COTIZACIONES', cotizaciones_path( id: params[:id]), params[:id_detalle])
  end
  def activar_detalle
 
    @datos_det_cotizacion = DetCotizacion.find(params[:id_detalle])
    @consulta_det_cotizacion = EstadoXProcesoView.where("id_empresa = ? and upper(desc_proceso)=? and upper(desc_estado) =?", @datos_det_cotizacion.id_empresa, 'COTIZACIONES', 'ACTIVO').first

    @det_cotizaciones = DetCotizacion.find(params[:id_detalle])
    @det_cotizaciones.user_updated_id = current_user.id
    if !@consulta_det_cotizacion.blank? || !@consulta_det_cotizacion.nil?
      @det_cotizaciones.estado_x_proceso_id = @consulta_det_cotizacion.id
    end

    respond_to do |format|
      if !@consulta_det_cotizacion.blank? || !@consulta_det_cotizacion.nil?
        if @det_cotizaciones.save
          flash[:success] = "El detalle de la cotización se activo correctamente"
          format.html { redirect_to cotizaciones_path( id: params[:id])}
          format.json { render :show, status: :created, location: @det_cotizaciones }
        else
          flash[:alert] = "El detalle de la cotización NO se activo"
          format.html { render cotizaciones_path( id: params[:id]) }
          format.json { render json: @det_cotizaciones.errors, status: :unprocessable_entity }
        end
      else
        flash[:alert] = "El detalle de la cotización que desea activar, no esta dentro del modulo de necesidad de mercaderia, Verifique!"
        format.html { redirect_to cotizaciones_path( id: params[:id]) }
      end
    end
  end
  #Fin manejo de estados inactivar y activar detalle cotizacion

  def cotizacion_pdf
    begin
      ActiveRecord::Base.transaction do

        @estado = EstadoXProcesoView.where(:estado_registro => 'A', :desc_proceso => 'COTIZACIONES', :desc_estado => 'COTIZADO').first
        @cotizacion.estado_x_proceso_id = @estado.id
        @cotizacion.save!
        proveedor_id = @cotizacion.proveedor_id
        @proveedor = Proveedor.find(proveedor_id)
        correo_proveedor = @proveedor.correo_electronico
        correo_usuario_creador = current_user.email
    
        correos_autorizados_array = PersonaRolCorreoView.where(id_empresa: @cotizacion.id_empresa, nombre: 'SUPER ADMINISTRADOR').pluck(:email)
        
        correos_autorizados = correos_autorizados_array.join(', ')
        correos_autorizados = correos_autorizados + ', ' + correo_usuario_creador 
    
        pdf_content = render_to_string(
          template: 'cotizaciones/cotizacion_pdf.html.erb', 
          pdf: "Cotizacion_a_Proveedor_#{@cotizacion.razon_social}", 
          layout: 'pdf.html', 
          page_height: '11in', #Carta 
          #page_height: '11.7in', #A4         
          page_width: '8.5in', 
          lowquality: true,        
          zoom: 1,
          dpi: 75,
          footer: { html: {         
            template: "cotizaciones/footer.html.erb",
            encoding: 'UTF-8'
          }},
          margin: { top: 10, bottom: 20, left: 15, right: 15 },
          disable_internal_links: true,        
          disposition: "inline" #para descargar directamente usar attachment
        )

        @detalle_cotizacion_mail = DetallePedidoMail.new(@cotizacion.id, @cotizacion.razon_social, @cotizacion.fecha_cotizacion)
    
        PedidosMailer.envio_cotizacion_pedidos(correos_autorizados, @detalle_cotizacion_mail, cotizaciones_url(id: @cotizacion.id), pdf_content ).deliver_now

        PedidosMailer.envio_cotizacion_a_proveedor_pedidos(correo_proveedor, @detalle_cotizacion_mail, cotizaciones_url(id: @cotizacion.id), pdf_content ).deliver_now
      end  

      redirect_to cotizaciones_url, notice: 'Cotización enviada con éxito.'
    rescue => e
      Rails.logger.error "Error al enviar el correo: #{e.message}"
      redirect_to cotizaciones_url, alert: "Error al enviar el correo: #{e.message}"
    end
  
  end

  def set_precios 
  end
  def actualizar_precios

    @parametros = set_precio_cotizacion_params
    @productos_no_registrados = @parametros[:productos_no_registrados]
    @productos_registrados = @parametros[:productos_registrados]
    @cotizacion_id = @parametros[:cotizacion_id]
    @id_empresa = @parametros[:id_empresa]
    @necesidad_mercaderia_id = @parametros[:necesidad_mercaderia_id]

    # Inicializas un array vacío para almacenar errores
    errores = []
    # Inicializas un array vacío para almacenar los detalles a guardar
    detalles_a_guardar = []

    if @productos_registrados.present?
      
      puts "Productos registrados presentes"
      @productos_registrados.each do |index, producto_params|
        detalle = DetCotizacion.where(det_necesidad_mercaderia_id: producto_params[:det_nec_mercaderia_id], cotizacion_id: @cotizacion_id).first
        if detalle.present?
          detalle.assign_attributes(precio_cotizado: producto_params[:precio_cotizado].to_f, user_updated_id: current_user.id, cantidad_disponible_proveedor: producto_params[:cantidad_disponible].to_i)
          if detalle.precio_cotizado_changed? || detalle.cantidad_disponible_proveedor_changed?
            if detalle.valid?
              detalles_a_guardar << detalle
            else
              errores << "Error al actualizar detalle id #{detalle.id}: #{detalle.errors.full_messages.join(', ')}"
            end
          end
        else
          errores << "Detalle con ID #{detalle.id} no encontrado."
        end
      end
    end
    # Para productos no registrados
    if @productos_no_registrados.present?
      puts "Productos no registrados presentes"
      @productos_no_registrados.each do |index, producto_params|
        detalle = DetCotizacion.where(det_necesidad_mercaderia_id: producto_params[:det_nec_mercaderia_id], cotizacion_id: @cotizacion_id).first
        if detalle.present?
          detalle.assign_attributes(precio_cotizado: producto_params[:precio_cotizado].to_f, user_updated_id: current_user.id, cantidad_disponible_proveedor: producto_params[:cantidad_disponible].to_i)
          if detalle.precio_cotizado_changed? || detalle.cantidad_disponible_proveedor_changed?
            if detalle.valid?
              detalles_a_guardar << detalle
            else
              errores << "Error al actualizar detalle con ID #{detalle.id}: #{detalle.errors.full_messages.join(', ')}"
            end
          end
        else
          errores << "Detalle no registrado con ID #{detalle.id} no encontrado."
        end
      end
    end
    respond_to do |format|
      if detalles_a_guardar.present?
        begin
          DetCotizacion.transaction do
            detalles_a_guardar.each(&:save!)
          end
          flash[:success] = "Se ha guardado correctamente el precio cotizado"
          format.html { redirect_to cotizaciones_url(id: @cotizacion_id) }
        rescue => e
          errores << "Hubo un error al guardar el precio cotizado en  los detalles: #{e.message}"
          flash[:error] = "Errores: #{errores.join(', ')}"
          format.html { redirect_to cotizaciones_url(id: @cotizacion_id) }
        end
      else
        if errores.present?
          flash[:error] = "Errores: #{errores.join(', ')}"
          format.html { redirect_to cotizaciones_url(id: @cotizacion_id) }
        else
          flash[:alert] = "No ha cambiado ningun precio, para actualizar el precio, por favor modifique alguno, Verifique!"
          format.html { redirect_to cotizaciones_url(id: @cotizacion_id) }
        end
      end
    end

  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cotizacion
      @cotizacion = Cotizacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cotizacion_params
      params.require(:cotizacion).permit(:id_empresa, :proveedor_id, :necesidad_mercaderia_id, :fecha_cotizacion, :fecha_validez, :user_created_id, :user_updated_id, :estado_x_proceso_id)
    end

    def set_cotizacion_modal
      if params[:id].present?
        @cotizacion = Cotizacion.select(" cotizaciones.*, proveedores.razon_social, pg_empresa.descripcion as nombre_empresa, ESTADO_X_PROCESO_VIEWS.desc_estado, ESTADO_X_PROCESO_VIEWS.desc_proceso, personas.nombre||' '||personas.apellido nombre_usuario").joins("inner join proveedores ON proveedores.id = cotizaciones.proveedor_id inner join pg_empresa ON pg_empresa.id_empresa = cotizaciones.id_empresa inner join ESTADO_X_PROCESO_VIEWS ON ESTADO_X_PROCESO_VIEWS.id = cotizaciones.estado_x_proceso_id inner join personas on (cotizaciones.user_created_id = personas.user_id)").find_by(id: params[:id])
        @cotizacion_not_found = @cotizacion.blank?
      end
    end
    def set_detalle_cotizacion_modal
      if params[:id].present?
        @detalle_cotizacion = DetCotizacion.select("det_cotizaciones.*, prod_productos.nombre, personas.nombre||' '||personas.apellido nombre_usuario, ESTADO_X_PROCESO_VIEWS.desc_estado, pg_empresa.descripcion as nombre_empresa, det_necesidades_mercaderias.cantidad").joins("left join prod_productos on prod_productos.id = det_cotizaciones.prod_producto_id inner join personas on personas.user_id = det_cotizaciones.user_created_id inner join ESTADO_X_PROCESO_VIEWS ON ESTADO_X_PROCESO_VIEWS.id = det_cotizaciones.estado_x_proceso_id inner join pg_empresa ON pg_empresa.id_empresa = det_cotizaciones.id_empresa inner join det_necesidades_mercaderias on det_necesidades_mercaderias.id = det_cotizaciones.det_necesidad_mercaderia_id").where(cotizacion_id: params[:id])
        @detalle_cotizacion_not_found = @detalle_cotizacion.blank?
      end
      
    end

    def set_detalle_cotizacion_params 
      params.require(:detalle_cotizacion).permit(:id_empresa, :cotizacion_id, :necesidad_mercaderia_id, productos_no_registrados: [:det_nec_mercaderia_id, :nombre, :cantidad_necesaria, :cantidad_a_cotizar, :cantidad_restante], productos_registrados: [:det_nec_mercaderia_id, :prod_producto_id, :nombre, :cantidad_necesaria, :cantidad_a_cotizar, :cantidad_restante])
    end

    def set_precio_cotizacion_params 
      params.require(:detalle_cotizacion).permit(:id_empresa, :cotizacion_id, :necesidad_mercaderia_id, productos_no_registrados: [:det_nec_mercaderia_id, :nombre, :cantidad_a_cotizar, :cantidad_disponible, :precio_cotizado], productos_registrados: [:det_nec_mercaderia_id, :prod_producto_id, :nombre, :cantidad_a_cotizar, :cantidad_disponible, :precio_cotizado])
    end

    
end
