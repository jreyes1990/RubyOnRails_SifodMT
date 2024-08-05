usuarios = [
  #{ email: "developer.madretierragt@gmail.com",  encrypted_password: "$2a$12$XM9n0jp/ut8OJ5fD5Gamo.4o/OMc4UgKYrq7EQ.3hLGxSpb2P/cqW", reset_password_token: "2d26e6612f4eaecec1c0baa7f7a4a71801ffb12d64b864aff3173a4eea0896aa", reset_password_sent_at: "2021-11-11 22:48:09", remember_created_at: nil, estado: "A", user_created_id: 1, user_updated_id: nil }
  { email: "developer.madretierragt@gmail.com",  password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, estado: "A", user_created_id: 1, user_updated_id: nil }
]

# Desactiva temporalmente el callback que crea una entrada en personas
# User.skip_callback(:create, :after, :set_persona) if User.respond_to?(:skip_callback)

usuarios.each do |user_params|
  usuario = User.find_or_initialize_by(email: user_params[:email])

  if usuario.persisted?  # Verifica si el usuario ya existe en la base de datos
    usuario.update!(user_params)
    puts "Usuario '#{user_params[:email]}' actualizado"
  else
    usuario.assign_attributes(user_params)
    usuario.save!(validate: false)
    puts "Usuario '#{user_params[:email]}' creado"
  end
end

# Reactiva el callback después de la creación de los usuarios
# User.set_callback(:create, :after, :set_persona) if User.respond_to?(:set_callback)

personas = [
  { nombre: "Developer", apellido: "Madre Tierra", direccion: "Santa Lucia Cotzumalguapa", estado: "A", telefono: "66854900", user_id: 1, user_created_id: 1 }
]

personas.each do |persona_params|
  persona = Persona.find_or_initialize_by(user_id: persona_params[:user_id])

  if persona.persisted?  # Verifica si la persona ya existe en la base de datos
    persona.update!(persona_params)
    puts "Persona #{persona.nombre} #{persona.apellido} actualizada"
  else
    persona.assign_attributes(persona_params)
    persona.save!
    puts "Persona #{persona.nombre} #{persona.apellido} creada"
  end
end

empresas = [
  { codigo_empresa: 2, nombre: "Ingenio Madre Tierra", descripcion: "Empresa productora de azucar y sus derivados", codigo_hex: "#232323", estado: "A", user_created_id: 1, user_updated_id: nil }
]

empresas.each do |empresa_params|
  empresa = Empresa.find_or_initialize_by(codigo_empresa: empresa_params[:codigo_empresa])

  if empresa.persisted?  # Verifica si la empresa ya existe en la base de datos
    empresa.update!(empresa_params)
    puts "Empresa '#{empresa_params[:nombre]}' actualizada"
  else
    empresa.assign_attributes(empresa_params)
    empresa.save!
    puts "Empresa '#{empresa_params[:nombre]}' creada"
  end
end

areas = [
  { empresa_id: 1, codigo_area: 9, nombre: "Informatica", descripcion: "Departamento de Tecnologia e Informacion de la empresa Ingenio Madre Tierra.", codigo_hex: "#232323", estado: "A", user_created_id: 1, user_updated_id: nil }
]

areas.each do |area_params|
  area = Area.find_or_initialize_by(codigo_area: area_params[:codigo_area], empresa_id: area_params[:empresa_id])

  if area.persisted?  # Verifica si el área ya existe en la base de datos
    area.update!(area_params)
    puts "Área '#{area_params[:nombre]} ' actualizada"
  else
    area.assign_attributes(area_params)
    area.save!(validate: false)
    puts "Área '#{area_params[:nombre]}' creada"
  end
end

roles = [
  { nombre: "SUPER ADMINISTRADOR", descripcion: "Rol para administrar todo el sistema", codigo_hex: "#232323", estado: "A", user_created_id: 1, user_updated_id: nil }
]

roles.each do |rol_params|
  rol = Rol.find_or_initialize_by(nombre: rol_params[:nombre])

  if rol.persisted?  # Verifica si el rol ya existe en la base de datos
    rol.update!(rol_params)
    puts "Rol '#{rol_params[:nombre]}' actualizado"
  else
    rol.assign_attributes(rol_params)
    rol.save!(validate: false)
    puts "Rol '#{rol_params[:nombre]}' creado"
  end
