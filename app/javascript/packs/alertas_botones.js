import Swal from 'sweetalert2';

document.addEventListener("turbolinks:load", function () {

    /**
      * Muestra un cuadro de diálogo de confirmación cuando se hace clic en un botón.
      * 
      * @param {string} btnClass - El selector del botón al que se adjunta el evento de clic.
      * @param {string} title - El título que se muestra en el cuadro de diálogo de confirmación.
      * @param {string} confirmButtonText - El texto que se muestra en el botón de confirmación del cuadro de diálogo.
      * @param {string} cancelButtonText - El texto que se muestra en el botón de cancelación del cuadro de diálogo.
      * @param {string} accion - Un parámetro opcional que por defecto es 'inactivar'. Se utiliza para construir el mensaje de texto que se muestra en el cuadro de diálogo de confirmación.
      */

    function confirmStatus(btnClass, title = 'Aplicar Cambios', confirmButtonText = 'Sí, ', cancelButtonText = 'No, Cancelar', accion = 'Inactivar') {
        $(document).on('click', btnClass, function (e) {
            e.preventDefault();

            var status = this.dataset.status;
            var nombre = this.dataset.nombre;

            const swalWithBootstrapButtons = Swal.mixin({
              customClass: {
                confirmButton: "btn btn-success",
                cancelButton: "btn btn-danger"
              },
              buttonsStyling: false,
              didOpen: () => {
                // Aplicar margen a los botones directamente cuando el modal se abre
                const buttons = document.querySelectorAll('.swal2-confirm, .swal2-cancel');
                buttons.forEach(button => {
                  button.style.margin = '0 5px';
                });
              }
            });
            swalWithBootstrapButtons.fire({
              title: title,
              text: '¿Estás seguro de ' + (status==null ? accion : status) + ' '+ nombre +' ?',
              icon: "warning",
              showCancelButton: true,
              confirmButtonText: confirmButtonText + (status==null ? accion : status),
              cancelButtonText: cancelButtonText,
              reverseButtons: true
            }).then((result) => {
              if (result.isConfirmed) {
                window.location.href = this.href;
              }
            });
        });
    }

    function confirmSave(btnClass, title = 'Aplicar Cambios', confirmButtonText = 'Sí, ', cancelButtonText = 'No, Cancelar', accion = 'Guardar') {
      $(document).on('click', btnClass, function (e) {
        e.preventDefault();
        var evento = this.dataset.evento;
        var retornaFormulario = (this.dataset.retornaFormulario == null ? "SI" : this.dataset.retornaFormulario);
        var nombre = this.dataset.nombre;

        const swalWithBootstrapButtons = Swal.mixin({
          customClass: {
            confirmButton: "btn btn-success",
            cancelButton: "btn btn-danger"
          },
          buttonsStyling: false,
          didOpen: () => {
            // Aplicar margen a los botones directamente cuando el modal se abre
            const buttons = document.querySelectorAll('.swal2-confirm, .swal2-cancel');
            buttons.forEach(button => {
              button.style.margin = '0 5px';
            });
          }
        });
        swalWithBootstrapButtons.fire({
          title: title,
          text: '¿Estás seguro de ' + (evento==null ? accion : evento) + ' '+ nombre + ' ?',
          icon: "warning",
          showCancelButton: true,
          confirmButtonText: confirmButtonText + (evento==null ? accion : evento),
          cancelButtonText: cancelButtonText,
          reverseButtons: true
        }).then((result) => {
          if (result.isConfirmed) {
            if (retornaFormulario === 'SI'){
              // Encuentra el formulario más cercano y lo envía
              $(this).closest('form').submit();
            } else if(retornaFormulario === 'NO'){
              window.location.href = this.href;
            } 
          }
        });
      });
    }
    
    confirmStatus('.btn_inactivar_estado', 'Inactivar Estado', '¡Sí, inactivarlo!');
    confirmStatus('.btn_activar_estado', 'Activar Estado', '¡Sí, Activarlo!', 'activar');
    confirmStatus('.btn_inactivar_parametro', 'Inactivar Parámetro', '¡Sí, inactivarlo!');
    confirmStatus('.btn_activar_parametro', 'Activar Parámetro', '¡Sí, Activarlo!', 'activar');
    
    confirmStatus('.btn_status_empresa');
    confirmStatus('.btn_status_area');
    confirmStatus('.btn_status_usuario');
    confirmStatus('.btn_status_persona_area');
    confirmStatus('.btn_status_rol');
    confirmStatus('.btn_status_menu');
    confirmStatus('.btn_status_sub_opcion');
    confirmStatus('.btn_status_opcion');
    confirmStatus('.btn_status_menu_rol');
    confirmStatus('.btn_status_unidad_medida');
    confirmStatus('.btn_status_tipo_seleccion');
    confirmStatus('.btn_status_tipo_contenido');
    confirmStatus('.btn_status_tipo_campo');
    confirmStatus('.btn_status_tipo_formulario');
    confirmStatus('.btn_status_tipo_frecuencia');
    confirmStatus('.btn_status_config_sub_pregunta');
    confirmStatus('.btn_status_config_pregunta');
    confirmStatus('.btn_status_config_formulario');

    confirmSave('.btn_event_empresa');
    confirmSave('.btn_event_area');
    confirmSave('.btn_event_usuario');
    confirmSave('.btn_event_persona_area');
    confirmSave('.btn_event_rol');
    confirmSave('.btn_event_menu');
    confirmSave('.btn_event_sub_opcion');
    confirmSave('.btn_event_opcion');
    confirmSave('.btn_event_unidad_medida');
    confirmSave('.btn_event_tipo_seleccion');
    confirmSave('.btn_event_tipo_contenido');
    confirmSave('.btn_event_tipo_campo');
    confirmSave('.btn_event_tipo_formulario');
    confirmSave('.btn_event_tipo_frecuencia');
    confirmSave('.btn_event_config_sub_pregunta');
    confirmSave('.btn_event_config_pregunta');
    confirmSave('.btn_event_config_formulario');

    confirmSave('.btn_password_usuario');
    confirmSave('.btn_enviar_credencial');
});