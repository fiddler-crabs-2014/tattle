window.CC = angular.module('CC', ['ngRoute'])

window.CC.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/results', { templateUrl: '/templates/mainResults.html', controller: 'ResultsCtrl' } )

  $routeProvider.when('/browse', { templateUrl: '/templates/mainBrowse.html', controller: 'BrowseCtrl' } )

  $routeProvider.otherwise({ templateUrl: '/templates/mainIndex.html', controller: 'IndexCtrl' } )

])

CC.controller('IndexCtrl', this.IndexCtrl)
