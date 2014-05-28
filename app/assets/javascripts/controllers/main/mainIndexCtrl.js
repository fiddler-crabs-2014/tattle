this.IndexCtrl = function($scope, $location, $http) {

  $("#myform").on('submit', function(event) {
    event.preventDefault();

    var search_company = $('#myinput').val();

    var responsePromise = $http.get('/search', {params: {company: search_company}});

    $('#logo').addClass('pulse');

    responsePromise.success(function(data) {
      console.log(data);
      $scope.company_info = data;
      $("#landing").addClass('landing-post-search');
      $("#landing-content").addClass('landing-content-post-search');
      $("#tagline").addClass('tagline-post-search');
      $('#logo').removeClass('pulse');
    });

    responsePromise.error(function() {
      alert("No, not that one. Try a different one.");
    });

  });


  $scope.searchSubsidiary = function(child) {

    var responsePromise = $http.get('/search', {params: {company: child}});

    responsePromise.success(function(data) {
      $scope.company_info = data;
    });

    responsePromise.error(function() {
      alert("No, not that one. Try a different one.");
    });

  };

  $scope.viewChildren = function(company, index) {

    var parent_company = company;

    var responsePromise = $http.get('/children', {params: {company: parent_company}});

    responsePromise.success(function(data) {
      $scope.company_info.parents[index].children_info = data;
    });

    responsePromise.error(function() {
      alert("No, not that one. Try a different one.");
    });
  };


};

