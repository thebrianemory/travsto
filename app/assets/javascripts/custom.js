$(document).ready(function() {
  $("#js-add-question-row").click(function() {
    addQuestion();
  });
});

function addQuestion() {
  var question = $("textarea:last").clone();
  question = updateQuestion(question);
  question.insertAfter("textarea:last");
}

// This part substitutes out the index number and then increments the last by one
function updateQuestion(question) {
  var old_name = question.attr("name");
  var result = /\[[\d]+\]/.exec(old_name).toString();
  var old_index = result.slice(1, -1);
  var new_index = (parseInt(old_index, 10) + 1).toString();
  var new_name = old_name.replace(old_index, new_index);
  question.attr("name", new_name);
  return question
}
