kashi = angular.module('kashi',[
  'templates',
  'ngRoute',
  'controllers',
])

kashi.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'SongsController'
      )
])

controllers = angular.module('controllers',[])
controllers.controller("SongsController", [ '$scope',
  ($scope)->
])

