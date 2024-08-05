import Swal from 'sweetalert2';
/** FORM DE NECESIDAD DE MERCADERIA FUNCIONAL */

/** FORM DE DETALLE NECESIDAD DE MERCADERIA INSERT FUNCIONAL*/

/**
 * Rastrea y almacena los valores seleccionados de elementos que coinciden con el selector proporcionado.
 * 
 * @param {string} selector - El selector CSS para identificar los elementos de los que se rastrearán los valores.
 * @param {Array<number>} selectedArray - El array donde se almacenarán los valores seleccionados.
 * 
 * @example
 * let mySelectedItems = [];
 * trackSelectedValues('.my-item-selector', mySelectedItems);
 */

export function trackSelectedValues(selector, selectedArray) {
    $(document).on('change', selector, function () {
        let itemId = Number($(this).val()); // Convertir a número

        if (itemId && !selectedArray.includes(itemId)) {
            selectedArray.push(itemId);
        }
    });
}

/**
 * Inicializa un elemento con la funcionalidad Select2 con AJAX.
 * 
 * @param {jQuery} $element - El elemento jQuery al que se aplicará Select2.
 * @param {Object} ajaxOptions - Opciones específicas para la funcionalidad AJAX de Select2.
 * @param {Object} [select2Options={}] - Opciones adicionales de configuración para Select2. 
 *                                      Si no se proporcionan, se utilizarán valores predeterminados.
 * 
 * @param {string} ajaxOptions.url - La URL a la que se enviará la solicitud AJAX.
 * @param {function} [ajaxOptions.data] - Función que devuelve los datos que se enviarán en la solicitud.
 * 
 * @example
 * initializeSelect2WithAjax($('#mySelect'), {
 *     url: "/api/items",
 *     data: function(params) {
 *         return {
 *             search: params.term
 *         };
 *     }
 * }, {
 *     theme: "classic"
 * });
 */
export function initializeSelect2WithAjax($element, ajaxOptions, select2Options = {}) {
    let defaultAjaxOptions = {
        dataType: 'json',
        delay: 250,
        cache: true,
        processResults: function (data) {
            return {
                results: data
            };
        }
    };

    let defaultSelect2Options = {
        minimumInputLength: 2,
        theme: "bootstrap4",
        language: "es-GT",
        width: '100%'
    };

    // Combinando las opciones proporcionadas con las opciones predeterminadas
    let finalAjaxOptions = Object.assign({}, defaultAjaxOptions, ajaxOptions);
    let finalSelect2Options = Object.assign({}, defaultSelect2Options, select2Options);

    // Integrar ajaxOptions dentro de finalSelect2Options
    finalSelect2Options.ajax = finalAjaxOptions;

    // $element.select2(finalSelect2Options);
    $element.select2(finalSelect2Options).on("select2:open", function (e) {
        // Detener la propagación del evento para evitar efectos secundarios
        e.stopPropagation();
    });
}

/**
     * addDetalleWithPrompt - Añade un "detalle" basado en una respuesta de un cuadro de diálogo al hacer clic en un botón.
     *
     * @param {Object} options - Configuraciones y datos para la función.
     * @param {string} options.buttonSelector - Selector CSS del botón que dispara el cuadro de diálogo.
     * @param {Object} options.alertConfig - Configuraciones para el cuadro de diálogo.
     * @param {string} options.templateExistente - Selector CSS del template usado cuando el usuario confirma.
     * @param {string} options.templateNuevo - Selector CSS del template usado cuando el usuario niega.
     * @param {number} options.detalleIndex - Índice para reemplazar la marca {{index}} en el template.
     * @param {Function} [options.afterAppend] - Función opcional que se ejecuta después de insertar el template.
     * @param {Object} [options.extraParams] - Parámetros extras para la función `afterAppend`.
     *
     * Cuando el botón es presionado, muestra un cuadro de diálogo. Dependiendo de la elección del usuario, se selecciona un template.
     * Luego, se inserta este template con el índice reemplazado y, si se proporciona, se ejecuta una función post-inserción.
     * uso:
     * addDetalleWithPrompt({
     *    buttonSelector: '.add-detalle-button',
     *   alertConfig: {
     *      icon: 'question',
     *     title: '¿Agregar detalle?',
     *    text: '¿Desea agregar un detalle?',
     *   showDenyButton: true,
     *  showCancelButton: true,
     * confirmButtonText: `Si`,
     * denyButtonText: `No`,
     * confirmButtonColor: '#3085d6',
     * },
     * templateExistente: '#detalle-existente-template',
     * templateNuevo: '#detalle-nuevo-template',
     * detalleIndex: 0,
     * afterAppend: function (jQueryObj, extraParams) {
     *   jQueryObj.find('.detalle-producto-select').select2();
     * },
     * extraParams: {}
     * });
     */
