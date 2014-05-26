#= require_directory ./controllers/main
#= require_directory ./freebase

# Creates new Angular module called 'CC'
CC = angular.module('CC', ['ngRoute'])

# Sets up routing
CC.config(['$routeProvider', ($routeProvider) ->
  # Route for '/result'
  $routeProvider.when('/results', { templateUrl: '/templates/mainResults.html', controller: 'ResultsCtrl' } )

  # Route for '/browse'
  $routeProvider.when('/browse', { templateUrl: '/templates/mainBrowse.html', controller: 'BrowseCtrl' } )

  # Default
  $routeProvider.otherwise({ templateUrl: '/templates/mainIndex.html', controller: 'IndexCtrl' } )

])
