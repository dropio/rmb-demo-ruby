$(document).ready(function() {

  $("a.delete").click(function() {
    if (confirm("Are you absolutely sure?")) {
      // Delete item
    } else {
      return false;
    }
  });

});