end


personas_areas = [
  { persona_id: 1, area_id: 1, rol_id: 1, user_created_id: 1, user_updated_id: nil, estado: "A" }
]

personas_areas.each do |pa_params|
  personas_area = PersonasArea.find_or_initialize_by(persona_id: pa_params[:persona_id], area_id: pa_params[:area_id])

  if personas_area.persisted?  # Verifica si el registro ya existe en la base de datos
    personas_area.update!(pa_params)
    puts "Relación Persona-Area para Persona ID '#{pa_params[:persona_id]}' y Área ID '#{pa_params[:area_id]}' actualizada"
  else
    personas_area.assign_attributes(pa_params)
    personas_area.save!
    puts "Relación Persona-Area para Persona ID '#{pa_params[:persona_id]}' y Área ID '#{pa_params[:area_id]}' creada"
  end
end

atributos = [
  { nombre: "VER", descripcion: "Atributo que nos brinda la opción de ver.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "ACCESAR", descripcion: "Atributo que nos brinda el permiso de acceso a partes del sistema", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "VER OPCION", descripcion: "Atributo que nos brinda la opción de ver una opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil }
]

atributos.each do |atributo_params|
  atributo = Atributo.find_or_initialize_by(nombre: atributo_params[:nombre])

  if atributo.persisted?  # Verifica si el atributo ya existe en la base de datos
    atributo.update!(atributo_params)
    puts "Atributo '#{atributo_params[:nombre]}' actualizado"
  else
    atributo.assign_attributes(atributo_params)
    atributo.save!
    puts "Atributo '#{atributo_params[:nombre]}' creado"
  end
end

