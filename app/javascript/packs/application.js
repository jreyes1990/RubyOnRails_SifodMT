require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
// require("channels")
require('datatables.net-bs4')
require('datatables.net-responsive')
//= require active_admin_datetimepicker
//= require bootstrap-toggle

import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'
import "@fortawesome/fontawesome-free/js/all";
import "@fortawesome/fontawesome-free/css/all.css";
import 'select2'
import 'select2/dist/css/select2.css'
import 'select2/dist/js/i18n/es'
import 'smartwizard'
import 'smartwizard/dist/css/smart_wizard_all.min.css'

import "datatables.net-responsive-bs4/css/responsive.bootstrap4";
import "datatables.net-rowgroup-bs4/css/rowGroup.bootstrap4";
import "datatables.net-rowgroup/js/dataTables.rowGroup";
import "datatables.net-rowgroup-bs4/js/rowGroup.bootstrap4";


import "bootstrap-tooltip-custom-class/bootstrap-v4/popover/dist/css/bootstrap-popover-custom-class";
import "bootstrap-tooltip-custom-class/bootstrap-v4/tooltip/dist/css/bootstrap-tooltip-custom-class";

// import "sweetalert2/dist/sweetalert2";

import {
    left
} from '@popperjs/core'

import Swal from 'sweetalert2';
var jQuery = require("jquery");

// import jQuery from "jquery";
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

import "./datatable_custom";
import "./search_ajax_custom";
import "./wizard_form_custom";
import "./datatable_ajax"
import {
    setupInputChangeHighlight,
    setupChangeDetectionWithPopover,
    setupRemovalFunctionality,
    addDetalleWithPrompt,
    initializeSelect2WithAjax,
    trackSelectedValues,

} from "./detalle_funciones";

import "./alertas_botones";
// import log from 'stimulus_reflex/javascript/log'

