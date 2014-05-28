this.IndexCtrl = function($scope, $location, $http) {

  $("#myform").on('submit', function(event) {
    event.preventDefault();

    var search_company = $('#myinput').val();

    var responsePromise = $http.get('/search', {params: {company: search_company}});
      // console.log($(this));
    responsePromise.success(function(data) {
      // console.log("inside success!")
      // console.log($(this));
      console.log(data);
      $scope.company_info = data;
    });

    responsePromise.error(function() {
      alert("No, not that one. Try a different one.");
    });

  });

  return $scope.viewBrowse = function() {
    return $location.url('/browse');
  };

};

