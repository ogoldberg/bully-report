$(function() {
  if (document.getElementById("gmap") === null) {
    return;
  }
 
  $(function() {
    window.mapView = {
      map: null,
      heatmap: null,
      init: function() {
        var _that,
          _this = this;
        this.createMap({
          coords: {
            latitude: "40.73006656461409",
            longitude: "-73.99033229194333"
          }
        });
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(pos) {
            _this.map.setCenter(new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude));
            return _this.loadSchools();
          });
        }
        _that = this;
        $("#map-search").on("submit", function() {
          _that.searchForLocation.call(_that);
          return false;
        });
        return this.init = function() {};
      },
      searchForLocation: function() {
        var address, geocoder,
          _this = this;
        if (this.map === null) {
          this.createMap;
        }
        address = $("#map-address").val();
        geocoder = new google.maps.Geocoder();
        return geocoder.geocode({
          'address': address
        }, function(results, status) {
          if (status === google.maps.GeocoderStatus.OK) {
            _this.map.setCenter(results[0].geometry.location);
            return _this.loadSchools();
          }
        });
      },
      createMap: function(pos) {
        var _this = this;
        $("#gmap").css({
          height: window.innerHeight - 70
        });
        this.map = new google.maps.Map(document.getElementById('gmap'), {
          center: new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude),
          zoom: 13,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        google.maps.event.addListener(this.map, 'dragend', function() {
          return _this.loadSchools();
        });
        return this.loadSchools();
      },
      loadSchools: function() {
        var pos,
          _this = this;
        pos = this.map.getCenter();
        return $.ajax({
          url: "/map/search",
          data: "latitude=" + pos.lat() + "&longitude=" + pos.lng(),
          method: "GET",
          success: function(data) {
            return _this.mapSchools(data);
          },
          error: function(data) {
            return console.log(data);
          }
        });
      },
      mapSchools: function(data) {
        var heatmapData, i, _i, _len;
        if (typeof data === "string") {
          data = $.parseJSON(data);
        }
        heatmapData = [];

        // added by AGF: set an empty array for the markerCluster
        var markers = [];
        // set an array to store the marker styles for each item
        var markerStyles = [];
        // create reference for each marker to use
        var marker;

        for (_i = 0, _len = data.length; _i < _len; _i++) {
          i = data[_i];
          heatmapData.push({
            location: new google.maps.LatLng(i['lat'], i['lng']),
            weight: i['num_results']
          });

          // for each item, create a latLng object to assign to a marker
          var latLng = new google.maps.LatLng(i['lat'],i['lng']);

          // create a style for the marker
          var markerStyle = {url: '/assets/map-marker.png', 
            height:15, 
            width:15
           // textColor:'transparent'
          };

          // create a new image for the map markers
          var image = {
            url: '/assets/map-marker.png',
            // This marker is 20 pixels wide by 32 pixels tall.
            size: new google.maps.Size(15, 15),
            // The origin for this image is 0,0.
            origin: new google.maps.Point(0,0),
            // The anchor for this image is the base of the flagpole at 0,32.
            anchor: new google.maps.Point(0, 0)
          };

          // for each item, create a marker using its latLng object created above
          marker = new google.maps.Marker({position: latLng});

          // Create info bubble over map marker
          // TODO: get this done somehow
          
          var infoWindow = new google.maps.InfoWindow({
              position: latLng
          });

          /* google.maps.event.addListener(marker, 'click', function (event) {
              infoWindow.open(this.map, marker);
              console.log("hello:");
              console.log(event );
          }); */
          google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
                var s_content = '<div style="padding:10px"><strong>'+i['name']+'</strong><br/><p>'+i['address']+'</p><p>'+i['phone']+'</p>';
                if(i['num_reports'] > 0) {
                    s_content += "<p><a href='/schools/"+i['id']+"'>View Report</a></p>";
                }else{
                    s_content += "<p>No reports on file.</p>";
                }
                infoWindow.setContent(s_content);
                infoWindow.open(this.map, marker);
            }
          })(marker, i));

          // push the style into the styles array
          markerStyles.push(markerStyle);

          // push the marker for the object into the Markers Array
          markers.push(marker);

        }
        if (this.heatmap !== null) {
          this.heatmap.setMap(null);
        }
        this.heatmap = new google.maps.visualization.HeatmapLayer({
          data: heatmapData
        });

        // assign all the markers to the markerCluster using the markers Array
        var markerCluster = new MarkerClusterer(this.map, markers, {styles:markerStyles});

        return this.heatmap.setMap(this.map);
      }
    };
    return mapView.init();
  });
 
});