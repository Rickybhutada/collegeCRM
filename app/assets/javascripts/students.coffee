# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
student_ready = ->
  $('.attend-class').click ->
    $.ajax '/student/attend_class',
      type: 'GET'
      dataType: 'JSON'
      data: {
        subject_id: $(this).attr('subject_id')
        teacher_id: $(this).attr('teacher_id')
      },
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)
      success: (data, textStatus, jqXHR) ->
        $('.ajax-notice').html("<p class='notice'>"+data.message+"</p>")
        $(".ajax-notice .notice").fadeIn(100).slideUp(3000);
        console.log(data.message,textStatus)


$(document).ready(student_ready)
