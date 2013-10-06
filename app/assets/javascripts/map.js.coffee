# We don't need to do anything if we're not on the map page.
return if document.getElementById("gmap") is null


$( ->

  # This is just a container for our map functions.
  window.mapView =
    # Stores the Google Map object
    map: null,
    heatmap: null,

    # Adds the google maps API and initialises the rest of the maps routines.
    init: ->
      # Create the map.
      if navigator.geolocation
        # Ensure the callback is called with scope.
        navigator.geolocation.getCurrentPosition((pos) =>
          @createMap(pos)
        )

      # This can only be called once - overwrite the init property so running it
      # again doesn't do anyhing.
      @init = ->

    # If the user doesn't have HTML5 Geolocation, a form appears for them to
    # type an address. This method takes that address and creates a new map,
    # centered.
    searchForLocation: ->
      createMap()

    createMap: (pos) ->
      debugger
      $("#gmap").css({ height: window.innerHeight - 70 })
      @map = new google.maps.Map(document.getElementById('gmap'),
        center: new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude),
        zoom: 13,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      )

      google.maps.event.addListener(@map, 'dragend', =>
        @loadSchools()
      )

      @loadSchools()

      # Now, we need to post for schools around the current area.

    loadSchools: ->
      pos = @map.getCenter()
      $.ajax
        url: "/map/search"
        data: "latitude=" + pos.lat() + "&longitude=" + pos.lng()
        method: "GET"
        success: (data) =>
          @mapSchools(data)
        error: (data) ->
          console.log(data)

    mapSchools: (data) ->
      data = $.parseJSON(data) if typeof data is "string"

      heatmapData = []
      for i in data
        heatmapData.push({location: new google.maps.LatLng(i['lat'], i['lng']), weight: i['num_results']})

      @heatmap.setMap(null) if @heatmap isnt null

      @heatmap = new google.maps.visualization.HeatmapLayer({
        data: heatmapData
      })
      @heatmap.setMap(@map)





  mapView.init()
)
