this.IndexCtrl = function($scope, $location, $http) {

  $("#myform").on('submit', function(event) {
    event.preventDefault();

    var search_company = $('#myinput').val();

    var responsePromise = $http.get('/search', {params: {company: search_company}});

    responsePromise.success(function(data) {
      console.log(data);
      $scope.company_info = data;
    });

    responsePromise.error(function() {
      alert("AJAX failed!");
    });

  });

  return $scope.viewBrowse = function() {
    return $location.url('/browse');
  };

};

