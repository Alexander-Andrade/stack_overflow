var ready = function() {

    $('body').on('click', '.edit-answer-link', function(e) {
        e.preventDefault();
        // $(this).hide();
        var answer_id = $(this).data('answerId');
        console.log(answer_id);
        $('form#edit-answer-' + answer_id).show();
    });

};

// $(document).ready(ready);
$(document).on('turbolinks:load', ready);
$(document).on('page:update', ready);