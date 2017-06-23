var ready = function() {

    $('body').on('click', '.edit-question-link', function(e) {
        e.preventDefault();
        // $(this).hide();
        var question_id = $(this).data('questionId');
        console.log(question_id);
        $('form#edit-question-' + question_id).show();
    });

};

$(document).on('turbolinks:load', ready);
$(document).on('page:update', ready);