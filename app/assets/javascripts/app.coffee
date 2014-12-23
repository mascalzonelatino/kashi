kashi = angular.module('kashi',[
  'templates',
  'ngRoute',
  'ngResource',
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

songs = [
  {
    id: 1
    name: 'Human Nature'
  },
  {
    id: 2
    name: 'Careless Whisper',
  },
  {
    id: 3
    name: 'Lowdown',
  },
  {
    id: 4
    name: 'La Prima Estate',
  },
]
controllers = angular.module('controllers',[])

