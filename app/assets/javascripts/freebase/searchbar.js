$(document).ready(function () {
  console.log("hello");
  $("#myinput").suggest({
    key: 'AIzaSyDTRAuq33BZlQnAepytW-ehI5v-tsUDccI',
    filter:'(all type:/business/business_operation)'
    // filter:'(all type:/business/brand)'
  });

})
