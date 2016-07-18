$ ->
  errorDiv = undefined
  successDiv = undefined
  errorDiv = '<div class=\'alert alert-danger alert-devise\'><button class=\'close\' data-dismiss=\'alert\'>×</button>Comment cannot be blank</div>'
  successDiv = '<div class=\'alert alert-success alert-devise\'><button class=\'close\' data-dismiss=\'alert\'>×</button>Your comment has been posted</div>'
  $('form').submit (event) ->
    posting = undefined
    values = undefined
    event.preventDefault()
    values = $(this).serialize()
    posting = $.post('/comments', values)
    posting.done (data) ->
      comment = undefined
      commentText = undefined
      timeCreated = undefined
      if data['errors'] != undefined
        $('#alert_explanation').append errorDiv
      else
        comment = data['comment']
        timeCreated = moment(comment.created_at).format('LLL')
        commentText = '<div class=\'well well-white\'>Posted by <strong>'
        commentText += comment.user.username + '</strong> at '
        commentText += '<strong>' + timeCreated + '</strong>'
        commentText += ' <br>' + comment.content + '</div>'
        $('#user-comment').append commentText
        $('form textarea').val ''
        $('#alert_explanation').append successDiv
      return
    return
  return

# ---
# generated by js2coffee 2.2.0
