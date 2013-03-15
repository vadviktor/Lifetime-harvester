$ ->
# submit form
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

# clock
  setInterval(->
    for task_time in $('.task-time.harvesting')
      do (task_time) ->
        time_started = new Date(parseInt($(task_time).attr('data-started')))
        time_now = new Date()
        time_to_display = new Date()
        time_to_display.setTime(time_now - time_started)

        hours = time_to_display.getUTCHours()
        hours = "0#{hours}" if hours < 10
        minutes = time_to_display.getUTCMinutes()
        minutes = "0#{minutes}" if minutes < 10
        seconds = time_to_display.getUTCSeconds()
        seconds = "0#{seconds}" if seconds < 10

        ret = "#{hours}:#{minutes}:#{seconds}"
        $(task_time).html(ret)
  , 1000)
