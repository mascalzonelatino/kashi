describe "SongsController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null

  setupController =(keywords)->
    inject(($location, $routeParams, $rootScope, $resource, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      ctrl        = $controller('SongsController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("kashi"))
  beforeEach(setupController())

  it 'defaults to no songs', ->
    expect(scope.songs).toEqualData([])
