#= require_directory ./controllers/main

# Creates new Angular module called 'CC'
CC = angular.module('CC', ['ngRoute'])

# Sets up routing
CC.config(['$routeProvider', ($routeProvider) ->
  # Route for '/post'
  $routeProvider.when('/post', { templateUrl: '/templates/mainPost.html', controller: 'PostCtrl' } )

  # Default
  $routeProvider.otherwise({ templateUrl: '/templates/mainIndex.html', controller: 'IndexCtrl' } )

])
