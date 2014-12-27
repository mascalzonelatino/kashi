describe "SongController", ->
  scope        = null
  ctrl         = null
  routeParams  = null
  httpBackend  = null
  location     = null
  songId     = 42

  fakeSong   =
    id: songId
    name: "Human Nature"
    lyrics: "Reaching out across the night time"

  setupController =(songExists=true,songId=42)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.songId = songId 

      if songId
        request = new RegExp("\/songs/#{songId}")
        results = if songExists
          [200,fakeSong]
        else
          [404]

        httpBackend.expectGET(request).respond(results[0],results[1])

      ctrl        = $controller('SongController',
                                $scope: scope)
    )

  beforeEach(module("kashi"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'song is found', ->
      beforeEach(setupController())
      it 'loads the given song', ->
        httpBackend.flush()
        expect(scope.song).toEqualData(fakeSong)
    describe 'song is not found', ->
      beforeEach(setupController(false))
      it 'loads the given song', ->
        httpBackend.flush()
        expect(scope.song).toBe(null)
        #what else?
