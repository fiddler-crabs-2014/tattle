#= require_directory ./controllers/main
#= require_directory ./freebase

CC = angular.module('CC', ['ngRoute', 'ngAnimate'])

CC.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/results', { templateUrl: '/templates/mainResults.html', controller: 'ResultsCtrl' } )

  $routeProvider.when('/browse', { templateUrl: '/templates/mainBrowse.html', controller: 'BrowseCtrl' } )

  $routeProvider.otherwise({ templateUrl: '/templates/mainIndex.html', controller: 'IndexCtrl' } )

])
