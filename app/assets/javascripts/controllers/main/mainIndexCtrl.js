this.IndexCtrl = function($scope, $location, $http) {

  $("#myform").on('submit', function(event) {
    event.preventDefault();

    $('#logo').addClass('pulse');
    $scope.open = false;
    $scope.expanded = false;

    var search_company = $('#myinput').val();

    var response = $http.get('/search', {params: {company: search_company}});

    response.success(function(data) {
      $scope.company_info = data;
      $("#landing").addClass('landing-post-search');
      $("#landing-content").addClass('landing-content-post-search');
      $("#tagline").addClass('tagline-post-search');
      $('#logo').removeClass('pulse');
      $('footer').removeClass('hidden');
    });

    response.error(function() {
      $('#logo').removeClass('pulse');
      alert("No, not that one. Try a different one.");
    });

  });

  $scope.searchSubsidiary = function(child) {
    var response = $http.get('/search', {params: {company: child}});

    $scope.open = false;
    $scope.expanded = false;
    $('#myinput').val(child);
    $('#logo').addClass('pulse');
    $('html,body').animate({ scrollTop: 0}, 700);

    response.success(function(data) {
      $scope.company_info = data;
      $('#logo').removeClass('pulse');
    });

    response.error(function() {
      $('#logo').removeClass('pulse');
      alert("No, not that one. Try a different one.");
    });

  };

  $scope.viewChildren = function(company, index) {

    var response = $http.get('/children', {params: {company: company}});

    response.success(function(data) {

      if (index === 'na') {
        $scope.company_info.children_info = data;
      } else {
        $scope.company_info.parents[index].children_info = data;
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