export function addDetalleWithPrompt(options) {
    $(options.buttonSelector).on('click', function () {
        Swal.fire({
            icon: options.alertConfig.icon,
            title: options.alertConfig.title,
            text: options.alertConfig.text,
            showDenyButton: options.alertConfig.showDenyButton,
            showCancelButton: options.alertConfig.showCancelButton,
            confirmButtonText: options.alertConfig.confirmButtonText,
            denyButtonText: options.alertConfig.denyButtonText,
            confirmButtonColor: options.alertConfig.confirmButtonColor,
            cancelButtonText: options.alertConfig.cancelButtonText || 'Cancelar',
            cancelButtonColor: options.alertConfig.cancelButtonColor || '#6e7881',
        }).then((result) => {
            let templateId = result.isConfirmed ? options.templateExistente : options.templateNuevo;
            if (!result.isConfirmed && !result.isDenied) return;

            let detalleTemplate = $(templateId).html();
            detalleTemplate = detalleTemplate.replace(/{{index}}/g, options.detalleIndex);

            let jQueryObj = $(detalleTemplate);
            if (options.afterAppend) {
                options.afterAppend(jQueryObj, options.extraParams);
            }

            options.detalleIndex++;
        });
    });
}
/**
     * Establece la funcionalidad de eliminación para elementos de la interfaz.
     * Al hacer clic en el botón especificado por `removeButtonSelector`, esta función busca
     * un valor numérico asociado con un elemento seleccionado en la misma fila. Si ese valor numérico
     * se encuentra en el array proporcionado (`arrayToUpdate`), lo elimina del array.
     * Finalmente, se elimina la fila visualmente de la interfaz.
     * 
     * @param {string} removeButtonSelector - Selector CSS que apunta al botón que, cuando se presione, 
     *                                        desencadenará la eliminación del elemento.
     * 
     * @param {string} valueElementSelector - Selector CSS que apunta al elemento (por ejemplo, un <select>) 
     *                                        de donde se obtendrá el valor a verificar y eliminar 
     *                                        del array proporcionado.
     * 
     * @param {Array<number>} arrayToUpdate - Array de números donde se buscará el valor obtenido del 
     *                                         elemento especificado por `valueElementSelector`.
     *                                         Si se encuentra el valor, se eliminará de este array.
     * uso:
     * setupRemovalFunctionality('.remove-button', '.detalle-producto-select', productosSeleccionados);
    */
export function setupRemovalFunctionality(removeButtonSelector, valueElementSelector, arrayToUpdate) {

    $(document).on('click', removeButtonSelector, function () {
        // Busca el select más cercano dentro del contenedor .detalle-row
        let selectedElement = $(this).closest('.detalle-row').find(valueElementSelector);

        // console.log("Selected element:", selectedElement);
        // console.log("Value of the selected element:", selectedElement.val());

        let itemId = Number(selectedElement.val()); // Convertir a número

        let index = arrayToUpdate.indexOf(itemId);
        if (index !== -1) {
            arrayToUpdate.splice(index, 1);
        }

        $(this).closest('.detalle-row').remove();
        // console.log(arrayToUpdate);
    });
}

/** FORM DE DETALLE NECESIDAD DE MERCADERIA UPDATE FUNCIONAL*/
/**
  * Inicializa popovers de Bootstrap y detecta cambios en los valores de los inputs para actualizar los popovers con información sobre los valores originales.
  * @param {string} inputSelector Selector de jQuery para los inputs que deben ser monitoreados.
  * @param {*} popoverAttribute Selector de jQuery para inicializar los popovers.
  * Uso:
  * setupChangeDetectionWithPopover('.nombre-producto-input', '[data-toggle="popover"]');
  */

export function setupChangeDetectionWithPopover(inputSelector, popoverAttribute) {
    if ($(inputSelector).length === 0) {
        return;
    }
    // Inicializa el popover para elementos que coincidan con el selector
    $(popoverAttribute).popover();

    // Detecta cambios en los inputs y ajusta los atributos/class según sea necesario
    $(inputSelector).on('change', function () {
        var originalValue = $(this).data('original-value');
        var currentValue = $(this).val();
        if (originalValue != currentValue) {
            $(this).addClass('modified');
            $(this).attr('data-content', 'Valor anterior: ' + originalValue);
        } else {
            $(this).removeClass('modified');
        }
    });
}

/**
* Resalta visualmente los inputs que han sido modificados.
* 
    * @param {string} selector - Selector de jQuery para los inputs que deben ser monitoreados.

    * 
    * @param {string} highlightStyle - Estilo CSS para aplicar cuando el input ha cambiado.
    * 
    * Uso:
    * setupInputChangeHighlight('.nombre-producto-input', '2px solid #5bc0de');
    * Nota:
    * El valor original debe estar almacenado en un atributo data 'original_value' en el input.
    * ejemplo: 
    * data: { 
                toggle: 'popover', 
                placement: 'top', 
                original_value: originalValue
            }
*/
export function setupInputChangeHighlight(selector, highlightStyle) {
    if ($(selector).length === 0) {
        return;
    }
    $(document).on('change', selector, function () {
        var originalValue = $(this).data('original_value');
        if ($(this).val() !== originalValue) {
            $(this).css('border', highlightStyle);
        } else {
            $(this).css('border', '');
        }
    });
}

