controllers = angular.module('controllers')
controllers.controller("SongController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->    
    Song = $resource('/songs/:songId', { songId: "@id", format: 'json' })

    Song.get({songId: $routeParams.songId},
      ( (song)-> $scope.song = song ),
      ( (httpResponse)->
        $scope.song = null
        flash.error   = "There is no song with ID #{$routeParams.songId}"
      )
    )
])

