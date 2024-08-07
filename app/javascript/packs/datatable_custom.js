document.addEventListener("turbolinks:load", () => {
  var espanol = {
    lengthMenu: "Mostrar _MENU_ Entradas",
    zeroRecords: "No hay ningun dato creado para mostrar",
    info: "Mostrando de _START_ a _END_ datos de _TOTAL_ creados",
    infoEmpty: "No hay registros disponibles",
    infoFiltered: "(resultados filtrados de _MAX_ en total)",
    search: "",
    sProcessing: "Procesando...",
    sLoadingRecords: "Cargando...",
    paginate: {
      first: "Inicio",
      previous: "Anterior",
      next: "Siguiente",
      last: "Ultimo"
    }
  };

  var btnDescarga = [
    {
      text: '<i class="fas fa-file-excel"></i> ',
      extend: 'excelHtml5',
      fieldSeparator: '\t',
      extension: '.xlsx',
      titleAttr: 'Exportar a Excel'
    }
  ];
  var var_dom_col = "<'row'<'col-12 col-lg-4 custom-center'l><'col-12 col-lg-4 d-flex justify-content-center'B><'col-12 col-lg-4 custom-center'f>>" +
    "<'row'<'col-12'tr>>" +
    "<'row'<'col-12 d-flex justify-content-center'i><'col-12 d-flex justify-content-center'p>>";

  function parseCurrency(value) {
    return parseFloat(value.replace(/,/g, ''));
  }

  function formatCurrency(value) {
    return value.toLocaleString('es-GT', {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2
    });
  }

  // Definir la función para inicializar los popovers
  function initializePopovers() {
    $('[title]').attr("data-rel", "tooltip").attr("data-placement", "top");
    var showPopover = function () {
      $(this).popover('show');
    };
    var hidePopover = function () {
      $(this).popover('hide');
    };
    $("[data-rel='tooltip']").popover({
      trigger: 'manual'
    }).click(showPopover).hover(showPopover, hidePopover);
  }

  //datatable sin ajax
  //configuracion para datatables agrupados por columnas dinamico
  /**
      * Función para agrupar filas en un DataTable en base a múltiples columnas.
      * @param {string} var_dom - Selector o elemento DOM donde se mostrará el DataTable. Por ejemplo, '#datatable_familia_producto' o document.getElementById('datatable_familia_producto').
      * @param {Array} agrupaciones - Un array que contiene objetos con detalles de las columnas que se utilizarán para la agrupación. Cada objeto debe tener la forma { columnIndex: number, label: string }, donde columnIndex es el índice de la columna (comenzando desde 0) y label es el nombre o etiqueta de la columna que se utilizará para mostrar el nombre del grupo.
      * @param {Array|null} columnDefs - Un array opcional que contiene configuraciones adicionales para las columnas del DataTable, en el formato requerido por DataTables columnDefs. Puede ser nulo si no se necesita ninguna configuración adicional.
      * @param {Object} options - Opciones adicionales para configurar el DataTable, siguiendo el formato de configuración del DataTable. Puedes personalizar opciones como el orden, dom, lenguaje, botones, etc.
      * @param {number|null} total_columnas - total de columnas de la tabla,
      * @param {Array|null} excelIncludeColumns - columnas a excluir en la exportación a excel,
      * @param {string|null} excelFileName - nombre del archivo de excel
  */
  function agrupar_filas(var_dom, agrupaciones, columnDefs, options, total_columnas = null, excelIncludeColumns = null, excelFileName = null) {
    if ($(var_dom).length === 0) {
      return; // Sal del método si el elemento no está presente
    }

    if (excelIncludeColumns || excelFileName) {
      options.buttons = options.buttons.map(button => {
        if (button.extend === 'excelHtml5') {
          // Configura las columnas a excluir
          button.exportOptions = {
            columns: excelIncludeColumns
          };
          // Establece el nombre del archivo
          button.title = excelFileName;
        }
        return button;
      });
    }

    // Comprueba si agrupaciones está vacío
    if (!agrupaciones || agrupaciones.length === 0) {
      // Aquí puedes inicializar la tabla sin el rowGroup, si lo deseas
      $(var_dom).DataTable({
        "columnDefs": columnDefs || [],
        fixedHeader: options.fixedHeader,
        stateSave: options.stateSave,
        stateDuration: options.stateDuration,
        dom: options.dom,
        language: options.language,
        responsive: options.responsive,
        lengthChange: options.lengthChange,
        lengthMenu: options.lengthMenu,
        select: options.select,
        buttons: options.buttons,
        drawCallback: function (settings) {
          initializePopovers(); // Inicializar Popover después de cargar los datos
        },
        pagingType: options.pagingType
      });
      return;
    }

    var dataSrc = agrupaciones.map(agrupacion => agrupacion.columnIndex);
    var orden = agrupaciones.length > 1 ?
      agrupaciones.map(agrupacion => [agrupacion.columnIndex, agrupacion.order || 'asc']) :
      [];

    $(var_dom).DataTable({
      "order": orden,
      "columnDefs": [...agrupaciones.map(agrupacion => ({ "visible": false, "targets": agrupacion.columnIndex })), ...(columnDefs ?? [])],
      rowGroup: {
        dataSrc: dataSrc,
        startRender: function (rows, group, level) {
          var className = '';
          var groupName = '';
          var button = '';
          var buttonClass = `btn-level-${level}`;  // Clase para el botón según el nivel

          agrupaciones.forEach((agrupacion, index) => {
            if (level === index) {
              className = `group-start-level-${index}`;
              groupName = `${agrupacion.label}: ${group}`;

              // Si buttonRoute está definido en la configuración, generamos el botón
              if (agrupacion.buttonRoute) {
                button = `<a href="${agrupacion.buttonRoute}/id:${group}" class="btn ${buttonClass}">${agrupacion.buttonText ? agrupacion.buttonText : 'Ver Detalle'}</a>`;
              }
            }
          });

          var cellContent = `
              <div class="group-cell-container">
                  ${groupName}
                  ${button}
              </div>
          `;

          return $('<tr/>')
            .append(`<td colspan="20"> ${cellContent} </td>`)
            .addClass(className);
        },
        endRender: function (rows, group, level) {
          var agrupacion = agrupaciones[level];

          var totalCells = Array(total_columnas).fill('<td></td>');

          if (agrupacion.columnsToSum) {
            agrupacion.columnsToSum.forEach((columnIndex, idx) => {
              var dataColumn = rows.data().pluck(columnIndex);

              // Filtra y corrige valores no numéricos
              // var correctedDataColumn = dataColumn.map(value => {
              //   return parseFloat(value ? value : 0);
              // });
              var correctedDataColumn = dataColumn.map(value => {
                return parseCurrency(value ? value : 0);
              });

              var result;

              switch (agrupacion.operacion[idx]) {
                case '+':
                  result = correctedDataColumn.reduce((sum, value) => sum + value, 0);
                  break;
                case '-':
                  // Ordena los datos de mayor a menor
                  correctedDataColumn.sort((a, b) => b - a);
                  result = correctedDataColumn.reduce((sum, value) => sum - value);
                  break;
                // Puedes agregar más operaciones aquí si es necesario
                default:
                  result = 0;  // O manejarlo de la forma que creas conveniente
                  break;
              }

              var printColumn = agrupacion.columnsToPrint[idx];
              // totalCells[printColumn] = `<td>Total: ${result}</td>`;
              var formattedResult = formatCurrency(result);
              totalCells[printColumn] = `<td class="text-white d-flex justify-content-between" style="background-color: #4682B4">
              <span>Total:</span>
              <span class="font-weight-bold">${formattedResult}</span>
          </td>`;

            });

            return $(`<tr>${totalCells.join('')}</tr>`);
          }
        }


      },
      fixedHeader: options.fixedHeader,
      stateSave: options.stateSave,
      stateDuration: options.stateDuration,
      dom: options.dom,
      language: options.language,
      responsive: options.responsive,
      lengthChange: options.lengthChange,
      lengthMenu: options.lengthMenu,
      select: options.select,
      buttons: options.buttons,
      drawCallback: function (settings) {
        initializePopovers(); // Inicializar Popover después de cargar los datos
      },
      pagingType: options.pagingType
    });
  }

  //opciones que se pueden utilizar en el datatable - estas son estandar
  var opciones = {
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    dom: var_dom_col,
    language: espanol,
    responsive: true,
    lengthChange: true,
    lengthMenu: [
      // Define las opciones de cantidad de registros por página en el menú desplegable.
      [5, 10, 15, 20, 25, 50, -1],      // Opciones de cantidad de registros.
      [5, 10, 15, 20, 25, 50, 'Todos'], // Etiquetas que se muestran en el menú desplegable.
    ],
    select: true,
    buttons: btnDescarga,
    initComplete: true,
    pagingType: "simple_numbers"
  };


  agrupar_filas(
    '#datatable',
    [],
    null,
    opciones
  )

  //datatable para la vista de usuarios
  agrupar_filas(
    '#datatable_usuario',
    [],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [-3, -4] },
      { responsivePriority: 3, targets: [1, -5] },
      { responsivePriority: 4, targets: 4 },
      { responsivePriority: 5, targets: 2 },
      { responsivePriority: 6, targets: 3 },
      { responsivePriority: 7, targets: 5 },
      { responsivePriority: 8, targets: [6, 8] },
      { responsivePriority: 9, targets: [7, 9] },
    ],
    opciones
  );

  //datatable para la vista de empresas
  agrupar_filas(
    '#datatable_empresas',
    [],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [2, -3] },
      { responsivePriority: 3, targets: 1 },
      { responsivePriority: 4, targets: 3 },
    ],
    opciones
  );

  //datatable para la vista de areas empresas
  agrupar_filas(
    '#datatable_areas_empresas',
    [ 
      { columnIndex: 1, label: 'Empresa ' },
    ],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [3, -3] },
      { responsivePriority: 3, targets: 2 },
      { responsivePriority: 4, targets: 4 },
    ],
    opciones
  );

  //datatable para la vista de areas empresas
  agrupar_filas(
    '#datatable_persona_area',
    [ 
      { columnIndex: 3, label: 'Empresa ' },
      { columnIndex: 2, label: 'Área ' },
    ],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [1, -3] },
      { responsivePriority: 3, targets: 2 },
      { responsivePriority: 4, targets: 4 },
    ],
    opciones
  );

  //datatable para la vista de roles
  agrupar_filas(
    '#datatable_roles',
    [],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [-3] },
      { responsivePriority: 3, targets: 1 },
      { responsivePriority: 4, targets: 2 },
    ],
    opciones
  );
  //datatable para la vista de menus
  agrupar_filas(
    '#datatable_menus',
    [],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [1, 2] },
      { responsivePriority: 3, targets: [3, -3] },
      { responsivePriority: 4, targets: 4 },
    ],
    opciones
  );
  //datatable para la vista de opciones
  agrupar_filas(
    '#datatable_opciones',
    [
      { columnIndex: 1, label: 'Menú ' } 
    ],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [2, 3] },
      { responsivePriority: 3, targets: [5, -3] },
      { responsivePriority: 4, targets: 6 },
      { responsivePriority: 5, targets: 4 },
      { responsivePriority: 6, targets: 4 },
    ],
    opciones
  );
  //datatable para la vista de sub-opciones
  agrupar_filas(
    '#datatable_sub_opciones',
    [],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: 1 },
      { responsivePriority: 3, targets: [2, -3] },
    ],
    opciones
  );
  //datatable para la vista de atributos
  agrupar_filas(
    '#datatable_atributos',
    [],
    [
      { responsivePriority: 1, targets: 0 },
      { responsivePriority: 2, targets: 1 },
      { responsivePriority: 3, targets: 2 },
      { responsivePriority: 4, targets: 3 },
      { responsivePriority: 1, targets: 4 },
    ],
    opciones
  );

  //datatable para la vista de menu rol
  agrupar_filas(
    '#datatable_menu_rol',
    [
      { columnIndex: 1, label: 'Rol ' },
      { columnIndex: 2, label: 'Menú ' } 
    ],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [3, -3] },
    ],
    opciones
  );
  //datatable para la vista componentes
  agrupar_filas(
    '#datatable_componentes',
    [],
    [
      { responsivePriority: 1, targets: 0 },
      { responsivePriority: 2, targets: 1 },
      { responsivePriority: 3, targets: 2 },
      { responsivePriority: 4, targets: 3 },
      { responsivePriority: 1, targets: 4 },

    ],
    opciones
  );

  //datatable para la vista de menu rol
  agrupar_filas(
    '#datatable_unidad_medidas',
    [
      { columnIndex: 1, label: 'Empresa ' }
    ],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [3, -3] },
      { responsivePriority: 3, targets: [2, 4] },
    ],
    opciones
  );

  agrupar_filas(
    '#datatable_tipos_seleccion',
    [],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [1, -3] },
    ],
    opciones
  );

  agrupar_filas(
    '#datatable_tipos_contenido',
    [],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [1, -3] },
    ],
    opciones
  );

  agrupar_filas(
    '#datatable_tipos_campo',
    [],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [1, -3] },
      { responsivePriority: 3, targets: [2, 3] },
      { responsivePriority: 4, targets: [4, 5] },
    ],
    opciones
  );

  agrupar_filas(
    '#datatable_tipos_formulario',
    [
      { columnIndex: 1, label: 'Empresa ' },
      { columnIndex: 2, label: 'Área ' }
    ],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [3, -3] },
      { responsivePriority: 3, targets: [2] },
    ],
    opciones
  );

  agrupar_filas(
    '#datatable_tipos_frecuencia',
    [
      { columnIndex: 1, label: 'Empresa ' }
    ],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [2, -3] },
    ],
    opciones
  );

  agrupar_filas(
    '#datatable_config_sub_preguntas',
    [
      { columnIndex: 1, label: 'Empresa ' },
      { columnIndex: 2, label: 'Área ' }
    ],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [3, -3] },
      { responsivePriority: 3, targets: [2] },
    ],
    opciones
  );

  agrupar_filas(
    '#datatable_config_preguntas',
    [
      { columnIndex: 1, label: 'Empresa ' },
      { columnIndex: 2, label: 'Área ' }
    ],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [4, -3] },
      { responsivePriority: 3, targets: [2, 3] },
      { responsivePriority: 4, targets: [5] },
      { responsivePriority: 5, targets: [6, 7] },
    ],
    opciones
  );

  agrupar_filas(
    '#datatable_config_formularios',
    [
      { columnIndex: 1, label: 'Empresa ' },
      { columnIndex: 2, label: 'Área ' }
    ],
    [
      { responsivePriority: 1, targets: [0, -1, -2] },
      { responsivePriority: 2, targets: [4, -3] },
      { responsivePriority: 3, targets: [2, 3] },
      { responsivePriority: 4, targets: [5] },
      { responsivePriority: 5, targets: [6, 7] },
    ],
    opciones
  );

});