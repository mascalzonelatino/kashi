describe "SongsController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null

  httpBackend = null 

  setupController =(keywords,results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords
  
      httpBackend = $httpBackend 

      if results
        request = new RegExp("\/songs.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)

      ctrl        = $controller('SongsController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("kashi"))
  
  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
  describe 'when no keywords present', ->
    beforeEach(setupController())

    it 'defaults to no songs', ->
      expect(scope.songs).toEqualData([])

  describe 'with keywords', ->
    keywords = 'foo'
    songs = [
      {
        id: 2
        name: 'Careless Whisper'
      },
      {
        id: 4
        name: 'La Prima Estate'
      }
    ]
    beforeEach ->
      setupController(keywords,songs)
      httpBackend.flush()

    it 'calls the back-end', ->
      expect(scope.songs).toEqualData(songs)

  describe 'search()', ->
    beforeEach ->
      setupController()

    it 'redirects to itself with a keyword param', ->
      keywords = 'foo'
      scope.search(keywords)
      expect(location.path()).toBe("/")
      expect(location.search()).toEqualData({keywords: keywords})

