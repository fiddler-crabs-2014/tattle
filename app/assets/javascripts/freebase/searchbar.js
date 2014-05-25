$(document).ready(function () {
  console.log("hello");
        $("#myinput").suggest({
          key: 'AIzaSyDTRAuq33BZlQnAepytW-ehI5v-tsUDccI',
          filter:'(all type:/business/business_operation)'
          // filter:'(all type:/business/brand)'
        });

      $("#myform").on('submit', function(event) {
        event.preventDefault();
        var company = $('#myinput').val();
        $.ajax({
          url: '/search',
          type: "get",
          data: {company_name: company},
          dataType: 'json'
        }).success(function(data) {
          console.log(data);
          // redirect to
        }).fail(function(){
          console.log("you suck at programming")
        })
      });
})