document.addEventListener("turbolinks:load", () => {
    require("./custom");
    /* *******************************************************   
     * Configuraciones para Datatables
     * ******************************************************** */
    var espanol = {
        lengthMenu: "Mostrar _MENU_ Entradas",
        zeroRecords: "No hay ningun dato creado para mostrar",
        info: "Mostrando de _START_ a _END_ datos de _TOTAL_ creados",
        infoEmpty: "No hay registros disponibles",
        infoFiltered: "(resultados filtrados de _MAX_ en total)",
        search: "",
        paginate: {
            first: "Inicio",
            previous: "Anterior",
            next: "Siguiente",
            last: "Ultimo"
        }
    };

    var var_dom_col = "<'row'<'col-12 col-lg-4 custom-center'l><'col-12 col-lg-4 d-flex justify-content-center'B><'col-12 col-lg-4 custom-center'f>>" +
        "<'row'<'col-12'tr>>" +
        "<'row'<'col-12 d-flex justify-content-center'i><'col-12 d-flex justify-content-center'p>>";

    $(document).ajaxSend(function (e, xhr, options) {
        var token = $("meta[name='csrf-token']").attr("content");
        xhr.setRequestHeader("X-CSRF-Token", token);
    });

    /* *******************************************************   
     * Para controlar el sidebar en posición cerrado o abierto
     * ******************************************************** */
    let sidebarState = sessionStorage.getItem('sidebar');
    $(".sidebar").toggleClass(sidebarState);

    $("#sidebarToggle, #sidebarToggleTop").on('click', function (e) {
        $("body").toggleClass("sidebar-toggled");
        $(".sidebar").toggleClass("toggled");
        if ($(".sidebar").hasClass("toggled")) {
            sessionStorage.setItem('sidebar', 'toggled');
            $('.sidebar .collapse').collapse('hide');
        } else {
            sessionStorage.setItem('sidebar', '');
        };
    });

    // Cierre cualquier acordeón de menú abierto cuando la ventana cambie de tamaño a continuación 768px
    if ($(window).width() < 768) {
        $('.sidebar .collapse').collapse('hide');
    };

    // Cierre cualquier acordeón de menú abierto cuando la ventana cambie de tamaño a continuación 480px
    if ($(window).width() < 480 && !$(".sidebar").hasClass("toggled")) {
        $("body").addClass("sidebar-toggled");
        $(".sidebar").addClass("toggled");
        $('.sidebar .collapse').collapse('hide');
    };

    if (sidebarState == 'toggled') {
        $(".menu_sb").addClass("collapsed");
        $(".opcion_sb").removeClass("show");
    }
    /* *******************************************************   
     * Fin para controlar el sidebar en posición cerrado o abierto
     * ******************************************************** */

    // Configuracion de Scroll Top Button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 40) {
            $('#topBtn').fadeIn();
        } else {
            $('#topBtn').fadeOut();
        }
    });
    $("#topBtn").click(function () {
        $('html ,body').animate({
            scrollTop: 0
        }, 800)
    });

  //MOSTRAR U OCULTAR CONTRASEÑA INICIO DE SESIÓN
  $('#show_password').on('click', function (e) {
    var cambio = document.getElementById("txtPassword");
    if (cambio.type == "password") {
      cambio.type = "text";
      $('.icon').removeClass('fa fa-eye-slash').addClass('fa fa-eye');
    } else {
      cambio.type = "password";
      $('.icon').removeClass('fa fa-eye').addClass('fa fa-eye-slash');
    }
    $('#Password').attr('type', $(this).is(':checked') ? 'text' : 'password');
  });

  $(document).ready(function () {
    $('#show_password_new').click(function () {
      var tipo = document.getElementById("txtPasswordNew");

      if (tipo.type == "password") {
        $('#txtPasswordNew').attr('type', 'text');
        $('#mostrar').addClass('fa fa-eye').removeClass('fa fa-eye-slash');
      } else {
        $('#txtPasswordNew').attr('type', 'password');
        $('#mostrar').addClass('fa fa-eye-slash').removeClass('fa fa-eye');
      }
    });
  });

  // Configuracion para activar select2
  $('.select2').select2({
    theme: "bootstrap4",
    language: "es-GT",
    width: '100%'
  });

  // Inicializar Bootstrap Toggle:
  $("[data-toggle='toggle']").bootstrapToggle({
    on: 'SI',
    off: 'NO',
    onstyle: 'success',
    offstyle: 'danger',
    size: 'small',
    width: '90',
    height: 'auto'
  });

  // Elimina la clase form-check de todos los toggles
  $(".toggle").parent().removeClass("form-check");

  // Aplicar el estilo con un pequeño retraso y mayor especificidad
  $('.form-check-input[data-toggle="toggle"]')
  .parent()
  .css('border-radius', '20px')
  .css('padding', '10px')
  .hover(
    function() {
      $(this).css('box-shadow', '0px 2px 5px rgb(29, 82, 44)');
    },
    function() {
      $(this).css('box-shadow', 'none');
    }
  );
  

  // Configuracion para combos dinamicos menu-opciones
  var opcion = $('#menu_rol_opciones_id').html()

  $('#menu_menu_id').on('select2:select', function (e) {
    var menu = $('#menu_menu_id :selected').text()
    var opcionesByMenu = $(opcion).filter("optgroup[label='" + menu + "']").html()

    if (opcionesByMenu)
      $('#menu_rol_opciones_id').html(opcionesByMenu)
    else
      $('#menu_rol_opciones_id').empty()
  });

  $('div.toggle-vis').on('click', function (e) {
    //e.preventDefault();
    // Get the column API object
    var column = table.column($(this).attr('data-column'));

    // Toggle the visibility
    column.visible(!column.visible());
  });

  //BUSCADOR USUARIOS
  $('.select2-usuario').select2({
    ajax: {
      url: $('.select2-usuario').data('endpoint'),
      dataType: "json",
      delay: 500,
      data: function (params) {
        return {
          q: params.term, // search term
          page: params.page
        };
      },
      processResults: function (data, page) {
        return {
          //results: data
          results: $.map(data, function (value, index) {
            return {
              id: value.valor_id,
              text: value.valor_text
            };
          })
        };
      }
    },
    minimumInputLength: 3,
    theme: "bootstrap4",
    language: "es-GT",
    width: '100%'
  });

  $('.add_permisos_perfil_id').hide();
  $('.add_permisos_opcion_id').hide();

  $('[name="add_permisos[options]"]').on('change', function () {
    if ($(this).val() == '0') {
      $('.add_permisos_perfil_id').show();
      $('.add_permisos_opcion_id').hide();
      $('#add_permisos_perfil_id').attr("required", true);
      $('#add_permisos_opcion_id').removeAttr('required');

    } else {
      $('.add_permisos_perfil_id').hide();
      $('.add_permisos_opcion_id').show();
      $('#add_permisos_perfil_id').removeAttr('required');
      $('#add_permisos_opcion_id').attr("required", true);
    }
  });

  //funcion para seleccionar los permisos por perfil
  $('.select2-perfil').on('select2:select', function (e) {
    $.ajax({
      url: $('.path_opciones_perfil').data('endpoint'),
      type: 'GET',
      dataType: "json",
      data: {
        role_id: e.params.data.id
      },
      success: function (data) {
        if (data.response == '1') {
          $('#rowFormularios').html(data.data);
          $('#divOpciones').show();
        } else {
          $('#rowFormularios').html("");
          $('#divOpciones').hide();
        }
      }
    });
  });

  //funcion para seleccionar los permisos individualmente
  $('.select2-individual').on('select2:select', function (e) {
    $.ajax({
      url: $('.path_opciones_individual').data('endpoint'),
      type: 'GET',
      dataType: "json",
      data: {
        opcion_id: e.params.data.id
      },
      success: function (data) {
        if (data.response == '1') {
          $('#rowFormularios').html(data.data);
          $('#divOpciones').show();
        } else {
          $('#rowFormularios').html("");
          $('#divOpciones').hide();
        }
      }
    });
  });

  //funcion para los mensajes de los toggle en las tablas
  $(function () {
    $('[title]').attr("data-rel", "tooltip");
    $("[data-rel='tooltip']")
      .attr("data-placement", "top")
      /*.attr("data-content", function() {
          return $(this).attr("title")
      })
      .removeAttr('title')*/;

    var showPopover = function () {
      $(this).popover('show');
    };
    var hidePopover = function () {
      $(this).popover('hide');
    };
    $("[data-rel='tooltip']").popover({
      trigger: 'manual'
    }).click(showPopover).hover(showPopover, hidePopover);
  });

  //control de los tiempos de los flash
  $(".alert").fadeTo(5000, 500).slideUp(500, function () {
    $(".alert").slideUp(5000);
  });

  //BUSCADOR EMPLEADOS WS
  if (window.gon != null) {
    $('.select2-empleado').select2({
      ajax: {
        url: gon.url_api + gon.nombre_rama,
        dataType: gon.datatype,
        delay: 500,
        headers: {
          "Authorization": "Bearer " + gon.token,
          "Content-Type": gon.contentype,
        },
        data: function (params) {
          return {
            empleado: params.term, // search term
            page: params.page,
            user: gon.user,
            codigo_empresa: gon.codigo_empresa
          };
        },
        processResults: function (data, page) {
          return {
            //results: data
            results: $.map(data, function (value, index) {
              return {
                id: value.valor_id,
                text: value.valor_text
              };
            })
          };
        }
      },
      minimumInputLength: 3,
      theme: "bootstrap4",
      language: "es-GT",
      width: '100%'
    });

    //CAPTURA DATOS DE EMPLEADO SELECCIONADO
    $('.select2-empleado').on('select2:select', function (e) {
      var codigo_empleado = e.params.data.id;
      var nombre_empleado = e.params.data.text;

      $('#seleccion_empleado_codigo_empleado').val(codigo_empleado);
      $('#seleccion_empleado_nombre_empleado').val(nombre_empleado);
    });
  }

  //BUSCADOR EMPRESAS
  $('.select2-empresa').select2({
    ajax: {
      url: $('.select2-empresa').data('endpoint'),
      dataType: "json",
      delay: 500,
      data: function (params) {
        return {
          q: params.term, // search term
          page: params.page
        };
      },
      processResults: function (data, page) {
        return {
          //results: data
          results: $.map(data, function (value, index) {
            return {
              id: value.valor_id,
              text: value.valor_text
            };
          })
        };
      }
    },
    minimumInputLength: 2,
    theme: "bootstrap4",
    language: "es-GT",
    width: '100%'
  });

  $('#usuario_selected_id').on('select2:select', function (e) {
    $.ajax({
      url: $('.path_search_area_empresa_p').data('endpoint'),
      type: 'GET',
      dataType: "json",
      data: {
        area_empresa_persona_id_param: e.params.data.id
      },
      success: function (data) {
        $("#area_empresa_persona_id").empty();
        var json = data;

        for (var i of json) {
          $("#area_empresa_persona_id").append("<option value='" + i.id + "'>" + i.area + "</option>");
        }
      }
    });
  });

    /**
     * Inicia Rendimiento para modales anidados
     */
    var modal_lv = 0;
    $('.modal').on('shown.bs.modal', function (e) {
        $('.modal-backdrop:last').css('zIndex', 1051 + modal_lv);
        $(e.currentTarget).css('zIndex', 1052 + modal_lv);
        modal_lv++
    });

    $('.modal').on('hidden.bs.modal', function (e) {
        modal_lv--;
        if ($('.modal:visible').length > 0) {
            $('body').addClass('modal-open');
        }
    });
    /**
     * Fin Rendimiento para modales anidados
     */

    $(".custom-file-input").on("change", function () {
        var fileName = $(this).val().split("\\").pop();
        $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
    });

    /* necesitamos agregar un pequeño fragmento de JavaScript para evitar que el evento de zoom se propague al contenedor padre */
    document.addEventListener('DOMContentLoaded', function () {
        var zoomableImages = document.querySelectorAll('.zoomable-image');
        zoomableImages.forEach(function (image) {
            image.addEventListener('mouseenter', function (e) {
                e.stopPropagation();
            });
        });
    });
    


  /** 
   * Función para inicializar los select2 con ajax 
   * @param {string} selector - Selector del elemento select2, ejemplo: "#empresa_id_estado_x_proceso"
   * @param {string} search_param - Nombre del parámetro de búsqueda para el endpoint
   * @param {string} ajax_param - Nombre del parámetro de búsqueda para el endpoint de la segunda llamada
   * @param {function} success_callback - Función que se ejecuta cuando la segunda llamada es exitosa
   * @param {function} clear_callback - Función que se ejecuta cuando la segunda llamada no es exitosa
   * @param {function} post_select_callback - Función que se ejecuta después de seleccionar un elemento del select2, puede ir null (opcional) ejemplo en BUSCADOR PG_EMPRESA PARA ESTADO POR PROCESO
   * @param {string} modal_id - Id del modal donde se encuentra el select2, puede ir null (opcional)
   * @param {object} additional_params_func - Función que retorna un objeto con los parámetros adicionales que se enviarán en la primer llamada, puede ir null (opcional)
   */
  function initializeSelect2(selector, search_param, ajax_param, success_callback, clear_callback, post_select_callback = null, modal_id = null, additional_params_func = null) {
    if ($(selector).length === 0) {
      return; // Sal del método si el elemento no está presente
    }
    $(selector).select2({
      ajax: {
        url: $(selector).data('endpoint'),
        dataType: "json",
        delay: 500,
        data: function (params) {
          let search_obj = {};
          search_obj[search_param] = params.term;

          if (additional_params_func) {
            let additional_params = additional_params_func();
            for (let key in additional_params) {
              if (additional_params.hasOwnProperty(key)) {
                search_obj[key] = additional_params[key];
              }
            }
          }

          return search_obj;
        },
        processResults: function (data, page) {
          return {
            results: $.map(data, function (value, index) {
              return {
                id: value.valor_id,
                text: value.valor_text
              };
            })
          };
        }
      },
      minimumInputLength: 2,
      theme: "bootstrap4",
      language: "es-GT",
      width: '100%',
      dropdownParent: modal_id ? $(modal_id) : undefined
    }).on('select2:select', function (e) {
      var selectedOption = e.params.data.id;
      if (selectedOption !== '') {
        if (post_select_callback) {
          post_select_callback(selectedOption);
        }
        let ajax_data = {};
        ajax_data[ajax_param] = selectedOption;
        $.ajax({
          url: $(this).data('endpoint'),
          dataType: "json",
          data: ajax_data,
          success: success_callback
        });
      } else {
        clear_callback();
      }
    });
  }

  /**
     * Establece el valor y el texto de un elemento Select2 y dispara manualmente el evento 'select2:select'.
     * Esta función es útil para inicializar o actualizar elementos Select2 con valores dinámicos, especialmente
     * cuando estos valores se obtienen mediante llamadas AJAX o están definidos en el lado del servidor y se necesitan
     * reflejar en el cliente sin una interacción directa del usuario.
     */
  window.seleccionarEmpresa = function (selector, empresaId, empresaTexto) {
    $(selector).val(empresaId).trigger('change');

    $(selector).trigger({
      type: 'select2:select',
      params: {
        data: {
          id: empresaId,
          text: empresaTexto
        }
      }
    });
  }

  /**
   * Función para los select2 con ajax 
   * @param {String} selector - Selector del elemento select2, ejemplo: "#empresa_id_estado_x_proceso"
   * @param {*} data - Se ejecuta cuando la llamada es exitosa
   * @param {string} titulo - Titulo del selector
   */
  function fillSelectOptions(selector, data, titulo) {
    $(selector).empty().append("<option value='" + 0 + "'>" + titulo + "</option>");

    for (var item of data) {
      $(selector).append(`<option value='${item.valor_id}'>${item.valor_text}</option>`);
    }
  }

  function initializeModalContent() {
    //FUNCIONALIDAD DE FORMULARIO WIZARD  
    function validateFields(activeTab) {
      var requiredFields = activeTab.querySelectorAll('input[required], textarea[required], select[required]');
      var allValid = true;

      if (requiredFields.length > 0) {
        requiredFields.forEach(function (field) {
          if (!field.checkValidity()) {
            allValid = false;
            field.reportValidity();
          }
        });
      }

      return allValid;
    }

    function nextTab(elem) {
      elem.nextElementSibling.querySelector('a[data-toggle="tab"]').click();
    }

    function prevTab(elem) {
      elem.previousElementSibling.querySelector('a[data-toggle="tab"]').click();
    }

    var nextSteps = document.querySelectorAll('.next-step');
    var prevSteps = document.querySelectorAll('.prev-step');
    var navTabs = document.querySelectorAll('.nav-tabs li');

    nextSteps.forEach(function (button) {
      button.addEventListener('click', function (e) {
        var activeTab = document.querySelector('.tab-pane.active');
        var activeNav = document.querySelector('.wizard .nav-tabs li.active');
        if (validateFields(activeTab)) {
          activeNav.nextElementSibling.classList.remove('disabled');
          nextTab(activeNav);
        }
        e.preventDefault(); // Prevenir el comportamiento predeterminado
      });
    });

    prevSteps.forEach(function (button) {
      button.addEventListener('click', function (e) {
        var activeNav = document.querySelector('.wizard .nav-tabs li.active');
        prevTab(activeNav);
        e.preventDefault(); // Prevenir el comportamiento predeterminado
      });
    });

    navTabs.forEach(function (tab) {
      tab.addEventListener('click', function (e) {
        if (this.classList.contains('disabled')) {
          e.stopPropagation();
          return;
        }

        var activeNav = document.querySelector('.nav-tabs li.active');
        activeNav.classList.remove('active');
        this.classList.add('active');
        e.preventDefault(); // Prevenir el comportamiento predeterminado
      });
    });

    // Deshabilita inicialmente todos los botones de navegación superior
    navTabs.forEach(function (tab, i) {
      if (i > 0) { // Si no es el primer botón
        tab.classList.add('disabled');
      }
    });
  }


  function enviarFormularioAjax() {
    const formulario = document.getElementById('search_form_factura');
    const searchButton = document.getElementById('search_button');
    const urlString = searchButton.getAttribute('data-url');
    const url = new URL(urlString, window.location.origin);

    // Añadir los datos del formulario a la URL como parámetros de consulta
    new FormData(formulario).forEach((value, key) => url.searchParams.append(key, value));

    fetch(url, {
        method: 'GET'
    })
    .then(response => response.text())
    .then(data => {
      generarTabla(data);

    })
    .catch(error => {
      console.error('Error:', error);
    });
  }

  if (document.getElementById('search_button')) {

    document.getElementById('search_button').addEventListener('click', (event) => {
      event.preventDefault();

      if (validarFormulario()) {
        enviarFormularioAjax();
      } else {
        // Manejar la situación cuando la validación falla, por ejemplo:
        alert("Por favor completa todos los campos requeridos.");
      }
    });
  }

  /* BUSCADOR AREA - EMPRESA, EN EL MODULO USUARIO */
  initializeSelect2(
    "#empresa_id_usuario",
    "search_empresa_usuario_params",
    "empresa_usuario_params",
    function (data) {
      fillSelectOptions("#area_id_usuario", data.area_empresa, "Seleccione una área");
    },
    function () {
      $("#area_id_usuario").empty().trigger('change');
    }
  );

  initializeSelect2(
    "#empresa_id_unidad_medida",
    "search_empresa_unidad_medida_params",
    "empresa_unidad_medida_params",
    function (data) {
      fillSelectOptions("#medida_id_unidad_medida", data.list_pg_medida, "Seleccione una medida");
    },
    function () {
      $("#medida_id_unidad_medida").empty().trigger('change');
    },
    null,
    null
  );

  // Iniciando la busqueda de datos de lado de pg_medida
  initializeSelect2(
    "#medida_id_unidad_medida",
    "search_datos_unidad_medida_params",
    "datos_unidad_medida_params",
    function (data) {
      $("#abreviatura_unidad_medida").val(data.abr_pg_medida).trigger('change');
      $("#nombre_unidad_medida").val(data.nombre_pg_medida).trigger('change');
    },
    function () {
      $("#abreviatura_unidad_medida, #nombre_unidad_medida").empty().trigger('change');
    },
    null,
    null
  );

  initializeSelect2(
    "#empresa_id_tipoFormulario",
    "search_empresa_tipo_formulario_params",
    "empresa_tipo_formulario_params",
    function (data) {
      fillSelectOptions("#area_id_tipoFormulario", data.list_pg_area, "Seleccione un área de negocio");
    },
    function () {
      $("#area_id_tipoFormulario").empty().trigger('change');
    },
    null,
    null
  );

  initializeSelect2(
    "#empresa_id_tipoFrecuencia",
    "search_empresa_tipo_frecuencia_params",
    "empresa_tipo_frecuencia_params",
    function (data) { },
    function () { },
    null,
    null
  );

});
