select personas_areas.*,
(personas.nombre||' '||personas.apellido) as nombre_usuario, 
personas.telefono as telefono_usuario, 
personas.user_id, 
users.email as email_usuario,
areas.codigo_area, 
areas.nombre as nombre_area, 
areas.codigo_hex as codigo_hex_area, 
areas.empresa_id, 
empresas.codigo_empresa, 
empresas.nombre as nombre_empresa,
roles.nombre as nombre_rol, 
roles.codigo_hex as codigo_hex_rol
from personas_areas 
inner join personas on(personas_areas.persona_id=personas.id)
inner join users on(personas.user_id=users.id)
inner join areas on(personas_areas.area_id=areas.id)
inner join empresas on(areas.empresa_id=empresas.id)
left join roles on(personas_areas.rol_id=roles.id);