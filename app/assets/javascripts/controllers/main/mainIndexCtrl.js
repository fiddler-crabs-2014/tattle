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
      alert("No, not that one. Try a different one.");
    });

  });

  // $("#parent_companies form").on('submit', function(event) {
  //   event.preventDefault();
  //   console.log("hello")

  //   // var parent_company = $( this ).data('company');
  //   // console.log(parent_company)

  //   // var responsePromise = $http.get('/children', {params: {company: parent_company}});

  //   // responsePromise.success(function(data) {
  //   //   console.log(data);
  //   //   // $scope.company_info = data;
  //   // });

  //   // responsePromise.error(function() {
  //   //   alert("No, not that one. Try a different one.");
  //   // });

  // });

  return $scope.viewChildren = function(company) {
    console.log("hello");

    var parent_company = company;
    console.log(parent_company);

    var responsePromise = $http.get('/children', {params: {company: parent_company}});

    responsePromise.success(function(data) {
      console.log(data);
      // $scope.company_info = data;
    });

    responsePromise.error(function() {
      alert("No, not that one. Try a different one.");
    });
  };

  return $scope.viewBrowse = function() {
    return $location.url('/browse');
  };

};

