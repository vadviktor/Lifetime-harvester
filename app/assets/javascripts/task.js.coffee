$ ->
  $("#start_harvest_form input[name='description']").keydown ->
    $('#description-control-group').removeClass('error')

  $("#start_harvest_form input[name='time']").keydown ->
    $('#time-control-group').removeClass('error')

  $("#start_harvest_form").submit (event) ->

    form = $(this)

    errors = false
    description = R(form.find("input[name='description']").val())
    if description.empty()
      $('#description-control-group').addClass('error')
      errors = true

    time = R(form.find("input[name='time']").val())
    if time.empty()
      $('#time-control-group').addClass('error')
      errors = true

    if errors
      event.preventDefault()
      return false
