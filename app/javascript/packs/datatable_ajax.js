document.addEventListener("turbolinks:load", function () {

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
    var btnDescarga = [
        {
            text: '<i class="fas fa-file-excel"></i> ',
            extend: 'excelHtml5',
            fieldSeparator: '\t',
            extension: '.xlsx',
            titleAttr: 'Exportar a Excel'
        }
    ];
    var var_dom = "<'row'<'col-12 col-lg-4 custom-center'l><'col-12 col-lg-4 d-flex justify-content-center'B><'col-12 col-lg-4 custom-center'f>>" +
        "<'row'<'col-12'tr>>" +
        "<'row'<'col-12 d-flex justify-content-center'i><'col-12 d-flex justify-content-center'p>>";

    //configuracion para datatables agrupados por columnas dinamico
    /**
    * Función para agrupar filas en un DataTable en base a múltiples columnas.
    * @param {string} var_dom - Selector o elemento DOM donde se mostrará el DataTable. Por ejemplo, '#datatable_familia_producto' o document.getElementById('datatable_familia_producto').
    * @param {Array} agrupaciones - Un array que contiene objetos con detalles de las columnas que se utilizarán para la agrupación. Cada objeto debe tener la forma { columnIndex: number, label: string }, donde columnIndex es el índice de la columna (comenzando desde 0) y label es el nombre o etiqueta de la columna que se utilizará para mostrar el nombre del grupo.
    * @param {Array|null} columnDefs - Un array opcional que contiene configuraciones adicionales para las columnas del DataTable, en el formato requerido por DataTables columnDefs. Puede ser nulo si no se necesita ninguna configuración adicional.
    * @param {Object} options - Opciones adicionales para configurar el DataTable, siguiendo el formato de configuración del DataTable. Puedes personalizar opciones como el orden, dom, lenguaje, botones, etc.
    * @param {Array} columns - La configuración de columnas para el DataTable.
    * @param {Object} ajaxConfig - Configuración Ajax para el DataTable.
    * @param {number|null} total_columnas - El número total de columnas en el DataTable. Puede ser nulo si no se necesita.
    * @param {Array|null} excelExcludeColumns - Un array opcional que contiene los índices de las columnas que se excluirán de la exportación a Excel. Puede ser nulo si no se necesita.
    */
    function agrupar_filas_ajax(var_dom, agrupaciones, columnDefs, options, columns, ajaxConfig, total_columnas = null, excelExcludeColumns = null, excelFileName = null) {
        if ($(var_dom).length === 0) {
            return; // Sal del método si el elemento no está presente
        }

        var allColumnsIndices = columns.map((_, idx) => idx); // Índices de todas las columnas
        var excludeIndicesSet = new Set(excelExcludeColumns); // Conjunto para una búsqueda rápida
        var includeColumns = allColumnsIndices.filter(idx => !excludeIndicesSet.has(idx));

        // Asegúrate de incluir las columnas de agrupación
        agrupaciones.forEach(agrupacion => {
            if (!includeColumns.includes(agrupacion.columnIndex)) {
                includeColumns.push(agrupacion.columnIndex);
            }
        });

        if (excelExcludeColumns) {
            options.buttons = options.buttons.map(button => {
                if (button.extend === 'excelHtml5') {
                    button.exportOptions = {
                        columns: includeColumns
                    };
                    button.title = excelFileName;
                }
                return button;
            });
        }

        // Lógica para manejar DataTables con o sin agrupaciones
        var dataTableOptions = {
            "columnDefs": columnDefs || [],
            fixedHeader: options.fixedHeader,
            stateSave: options.stateSave,
            stateDuration: options.stateDuration,
            dom: options.dom,
            language: options.language,
            responsive: options.responsive,
            lengthMenu: options.lengthMenu,
            select: options.select,
            buttons: options.buttons,
            pagingType: options.pagingType,
            columns: columns,
            ajax: ajaxConfig,
            processing: options.processing,
            serverSide: options.serverSide,
            ajax: {
                url: ajaxConfig.url,
                type: ajaxConfig.type,
                headers: ajaxConfig.headers,
                data: ajaxConfig.data
            },
        };

        // Comprueba si agrupaciones está vacío
        if (!agrupaciones || agrupaciones.length === 0) {
            // Inicializa la tabla sin el rowGroup
            $(var_dom).DataTable(dataTableOptions);
            return;
        }

        var dataSrc = agrupaciones.map(agrupacion => agrupacion.columnIndex);
        var orden = agrupaciones.length > 1 ?
            agrupaciones.map(agrupacion => [agrupacion.indexOrden, agrupacion.order || 'desc']) :
            [];

        dataTableOptions.order = orden;
        dataTableOptions.columnDefs = [...agrupaciones.map(agrupacion => ({ "visible": false, "targets": agrupacion.indexOrden })), ...(columnDefs ?? [])];
        dataTableOptions.rowGroup = {

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
                            button = `<a href="${agrupacion.buttonRoute}${group}" class="btn ${buttonClass}">${agrupacion.buttonText ? agrupacion.buttonText : 'Ver Detalle'}</a>`;
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
                        var correctedDataColumn = dataColumn.map(value => {
                            return parseFloat(value ? value : 0);
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
                        totalCells[printColumn] = `<td>Total: ${result}</td>`;
                    });

                    return $(`<tr>${totalCells.join('')}</tr>`);
                }
            }
        };

        $(var_dom).DataTable(dataTableOptions);
    }

    //opciones que se pueden utilizar en el datatable - estas son estandar
    var opciones = {
        fixedHeader: true,
        stateSave: true,
        stateDuration: 1200,
        dom: var_dom,
        language: espanol,
        responsive: "true",
        lengthMenu:
            [
                [25, 5, 10, 15, 50, -1],
                [25, 5, 10, 15, 50, 'Todos'],
            ],
        select: true,
        buttons: btnDescarga,
        pagingType: "simple_numbers",
        processing: true,
        serverSide: true
    };

    agrupar_filas_ajax(
        '#opcion-ca-datatable',
        [
            { columnIndex: "opcion", label: 'opción', indexOrden: 1 }
        ],
        [
            { responsivePriority: 1, targets: [0] },
            { responsivePriority: 1, targets: [-2, -1] }, // Muestra las últimas dos columnas
            { responsivePriority: 2, targets: [1, 2] }
        ],
        opciones,
        [
            { data: "id", class: "text-center" },
            { data: "opcion" },
            { data: "componente" },
            { data: "atributo", class: "text-center" },
            { data: "descripcion" },
            { data: "estado", class: "text-center" },
            { data: "editar", class: "text-center" },
            { data: "inactivar", class: "text-center" }
        ],
        {
            url: $('#opcion-ca-datatable').data('source'),
        },
        null
    );

});