// This would be available globally
//function filter_rows_global(row_type) { console.log("here"); }
// Run this function only once document is entirely loaded
$(function() {
  // All of this text is inserted _unprocessed_ into a script tag

  var filter_rows = function(row_type) {
    $('tbody tr').hide();
    if (row_type === "All") {
      $('tr').show();
    } else if  (row_type === "Won") {
      $('tr.won').show();
    } else if (row_type === "Lost") {
      $('tr.lost').show();
    } else {
      $('tr.playing').show();
    }
  };


  // a button inside a node with class type-filter
  // button.btn-group would select a button with class btn-group
  $('.type-filter button').click(function(e) {
    //console.log("e is:", e);

    //alert("Clicked");
    // this is the node that was clicked on
    // show us what we clicked on
    // console.log(this);
    // console.log("button text is: ", this);
    // console.log("button text is " + this);
    // grab contents of node
    // console.log(this.innerHTML);   // raw javascript
    // console.log( $(this).text() ); // jQuery
    filter_rows( $(this).text() );
  });

  var fliporder = function(order) {
    if (order === "descending") {
      return "ascending";
    } else {
      return "descending";
    }
  };

  var sortbycol = function(sortcol, order) {
    console.log("In sortbycol function");
    var rows = $('.hangman-table tbody tr').get();

    rows.sort(function(a, b) {
      var A = $(a).children('td').eq(sortcol).text().toUpperCase();
      var B = $(b).children('td').eq(sortcol).text().toUpperCase();

      if (A < B) {
        return -1;
      }

      if (A > B) {
        return 1;
      }

      return 0;

    });

    if (order === "descending") {
      rows.reverse();
    }

    $.each(rows, function(index, row) {
      $('.hangman-table').children('tbody').append(row);
    });

  };

  // Let's sort by column
  var stateorder = "descending";
  $('.filter').click( function() {
    col = $(this).data("col");
    stateorder = fliporder(stateorder);
    sortbycol(col, stateorder);
  });

// Pusher stuff
  var channel = pusher.subscribe('challenges');
  channel.bind('newchallenge', function(data){
    alert('New challenge issued by: ' + data.challenger);
  });

//  Show modal and make ajax call
  $('.solve-button').click(function() {

    $.getJSON(("/hangmen/answer/" + gon.hangman_id), function(json) {
      $('.answertext').html(json);
    });

    $('#solveModal').modal('show');

  });

//  Hint modal and make ajax call
  $('.hint-button').click(function() {
    $.getJSON(("/hangmen/" + gon.hangman_id + "/hint"), function(json) {
      $('.hinttext').html(json);
    });
    $('#hintModal').modal('toggle');
  });
});