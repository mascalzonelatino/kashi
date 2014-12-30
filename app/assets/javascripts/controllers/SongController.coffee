controllers = angular.module('controllers')
controllers.controller("SongController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    Song = $resource('/songs/:songId', { songId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.songId
      Song.get({songId: $routeParams.songId},
        ( (song)-> $scope.song = song ),
        ( (httpResponse)->
          $scope.song = null
          flash.error   = "There is no song with ID #{$routeParams.songId}"
        )
      )
    else
      $scope.song = {}

    $scope.back   = -> $location.path("/")
    $scope.edit   = -> $location.path("/songs/#{$scope.song.id}/edit")
    $scope.cancel = ->
      if $scope.song.id
        $location.path("/songs/#{$scope.song.id}")
      else
        $location.path("/")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.song.id
        $scope.song.$save(
          ( ()-> $location.path("/songs/#{$scope.song.id}") ),
          onError)
      else
        Song.create($scope.song,
          ( (newSong)-> $location.path("/songs/#{newSong.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.song.$delete()
      $scope.back()

])
