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

  t = setInterval(->
    for task_time in $('.task-time')
      do (task_time) ->
        if $(task_time).data('harvesting') is 1
          time_spent = parseInt $(task_time).attr('data-time_spent')
          time_spent = time_spent + 1
          $(task_time).attr('data-time_spent', time_spent)

          hours   = Math.floor(time_spent / 3600)
          hours = "0#{hours}" if hours < 10

          minutes = Math.floor((time_spent - (hours * 3600)) / 60)
          minutes = "0#{minutes}" if minutes < 10

          seconds = Math.round(time_spent - (hours * 3600) - (minutes * 60))
          seconds = "0#{seconds}" if seconds < 10

          $(task_time).html "#{hours}:#{minutes}:#{seconds}"
  , 1000)

