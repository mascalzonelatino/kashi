kashi = angular.module('kashi',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

kashi.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'SongsController'
      ).when('/songs/:songId',
         templateUrl: "show.html"
         controller: 'SongController'
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

