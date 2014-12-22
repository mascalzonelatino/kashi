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
controllers.controller("SongsController", [ '$scope', '$routeParams', '$location',
  ($scope,$routeParams,$location)->
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)

    if $routeParams.keywords
      keywords = $routeParams.keywords.toLowerCase()
      $scope.songs = songs.filter (song)-> song.name.toLowerCase().indexOf(keywords) != -1
    else
      $scope.songs = []
])
