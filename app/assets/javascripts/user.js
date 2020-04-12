$(document).ready(function () {
    console.log("hello");

    $('#user_course_type').change(function(){
        text = $('#user_course_type option:selected').text();
        addDropdown(text)
    });

    function addDropdown(text) {
        i = 0;
        var dropDown;
        var courses;
        dropDown = '<div class="item form-group differentCourse"> <label class="control-label col-md-2 col-sm-2 col-xs-12" for="course"> Select Course </label><div class="col-md-8 col-sm-8 col-xs-12 session-speaker"> <select class="form-control col-md-7 col-xs-12" autofocus="autofocus" name="user[course][]" id="course" multiple = "multiple">'
        if (text == "Part Time" || text == "Full Time") {
            $.ajax({
                url: '/admin/course_by_type',
                type: "GET",
                async: false,
                data: {
                    course_type: $('#user_course_type').val()
                },
                success: function (data, textStatus, jqXHR) {
                    console.log(data);
                    courses = data
                },
                error: function (data, textStatus, jqXHR){
                    location.reload()
                }
            });
            $('.multiselect-native-select').children().last().remove();
            len = courses.length;
            while (i < len) {
                dropDown = dropDown.concat('<option value="' + courses[i][0] + '"> ' + courses[i][1] + '</option>');
                i++;
            }
            dropDown = dropDown.concat('</div></div>');
            $('#course_drop_down').html(dropDown);
            $('#course').multiselect({
                nonSelectedText: 'Select Course',
                includeSelectAllOption: true,
                onDropdownHide: function (event) {
                }
            });
        }
        else{
            element = document.getElementsByClassName('differentCourse');
            $(element).remove()
        }
    }

    function checkOptionValid() {
        course_type = $('#user_course_type option:selected').text();
        if (course_type != undefined) {
            selected_value = $('.multiselect-container li.active').text().replace('Select all','').split(' ');
            if (selected_value != "") {
                values = $.grep(selected_value, function( n ) {
                    return ( n !== "" && n!== " " );
                });
                if (course_type == "Part Time") {
                    // set part time course limit to 2
                    partTimeCourseLimit = [1, 2];
                    is_correct_lenth = partTimeCourseLimit.includes(values.length)
                }
                else if (course_type == "Full Time") {
                    is_correct_lenth = (values.length == 1)
                }
                else{
                    is_correct_lenth = false
                }
                console.log("current haviing error", is_correct_lenth, values.length);
                return is_correct_lenth
            }
            else{return false}
        }
        else {return false}
    }


    $("#signup_user").validate({
        rules: {
            'user[email]': {
                required: true,
                maxlength: 50,
                custom_email: true
            },
            'user[name]': {
                required: true,
                maxlength: 50
            },
            'user[number]': {
                required: true
            },
            'user[password]':{
                required: true,
                validPassword: true
            },
            'user[password_confirmation]':{
                required: true,
                validConfirmPassword: true
            },
            'user[course_type]':{
                required: true
            },
            'course[]':{
                validCourse: true
            }
        },
        messages: {
            'user[email]': {
                required: 'Please enter email',
                maxlength: 'Please enter not more than 50 characters',
                custom_email: 'Please enter valid Email ID'
            },
            'user[name]': {
                required: 'Please enter Name',
                maxlength: 'Please enter not more than 50 characters'
            },
            'user[number]': {
                required: 'Please enter number'
            },
            'user[password]':{
                required: 'Please enter Password',
                validPassword: 'Maximium Password length is 8'
            },
            'user[password_confirmation]':{
                required: 'Please enter Password conformation',
                validConfirmPassword: 'Password and confirmation should be same'
            },
            'user[course_type]':{
                required: 'Please enter course type'
            },
            'course[]':{
                validCourse: 'Please select 1 course for Full Time OR 2 course for Part Time'
            }
        },
        errorPlacement: function(error, element) {
            if (element[0].id == "course"){
                error.insertAfter($($('.multiselect-native-select').children().last()))
            }
            else{error.insertAfter($(element).closest('.form-control'));}
        },
        highlight: function(element) {
            return $(element).closest('.form-control').removeClass('has-success').addClass('has-error');
        },
        unhighlight: function(element) {
            return $(element).closest('.form-control').removeClass('has-error').addClass('has-success');
        },
        errorElement: 'span',
        errorClass: 'help-block',
        submitHandler: function(form) {
            $('#spinner-modal').modal('show');
            return form.submit();
        }
    });


    $.validator.addMethod('validPassword', (function(value) {
        if ($('#user_password').val().length >7){
            return true
        }
        return false
    }), '');

    $.validator.addMethod('validConfirmPassword', (function(value) {
        if ($('#user_password').val() == $('#user_password_confirmation').val()){
            return true
        }
        return false
    }), '');

    $.validator.addMethod('validCourse', (function(value) {
        return checkOptionValid()
    }), '');

    $(document).on("keypress", ".reject_spaces", function(e) {
        if (e.which === 32) {
            return false;
        }
    });


});