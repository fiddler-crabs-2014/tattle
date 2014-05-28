//(function(){
  //'use strict';

  describe('IndexCtrl', function () {
    // var scope;

    // beforeEach(function() {
    //   module('CC');
    //   inject(function ($controller, $rootScope) {
    //     scope = $rootScope.$new();
    //     $controller('IndexCtrl', { $scope: scope });
    //   });
    // });
    
    // it('scopes correctly', function () {
    //   expect(scope).toEqual(CC.$scope);
    // });

    var formEl, inputEl;
    var $scope, $location, $rootScope, $timeout,  $httpBackend, createController;
    var $q, deferred;

    beforeEach(function() {
      //formEl = $('body').append("<div id='myForm' />");
      module('CC');

      inject(function($injector) {
        $location = $injector.get('$location');
        $timeout = $injector.get('$timeout');
        $httpBackend = $injector.get('$httpBackend');
        $rootScope = $injector.get('$rootScope');
        $scope = $rootScope.$new();
        $q = $injector.get('$q');

        var $controller = $injector.get('$controller');

        createController = function() {
            return $controller('IndexCtrl', {
                '$scope': $scope
            });
        };
      });
    });

     afterEach(function() {
        $httpBackend.verifyNoOutstandingExpectation();
        $httpBackend.verifyNoOutstandingRequest();
    });


    it('should have a method to check if the path is active', function() {
        var controller = createController();
        $location.path('/search');
        expect($location.path()).toBe('/search');
        // expect($scope.isActive('/about')).toBe(true);
        // expect($scope.isActive('/contact')).toBe(false);
    });

    it('should call search #searchSubsidiary', function() {
      var controller = createController();
      $scope.urlToScrape = '/search';

      deferred = $q.defer();
      deferred.company_info = "stuff goes here";

      $httpBackend.expect('GET', '/search?company=Burt')
          .respond(deferred);

        // have to use $apply to trigger the $digest which will
        // take care of the HTTP request
        $scope.$apply(function() {
            $scope.searchSubsidiary('Burt');
            deferred.resolve({ company_info: "stuff goes here"});
        });

        
        
        //expect($scope.parseOriginalUrlStatus).toEqual('calling');

        $httpBackend.flush();


            expect($scope.company_info).toEqual("stuff goes here");
         

        // expect($scope.retrievedUrls).toEqual("stuff goes here");
        // expect($scope.parseOriginalUrlStatus).toEqual('waiting');
        // expect($scope.doneScrapingOriginalUrl).toEqual(true);
    });
  });
//})();