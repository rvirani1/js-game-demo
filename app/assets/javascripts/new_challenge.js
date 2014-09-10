$(function() {
  var rownumber = $('td.rownumber').text();
  var increaseRowNumber = (function() { rownumber = parseInt(rownumber) + 1; });

  var $row = $('.challenge-table').find('tbody tr');

  var addrow = (function (row) {
    increaseRowNumber();
    var newrow = row.clone();
    newrow.find('td:first').html(rownumber);
    newrow = newrow.data('row', rownumber);
    row.parent().append(newrow);
  });

  $('.addrow').click(function() {
    addrow($row);
  });

//  Prevent spaces in text box
  $(".challenge-word").on("keydown", function(e) {
    return e.which !== 32;
  })

});