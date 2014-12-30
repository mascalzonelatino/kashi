describe "SongController", ->
  scope        = null
  ctrl         = null
  routeParams  = null
  httpBackend  = null
  flash        = null   
  location     = null 
  songId     = 42

  fakeSong   =
    id: songId
    name: "Human Nature"
    lyrics: "Reaching out across the night time"

  setupController =(songExists=true,songId=42)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.songId = songId if songId 
      flash = _flash_

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
        expect(flash.error).toBe("There is no song with ID #{songId}")

  describe 'create', ->
    newSong =
      id: 42
      name: 'Careless Whisper'
      lyrics: 'I feel so unsure'

    beforeEach ->
      setupController(false,false)
      request = new RegExp("\/songs")
      httpBackend.expectPOST(request).respond(201,newSong)

    it 'posts to the backend', ->
      scope.song.name         = newSong.name
      scope.song.lyrics = newSong.lyrics
      scope.save()
      httpBackend.flush()
      expect(location.path()).toBe("/songs/#{newSong.id}")

  describe 'update', ->
    updatedSong =
      name: 'Careless Whisper'
      lyrics: 'I feel so unsure'

    beforeEach ->
      setupController()
      httpBackend.flush()
      request = new RegExp("\/songs")
      httpBackend.expectPUT(request).respond(204)

    it 'posts to the backend', ->
      scope.song.name         = updatedSong.name
      scope.song.lyrics = updatedSong.lyrics
      scope.save()
      httpBackend.flush()
      expect(location.path()).toBe("/songs/#{scope.song.id}")

  describe 'delete' ,->
    beforeEach ->
      setupController()
      httpBackend.flush()
      request = new RegExp("\/songs/#{scope.song.id}")
      httpBackend.expectDELETE(request).respond(204)

    it 'posts to the backend', ->
      scope.delete()
      httpBackend.flush()
      expect(location.path()).toBe("/")

