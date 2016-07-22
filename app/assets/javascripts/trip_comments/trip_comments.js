$(function() {
  var errorDiv, successDiv;
  errorDiv = '<div class=\'alert alert-danger alert-devise\'><button class=\'close\' data-dismiss=\'alert\'>×</button>Comment cannot be blank</div>';
  successDiv = '<div class=\'alert alert-success alert-devise\'><button class=\'close\' data-dismiss=\'alert\'>×</button>Your comment has been posted</div>';
  $('form').submit(function(event) {
    var posting, values;
    event.preventDefault();
    values = $(this).serialize();
    posting = $.post('/comments', values);
    posting.done(function(data) {
      var comment, commentText, timeCreated;
      if (data['errors'] !== void 0) {
        $('#alert_explanation').append(errorDiv);
        window.setTimeout((function() {
          $('.alert').remove();
        }), 3000);
      } else {
        comment = data['comment'];
        timeCreated = moment(comment.created_at).format('LLL');
        commentText = '<div class=\'well well-white\' id=\'comment-' + comment.id + '\'>Posted by <strong>';
        commentText += comment.user.username + '</strong> at ';
        commentText += '<strong>' + timeCreated + '</strong>';
        commentText += ' <br>' + comment.content;
        commentText += '<br /><br /><button class="btn btn-xs btn-info jsNew" data-id="' + comment.id + '">Edit comment</button>';
        commentText += '</div>';
        $('#user-comment').append(commentText);
        $('.jsNew').on('click', function() {
          var commentIdEdit;
          commentIdEdit = parseInt($(this).attr('data-id'));
          $('#comment-' + commentIdEdit).load('/comments/' + commentIdEdit + '/edit');
        });
        $('form textarea').val('');
        $('#alert_explanation').append(successDiv);
        window.setTimeout((function() {
          $('.alert').remove();
        }), 3000);
      }
    });
  });
});

$(function() {
  $('.js-edit').on('click', function() {
    var commentIdEdit;
    commentIdEdit = parseInt($(this).attr('data-id'));
    $('#comment-' + commentIdEdit).load('/comments/' + commentIdEdit + '/edit');
  });
});
