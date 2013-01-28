$ ->
  if gon.harvest_in_progress?
    $('#favicon').attr('href', '/faviconplay.ico')

  $("#start_harvest_form input[name='description']").keydown ->
    $('#description-control-group').removeClass('error')

  $("#start_harvest_form input[name='time']").keydown ->
    $('#time-control-group').removeClass('error')

  $("#start_harvest_form").submit (event) ->
    form = $(this)

    errors = false
    description = form.find("input[name='description']").val()
    if not description? or description == ''
      $('#description-control-group').addClass('error')
      errors = true

    time = form.find("input[name='time']").val()
    if not time? or time == ''
      $('#time-control-group').addClass('error')
      errors = true

    if errors
      event.preventDefault()
      return false

#  setTimeout(->
#
#  , 1000)
