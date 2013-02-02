$ ->
  if gon.harvest_in_progress?
    $('#favicon').attr('href', '/faviconplay.ico')

  description = $("#task_description")
  time_spent = $("#task_time_spent")

  description.keydown ->
    $('#description-control-group').removeClass('error')

  time_spent.keydown ->
    $('#time_spent-control-group').removeClass('error')

  $("#start_harvest_form").submit (event) ->

    errors = false
    description_val = description.val()
    if not description_val? or description_val == ''
      $('#description-control-group').addClass('error')
      errors = true

    time_spent_val = time_spent.val()
    if not time_spent_val? or time_spent_val == ''
      $('#time_spent-control-group').addClass('error')
      errors = true

    if errors
      event.preventDefault()
      return false

#  setTimeout(->
#
#  , 1000)
