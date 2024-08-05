jQuery ->
  $('#area_id').parents().hide()
areas = $('#area_id').html()
$('#empresa').change ->
    empresa = $('#empresa :selected').text()
    options = $(areas).filter("optgroup[label='#{empresa}']").html()
    if options
     $('#area_id').html(options)
     $('#area_id').parents().show()
     else
        $('#area_id').empty()
        $('#area_id').parents().hide()




