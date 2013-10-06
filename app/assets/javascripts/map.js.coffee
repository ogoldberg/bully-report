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
      # Create a map centered in new york
      @createMap({coords:{latitude:"40.73006656461409", longitude: "-73.99033229194333"}})
      # Create the map.
      if navigator.geolocation
        # Ensure the callback is called with scope.
        navigator.geolocation.getCurrentPosition((pos) =>
          @map.setCenter(new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude))
          @loadSchools()
        )

      _that = @
      $("#map-search").on "submit", ->
        _that.searchForLocation.call(_that)
        return false

      # This can only be called once - overwrite the init property so running it
      # again doesn't do anyhing.
      @init = ->

    # If the user doesn't have HTML5 Geolocation, a form appears for them to
    # type an address. This method takes that address and creates a new map,
    # centered.
    searchForLocation: ->
      @createMap if @map is null
      address = $("#map-address").val()
      geocoder = new google.maps.Geocoder();
      geocoder.geocode(
        { 'address': address },
        (results, status) =>
          if (status == google.maps.GeocoderStatus.OK)
            @map.setCenter(results[0].geometry.location)
            @loadSchools()
      );

    # Creates the google map
    createMap: (pos) ->
      $("#gmap").css({ height: window.innerHeight - 70 })
      @map = new google.maps.Map(document.getElementById('gmap'),
        center: new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude),
        zoom: 13,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      )
      # After dragging, load new schools
      google.maps.event.addListener(@map, 'dragend', =>
        @loadSchools()
      )
      # And load schools immediately
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
        heatmapData.push({location: new google.maps.LatLng(i['lat'], i['lng']), weight: i['num_reports']})

      @heatmap.setMap(null) if @heatmap isnt null

      @heatmap = new google.maps.visualization.HeatmapLayer({
        data: heatmapData
      })
      @heatmap.setMap(@map)





  mapView.init()
)
