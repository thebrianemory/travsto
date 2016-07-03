$ ->
  $("#addNewChoice").on "click", ->
    $("#biz_choices").append($("#new_choice_form").html())

@removeChoice = (element) ->
  element.parent().remove()
