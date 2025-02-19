# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  # inflect.acronym 'RESTful'
  inflect.irregular "opcion", "opciones"
  inflect.irregular "opcion_ca", "opcion_cas"
  inflect.irregular "rol", "roles"
  inflect.irregular "sub_opcion", "sub_opciones"
  inflect.irregular "tipo_seleccion", "tipo_selecciones"
  inflect.irregular "tipo_frecuencia", "tipo_frecuencias"
  inflect.irregular "config_sub_pregunta", "config_sub_preguntas"
  inflect.irregular 'config_pregunta', 'config_preguntas'
  inflect.irregular 'config_formulario', 'config_formularios'
  inflect.irregular 'config_formulario_pregunta', 'config_formulario_preguntas'
end
