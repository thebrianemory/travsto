$(function() {
  return $("#addNewChoice").on("click", function() {
    return $("#biz_choices").append($("#new_choice_form").html());
  });
});

this.removeChoice = function(element) {
  return element.parent().remove();
};
