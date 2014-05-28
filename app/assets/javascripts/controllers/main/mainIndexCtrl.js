this.IndexCtrl = function($scope, $location, $http) {

  $("#myform").on('submit', function(event) {
    event.preventDefault();

    var search_company = $('#myinput').val();

    var response = $http.get('/search', {params: {company: search_company}});

    $('#logo').addClass('pulse');

    response.success(function(data) {
      console.log(data);
      $scope.company_info = data;
      $("#landing").addClass('landing-post-search');
      $("#landing-content").addClass('landing-content-post-search');
      $("#tagline").addClass('tagline-post-search');
      $('#logo').removeClass('pulse');
    });

    response.error(function() {
      alert("No, not that one. Try a different one.");
    });

  });


  $scope.searchSubsidiary = function(child) {
    var response = $http.get('/search', {params: {company: child}});

    response.success(function(data) {
      $scope.company_info = data;
    });

    response.error(function() {
      alert("No, not that one. Try a different one.");
    });

  };

  $scope.viewChildren = function(company, index) {

    var response = $http.get('/children', {params: {company: company}});

    response.success(function(data) {
      if (index === 'na') {
        $scope.company_info.children_info = data;
        console.log('$scope.company_info.children_info is: ');
        console.log($scope.company_info.children_info);
      } else {
        $scope.company_info.parents[index].children_info = data;
        console.log('$scope.company_info.parents[index].children_info is: ');
        console.log($scope.company_info.parents[index].children_info);
      };
    });

    response.error(function() {
      if (index === 'na') {
        $scope.company_info.children_info = { children: ['no children'] };
      } else {
        $scope.company_info.parents[index].children_info = { children: ['no children'] };
      };
    });
  };


};

