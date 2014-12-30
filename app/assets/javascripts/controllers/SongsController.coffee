controllers = angular.module('controllers')
controllers.controller("SongsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
    Song = $resource('/songs/:songId', { songId: "@id", format: 'json' })

    if $routeParams.keywords
      Song.query(keywords: $routeParams.keywords, (results)-> $scope.songs = results)
    else
      $scope.songs = []

    $scope.view = (songId)-> $location.path("/songs/#{songId}")	

    $scope.newSong = -> $location.path("/songs/new")
    $scope.edit      = (songId)-> $location.path("/songs/#{songId}/edit")

])
