# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
admin_ready = ->

  $("#new_teacher").validate
    rules: {
      'user[email]': {
        required: true
        maxlength: 50
        custom_email: true
      },
      'user[name]': {
        required: true
        maxlength: 50
      },
      'user[number]': {
        required: true
      }
    },
    messages: {
      'user[email]': {
        required: 'Please enter email',
        maxlength: 'Please enter not more than 50 characters'
        custom_email: 'Please enter valid Email ID'
      },
      'user[name]': {
        required: 'Please enter Email ID'
        maxlength: 'Please enter not more than 50 characters'
      },
      'user[number]': {
        required: 'Please enter number'
      }
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

  $.validator.addMethod 'custom_email', ((value, element) ->
    if value.trim() != ""
      return /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(value)
    else
      return true
  ), ' '


  $("#new_course").validate
    rules: {
      'course[name]': {
        required: true
        maxlength: 50
      },
      'course[course_type_id]': {
        required: true
      },
    },
    messages: {
      'course[name]': {
        required: 'Please enter name'
        maxlength: 'Please enter not more than 50 characters'
      },
      'course[course_type_id]': {
        required: 'Please select course type'
      }
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


  $("#new_subject").validate
    rules: {
      'subject[name]': {
        required: true
        maxlength: 50
      }
    },
    messages: {
      'course[name]': {
        required: 'Please enter name'
        maxlength: 'Please enter not more than 50 characters'
      }
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

  $(document).on "keypress", ".reject_spaces",(e) ->
    if e.which == 32
      return false
    return

$(document).ready(admin_ready)
