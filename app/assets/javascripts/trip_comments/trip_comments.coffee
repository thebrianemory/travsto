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
        window.setTimeout (->
          $('.alert').remove()
          return
        ), 3000
      else
        comment = data['comment']
        timeCreated = moment(comment.created_at).format('LLL')
        commentText = '<div class=\'well well-white\' id=\'comment-' + comment.id + '\'>Posted by <strong>'
        commentText += comment.user.username + '</strong> at '
        commentText += '<strong>' + timeCreated + '</strong>'
        commentText += ' <br>' + comment.content
        commentText += '<br /><br /><button class="btn btn-xs btn-info jsNew" data-id="' + comment.id + '">Edit comment</button>'
        commentText += '</div>'
        $('#user-comment').append commentText
        $('.jsNew').on 'click', ->
          commentIdEdit = parseInt($(this).attr('data-id'))
          $('#comment-' + commentIdEdit).load '/comments/' + commentIdEdit + '/edit'
          return
        $('form textarea').val ''
        $('#alert_explanation').append successDiv
        window.setTimeout (->
          $('.alert').remove()
          return
        ), 3000
      return
    return
  return


$ ->
  $('.js-edit').on 'click', ->
    commentIdEdit = parseInt($(this).attr('data-id'))
    $('#comment-' + commentIdEdit).load '/comments/' + commentIdEdit + '/edit'
    return
  return

# ---
# generated by js2coffee 2.2.0
