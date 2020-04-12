# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
teacher_ready = ->

  disabledDates = []

  $('#teacher_course_id').parent().parent().hide()
  $('#teacher_subject_id').parent().parent().hide()
  $('#teacher_start_datetime').parent().parent().hide()

  course_collection = $('#teacher_course_id').html()
  subject_collection = $('#teacher_subject_id').html()

  $('#teacher_course_type_id').change ->
    current_course_type = $('#teacher_course_type_id option:selected').text()
    course_type_options = $(course_collection).filter("optgroup[label='#{current_course_type}']").html()
    if course_type_options
      $('#teacher_course_id').html(course_type_options)
      $('#teacher_course_id').parent().parent().show()
      $('#teacher_subject_id').empty()
    else
      $('#teacher_course_id').empty()
      $('#teacher_subject_id').empty()
      $('#teacher_course_id').parent().parent().hide()
      $('#teacher_subject_id').parent().parent().hide()

  $('#teacher_course_id').change ->
    current_course = $('#teacher_course_id option:selected').text()
    course_options = $(subject_collection).filter("optgroup[label='#{current_course}']").html()
    if course_options
      $('#teacher_subject_id').html(course_options)
      $('#teacher_subject_id').parent().parent().show()
    else
      $('#teacher_subject_id').empty()
      $('#teacher_subject_id').parent().parent().hide()

  $('#teacher_subject_id').click ->
    setTimePicker()
    $('#teacher_start_datetime').parent().parent().show()


  setTimePicker = ->
    date = $('#teacher_today_classes').val()
    time_now = $('#teacher_time_now').val()
    if date
      formatted_date = JSON.parse(date)
    disabledDates = createTimeSlotArray(formatted_date,time_now)
    $('#teacher_start_datetime').timepicker('remove')

    $('#teacher_start_datetime').timepicker
      'scrollDefault': 'now',
      'orientation': 'rb',
      'disableTextInput': true,
      'timeFormat': 'h:i A',
      'disableTimeRanges': disabledDates,
      'maxTime': '11:30pm',
      'step': 60
    $('#teacher_start_datetime').val('')
    return

  createTimeSlotArray = (formatted_date, time_now) ->
    skip_previous_time=["00:00 AM", time_now]
    formatted_date.push(skip_previous_time)
    return formatted_date

  $("#new_class").validate
    ignore: []
    rules: {
      'teacher[course_type_id]': {
        required: true
      },
      'teacher[course_id]': {
        required: true
      },
      'teacher[subject_id]': {
        required: true
      },
      'teacher[start_datetime]': {
        required: true
      },
    },
    messages: {
      'teacher[course_type_id]': {
        required: 'Please Select Course Tyoe'
      },
      'teacher[course_id]': {
        required: 'Please Select Course'
      },
      'teacher[subject_id]': {
        required: 'Please Select Subject'
      },
      'teacher[start_datetime]': {
        required: 'Please Select Time'
      },
    }
    errorPlacement: (error, element) ->
      error.insertAfter $(element).closest('.form-control')
      return
    highlight: (element) ->
      $(element).closest('.form-control').removeClass('has-success').addClass 'has-error'
    unhighlight: (element) ->
      $(element).closest('.form-control').removeClass('has-error').addClass 'has-success'
    errorElement: 'span'
    errorClass: 'help-block'
    submitHandler: (form) ->
      $('#spinner-modal').modal('show')
      form.submit()


$(document).ready(teacher_ready)