componentes = [
  { nombre: "OPCION", descripcion: "Componente para la validación de permisos a nivel de opciones del sistema.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "BOTON NUEVO REGISTRO", descripcion: "Botón para agregar un nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "BOTON REGISTRAR", descripcion: "Botón para agregar un nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "BOTON EDITAR REGISTRO", descripcion: "Botón para editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "BOTON ELIMINAR REGISTRO", descripcion: "Botón para la eliminar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "BOTON ACTIVAR/INACTIVAR REGISTRO", descripcion: "Botón para activar o inactivar un dato.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "BOTON MODAL REGISTRO", descripcion: "Botón para registrar desde un modal.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "BOTON MODULO CARGA MASIVA", descripcion: "Botón para acceder al modulo de la importacion de datos desde excel.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "BOTON DESCARGA", descripcion: "Botón para la descarga de el formato.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "BOTON CARGA MASIVA", descripcion: "Botón para la importacion de datos desde un archivo.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: 'BOTON ENLACE MODULO', descripcion: 'Boton para acceder a los modulos.', user_created_id: 1, user_updated_id: nil, estado: 'A' },
  { nombre: 'BOTON ENLACE DETALLE MODULO', descripcion: 'Boton para acceder al detalle de los modulos.', user_created_id: 1, user_updated_id: nil, estado: 'A' },
  { nombre: 'BOTON GENERA REPORTE', descripcion: 'Boton para generar los reportes.', user_created_id: 1, user_updated_id: nil, estado: 'A' },
  { nombre: 'BOTON FILTRO', descripcion: 'Boton para filtrar parametros de consulta.', user_created_id: 1, user_updated_id: nil, estado: 'A' },
  { nombre: "MENU USUARIOS", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "MENU EMPRESAS", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "MENU AREAS EMPRESA", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "MENU USUARIO AREA", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "MENU ROL", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "MENU MENU", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "MENU SUB OPCION", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "MENU OPCION MENU", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "MENU MENU ROL", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "MENU ATRIBUTO", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "MENU COMPONENTE", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "MENU PERMISOS FORMULARIO", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "MENU PERMISOS USUARIO", descripcion: "Validación del Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil }
]

componentes.each do |componente_params|
  componente = Componente.find_or_initialize_by(nombre: componente_params[:nombre])

  if componente.persisted?  # Verifica si el componente ya existe en la base de datos
    componente.update!(componente_params)
    puts "Componente '#{componente_params[:nombre]}' actualizado"
  else
    componente.assign_attributes(componente_params)
    componente.save!
    puts "Componente '#{componente_params[:nombre]}' creado"
  end
end

menus = [
  { nombre: "SISTEMAS", menu_sidebar: "CONFIGURACIÓN", descripcion: "Menú padre que contendrá las configuraciones del sistema.", icono: "fas fa-fw fa-wrench", posicion: 1, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "CATÁLOGOS", menu_sidebar: "MENÚ", descripcion: "Menú padre que tendrá las opciones de los catálogos existentes", icono: "fas fa-fw fa-cog", posicion: 2, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil },
  { nombre: "UTILIDADES", menu_sidebar: "COMPLEMENTO", descripcion: "Menú padre que tendrá las utilidades del sistema", icono: "fas fa-images", posicion: 3, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil }
]

menus.each do |menu_params|
  menu = Menu.find_or_initialize_by(nombre: menu_params[:nombre])

  if menu.persisted?  # Verifica si el menú ya existe en la base de datos
    menu.update!(menu_params)
    puts "Menú '#{menu_params[:nombre]}' actualizado"
  else
    menu.assign_attributes(menu_params)
    menu.save!
    puts "Menú '#{menu_params[:nombre]}' creado"
  end
end

sub_opciones = [
  {nombre: "OPCIONES:", estado: "A", user_created_id: 1, user_updated_id: nil},
  {nombre: "PERMISOS:", estado: "A", user_created_id: 1, user_updated_id: nil}
]

sub_opciones.each do |sub_opcion_params|
  sub_opcion = SubOpcion.find_or_initialize_by(nombre: sub_opcion_params[:nombre])

  if sub_opcion.persisted?  # Verifica si el menú ya existe en la base de datos
    sub_opcion.update!(sub_opcion_params)
    puts "SubOpción '#{sub_opcion_params[:nombre]}' actualizado"
  else
    sub_opcion.assign_attributes(sub_opcion_params)
    sub_opcion.save!
    puts "SubOpción '#{sub_opcion_params[:nombre]}' creado"
  end
end

opciones = [
  {menu_id: 1, nombre: "Usuarios", componente_sidebar: "MENU USUARIOS", sub_opcion_id: 1, descripcion: "Opción del menú para la administración de los usuarios del sistema.", icono: "fas fa-users", path: "usuarios_index_path", controlador: "usuarios", posicion: 3, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil},
  {menu_id: 1, nombre: "Empresas", componente_sidebar: "MENU EMPRESAS", sub_opcion_id: 1, descripcion: "Opción del menú para la administración de las empresas del sistema.", icono: "fas fa-building", path: "empresas_path", controlador: "empresas", posicion: 1, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil},
  {menu_id: 1, nombre: "Áreas - Empresa", componente_sidebar: "MENU AREAS EMPRESA", sub_opcion_id: 1, descripcion: "Opción del menú para la administración de las áreas por empresa del sistema.", icono: "fas fa-sitemap", path: "areas_path", controlador: "areas", posicion: 2, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil},
  {menu_id: 1, nombre: "Usuarios - Área", componente_sidebar: "MENU USUARIO AREA", sub_opcion_id: 1, descripcion: "Opción del menú para la administración de las asignaciones del los usuarios a areas del sistema.", icono: "fas fa-users", path: "personas_areas_path", controlador: "personas_areas", posicion: 4, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil},
  {menu_id: 1, nombre: "Roles", componente_sidebar: "MENU ROL", sub_opcion_id: 1, descripcion: "Opción del menú para la administración de los roles del sistema.", icono: "fas fa-user-tag", path: "roles_path", controlador: "roles", posicion: 5, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil},
  {menu_id: 1, nombre: "Menús", componente_sidebar: "MENU MENU", sub_opcion_id: 1, descripcion: "Opción del menú para la administración de los menús del sistema.", icono: "fab fa-elementor", path: "menus_path", controlador: "menus", posicion: 6, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil},
  {menu_id: 1, nombre: "Sub Opcion", componente_sidebar: "MENU SUB OPCION", sub_opcion_id: 1, descripcion: "Opción del menú para la administración de las opciones por menú del sistema.", icono: "fas fa-minus-square", path: "sub_opciones_path", controlador: "sub_opciones", posicion: 7, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil},
  {menu_id: 1, nombre: "Opciones - Menú", componente_sidebar: "MENU OPCION MENU", sub_opcion_id: 1, descripcion: "Opción del menú para la administración de las opciones por menú del sistema.", icono: "fas fa-minus-square", path: "opciones_path", controlador: "opciones", posicion: 8, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil},
  {menu_id: 1, nombre: "Menús - Rol", componente_sidebar: "MENU MENU ROL", sub_opcion_id: 1, descripcion: "Opción del menú para la administración de los menús por rol del sistema.", icono: "fas fa-user-cog", path: "menu_roles_path", controlador: "menu_roles", posicion: 9, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil},
  {menu_id: 1, nombre: "Atributos", componente_sidebar: "MENU ATRIBUTO", sub_opcion_id: 1, descripcion: "Opción del menú para la administración de los atributos del sistema.", icono: "fas fa-atom", path: "atributos_path", controlador: "atributos", posicion: 10, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil},
  {menu_id: 1, nombre: "Componentes", componente_sidebar: "MENU COMPONENTE", sub_opcion_id: 1, descripcion: "Opción del menú para la administración de los componentes del sistema.", icono: "fab fa-codepen", path: "componentes_path", controlador: "componentes", posicion: 11, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil},
  {menu_id: 1, nombre: "Permisos Formulario", componente_sidebar: "MENU PERMISOS FORMULARIO", sub_opcion_id: 2, descripcion: "Opción del menú para la administración de los permisos por formulario del sistema.", icono: "fas fa-clipboard-list", path: "opcion_cas_path", controlador: "opcion_cas", posicion: 12, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil},
  {menu_id: 1, nombre: "Permisos Usuario", componente_sidebar: "MENU PERMISOS USUARIO", sub_opcion_id: 2, descripcion: "Opción del menú para la administración de los permisos por usuario del sistema.", icono: "fas fa-clipboard-list", path: "permisos_path", controlador: "persona_empresa_formularios", posicion: 13, visible_sidebar: true, estado: "A", user_created_id: 1, user_updated_id: nil}
]

opciones.each do |opcion_params|
  opcion = Opcion.find_or_initialize_by(nombre: opcion_params[:nombre], menu_id: opcion_params[:menu_id])

  if opcion.persisted?  # Verifica si el menú ya existe en la base de datos
    opcion.update!(opcion_params)
    puts "Opción '#{opcion_params[:nombre]}' actualizado"
  else
    opcion.assign_attributes(opcion_params)
    opcion.save!
    puts "Opción '#{opcion_params[:nombre]}' creado"
  end
end

menu_roles = [
  {rol_id: 1, opcion_id: 1, menu_id: 1, descripcion: "Asignación de Opción-Menú [Usuarios] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {rol_id: 1, opcion_id: 2, menu_id: 1, descripcion: "Asignación de Opción-Menú [Empresas] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {rol_id: 1, opcion_id: 3, menu_id: 1, descripcion: "Asignación de Opción-Menú [Áreas - Empresa] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {rol_id: 1, opcion_id: 4, menu_id: 1, descripcion: "Asignación de Opción-Menú [Usuarios - Área] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {rol_id: 1, opcion_id: 5, menu_id: 1, descripcion: "Asignación de Opción-Menú [Roles] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {rol_id: 1, opcion_id: 6, menu_id: 1, descripcion: "Asignación de Opción-Menú [Menús] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {rol_id: 1, opcion_id: 7, menu_id: 1, descripcion: "Asignación de Opción-Menú [SubOpción - Opción] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {rol_id: 1, opcion_id: 8, menu_id: 1, descripcion: "Asignación de Opción-Menú [Opciones - Menú] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {rol_id: 1, opcion_id: 9, menu_id: 1, descripcion: "Asignación de Opción-Menú [Menús - Rol] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {rol_id: 1, opcion_id: 10, menu_id: 1, descripcion: "Asignación de Opción-Menú [Atributos] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {rol_id: 1, opcion_id: 11, menu_id: 1, descripcion: "Asignación de Opción-Menú [Componentes] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {rol_id: 1, opcion_id: 12, menu_id: 1, descripcion: "Asignación de Opción-Menú [Permisos Formulario] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {rol_id: 1, opcion_id: 13, menu_id: 1, descripcion: "Asignación de Opción-Menú [Permisos Usuario] por rol.", estado: "A", user_created_id: 1, user_updated_id: nil}
]

menu_roles.each do |menurol_params|
  menu_rol = MenuRol.find_or_initialize_by(menu_id: menurol_params[:menu_id], opcion_id: menurol_params[:opcion_id], rol_id: menurol_params[:rol_id])

  if menu_rol.persisted?  # Verifica si el menú ya existe en la base de datos
    menu_rol.update!(menurol_params)
    puts "Menu-Rol '#{menurol_params[:menu_id]}'-'#{menurol_params[:opcion_id]}'-'#{menurol_params[:rol_id]}' actualizado"
  else
    menu_rol.assign_attributes(menurol_params)
    menu_rol.save!
    puts "Menu-Rol '#{menurol_params[:menu_id]}'-'#{menurol_params[:opcion_id]}'-'#{menurol_params[:rol_id]}' creado"
  end
end

opcion_cas = [
  {opcion_id: 1, componente_id: 15, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 1, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 1, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 1, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 1, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 1, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 1, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 1, componente_id: 7, atributo_id: 1, descripcion: "Permiso del botón registrar desde un modal.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 1, componente_id: 8, atributo_id: 1, descripcion: "Permiso del botón modulo carga masiva.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 1, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 1, componente_id: 10, atributo_id: 1, descripcion: "Permiso del botón carga masiva.", estado: "A", user_created_id: 1, user_updated_id: nil},

  {opcion_id: 2, componente_id: 16, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 2, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 2, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 2, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 2, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 2, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 2, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 2, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil},

  {opcion_id: 3, componente_id: 17, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 3, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 3, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 3, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 3, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 3, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 3, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 3, componente_id: 7, atributo_id: 1, descripcion: "Permiso del botón registrar desde un modal.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 3, componente_id: 8, atributo_id: 1, descripcion: "Permiso del botón modulo carga masiva.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 3, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 3, componente_id: 10, atributo_id: 1, descripcion: "Permiso del botón carga masiva.", estado: "A", user_created_id: 1, user_updated_id: nil},

  {opcion_id: 4, componente_id: 18, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 4, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 4, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 4, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 4, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 4, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 4, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 4, componente_id: 7, atributo_id: 1, descripcion: "Permiso del botón registrar desde un modal.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 4, componente_id: 8, atributo_id: 1, descripcion: "Permiso del botón modulo carga masiva.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 4, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 4, componente_id: 10, atributo_id: 1, descripcion: "Permiso del botón carga masiva.", estado: "A", user_created_id: 1, user_updated_id: nil},

  {opcion_id: 5, componente_id: 19, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 5, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 5, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 5, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 5, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 5, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 5, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 5, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil},

  {opcion_id: 6, componente_id: 20, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 6, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 6, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 6, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 6, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 6, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 6, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 6, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil},

  {opcion_id: 7, componente_id: 21, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 7, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 7, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 7, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 7, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 7, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 7, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 7, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil},

  {opcion_id: 8, componente_id: 22, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 8, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 8, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 8, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 8, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 8, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 8, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 8, componente_id: 7, atributo_id: 1, descripcion: "Permiso del botón registrar desde un modal.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 8, componente_id: 8, atributo_id: 1, descripcion: "Permiso del botón modulo carga masiva.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 8, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 8, componente_id: 10, atributo_id: 1, descripcion: "Permiso del botón carga masiva.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 8, componente_id: 14, atributo_id: 1, descripcion: "Permiso del botón filtro de parametros.", estado: "A", user_created_id: 1, user_updated_id: nil},

  {opcion_id: 9, componente_id: 23, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 9, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 9, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 9, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 9, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 9, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 9, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 9, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil},

  {opcion_id: 10, componente_id: 24, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 10, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 10, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 10, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 10, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 10, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 10, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 10, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil},

  {opcion_id: 11, componente_id: 25, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 11, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 11, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 11, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 11, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 11, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 11, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 11, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil},

  {opcion_id: 12, componente_id: 26, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 12, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 12, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 12, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 12, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 12, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 12, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 12, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil},

  {opcion_id: 13, componente_id: 27, atributo_id: 3, descripcion: "Permiso para ver la opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 13, componente_id: 1, atributo_id: 2, descripcion: "Permiso para acceder al modulo.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 13, componente_id: 2, atributo_id: 1, descripcion: "Permiso del botón nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 13, componente_id: 3, atributo_id: 1, descripcion: "Permiso del botón registrar.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 13, componente_id: 4, atributo_id: 1, descripcion: "Permiso del botón editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 13, componente_id: 5, atributo_id: 1, descripcion: "Permiso del botón eliminar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 13, componente_id: 6, atributo_id: 1, descripcion: "Permiso del botón activar/inactivar un regitro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {opcion_id: 13, componente_id: 9, atributo_id: 1, descripcion: "Permiso del botón descarga.", estado: "A", user_created_id: 1, user_updated_id: nil}
]

opcion_cas.each do |opcionca_params|
  opcionca = OpcionCa.find_or_initialize_by(opcion_id: opcionca_params[:opcion_id], componente_id: opcionca_params[:componente_id], atributo_id: opcionca_params[:atributo_id])

  if opcionca.persisted?  # Verifica si el menú ya existe en la base de datos
    opcionca.update!(opcionca_params)
    puts "Opcion-Ca '#{opcionca_params[:opcion_id]}'-'#{opcionca_params[:componente_id]}'-'#{opcionca_params[:atributo_id]}' actualizado"
  else
    opcionca.assign_attributes(opcionca_params)
    opcionca.save!
    puts "Opcion-Ca '#{opcionca_params[:opcion_id]}'-'#{opcionca_params[:componente_id]}'-'#{opcionca_params[:atributo_id]}' creado"
  end
end

pers_emp_forms = [
  {personas_area_id: 1, opcion_ca_id: 1, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 2, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 3, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 4, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 5, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 6, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 7, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 8, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 9, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 10, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 11, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 12, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 13, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 14, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 15, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 16, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 17, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 18, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 19, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 20, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 21, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 22, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 23, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 24, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 25, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 26, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 27, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 28, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 29, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 30, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 31, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 32, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 33, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 34, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 35, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 36, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 37, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 38, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 39, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 40, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 41, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 42, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 43, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 44, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 45, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 46, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 47, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 48, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 49, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 50, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 51, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 52, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 53, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 54, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 55, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 56, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 57, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 58, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 59, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 60, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 61, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 62, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 63, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 64, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 65, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 66, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 67, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 68, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 69, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 70, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 71, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 72, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 73, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 74, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 75, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 76, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 77, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 78, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 79, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 80, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 81, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 82, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 83, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 84, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 85, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 86, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 87, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 88, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 89, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 90, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 91, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 92, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 93, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 94, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 95, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 96, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 97, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 98, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 99, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 100, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 101, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 102, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 103, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 104, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 105, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 106, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 107, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 108, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 109, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 110, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 111, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 112, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 113, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 114, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 115, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 116, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil},
  {personas_area_id: 1, opcion_ca_id: 117, descripcion: "PERFIL", estado: "A", user_created_id: 1, user_updated_id: nil}
]

pers_emp_forms.each do |pers_emp_form_params|
  pers_emp_form = PersonaEmpresaFormulario.find_or_initialize_by(personas_area_id: pers_emp_form_params[:personas_area_id], opcion_ca_id: pers_emp_form_params[:opcion_ca_id])

  if pers_emp_form.persisted?  # Verifica si el menú ya existe en la base de datos
    pers_emp_form.update!(pers_emp_form_params)
    puts "Persona Empresa Formularios '#{pers_emp_form_params[:personas_area_id]}'-'#{pers_emp_form_params[:opcion_ca_id]}' actualizado"
  else
    pers_emp_form.assign_attributes(pers_emp_form_params)
    pers_emp_form.save!
    puts "Persona Empresa Formularios '#{pers_emp_form_params[:personas_area_id]}'-'#{pers_emp_form_params[:opcion_ca_id]}' creado"
  end
end