document.addEventListener("turbolinks:load", () => {
  // BUSCADOR TRANSACCIONES, EN EL MODULO TIPO TRANSACCION
  $('#signo_transaccion').on('select2:select', function (e) {
    $.ajax({
      url: $('.tipo_de_transacciones').data('endpoint'),
      type: 'GET',
      dataType: "json",
      data: {
        busqueda_signo_params: e.params.data.id
      },
      success: function (data) {
        $("#transa_id_transaccion").empty();
        $("#afecta_costo_transaccion").val('');
        var json = data;
        $("#transa_id_transaccion").append("<option value='" + 0 + "'>Seleccione una transacción</option>");
        for (var i of json) {
          $("#transa_id_transaccion").append("<option value='" + i.opcion_id + "'>" + i.descripcion + "</option>");
        }
      }
    });
  });

  // ASIGNACION DE AFECTA COSTO PROPUESTA  POR TRANSACCION
  $('#transa_id_transaccion').on('select2:select', function (e) {
    $.ajax({
      url: $('.afecta_costo_propuesto').data('endpoint'),
      type:'GET',
      dataType: "json",
      data: {
          afecta_costo_propuesto_params: e.params.data.id
      },
      success:function(data) {
        $("#afecta_costo_transaccion").val('');
        var json = data;
        $("#afecta_costo_transaccion").val(data.descripcion).trigger('change');
      }
    });
  });

  // BUSCADOR SUCURSALES POR BODEGA, EN EL MODULO PRODUCTO NETO
  $('#cod_periodo_prod_neto').on('select2:select', function (e) {
    $.ajax({
      url: $('.suc_x_bod_ids_prod_neto').data('endpoint'),
      type: 'GET',
      dataType: "json",
      data: {
        busqueda_suc_bod_ids_prod_neto_params: e.params.data.id
      },
      success: function (data) {
        $("#cod_suc_bod_prod_neto").empty();
        $("#cod_producto_prod_neto").empty();
        var json = data;
        $("#cod_suc_bod_prod_neto").append("<option value='" + 0 + "'>Seleccione una sucursal</option>");
        for (var i of json.sucursales_x_bodega_prod_neto) {
          $("#cod_suc_bod_prod_neto").append("<option value='" + i.opcion_id + "'>" + i.descripcion + "</option>");
        }
        $("#cod_producto_prod_neto").append("<option value='" + 0 + "'>Seleccione un producto</option>");
        for (var p of json.productos_prod_neto) {
          $("#cod_producto_prod_neto").append("<option value='" + p.opcion_id + "'>" + p.descripcion + "</option>");
        }
      }
    });
  });

  // BUSCADOR PRODUCTOS POR SUCURSALES, EN EL MODULO PRODUCTO NETO
  $('#cod_suc_bod_prod_neto').on('select2:select', function (e) {
    $.ajax({
      url: $('.producto_ids_prod_neto').data('endpoint'),
      type: 'GET',
      dataType: "json",
      data: {
        busqueda_producto_prod_neto_params: e.params.data.id
      },
      success: function (data) {
        $("#cod_producto_prod_neto").empty();
        var json = data;
        $("#cod_producto_prod_neto").append("<option value='" + 0 + "'>Seleccione un producto</option>");
        for (var p of json.producto_netos) {
          $("#cod_producto_prod_neto").append("<option value='" + p.opcion_id + "'>" + p.descripcion + "</option>");
        }
      }
    });
  });

});