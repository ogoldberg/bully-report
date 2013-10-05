$(function() {
    
    // assign a var to the radio buttons based on their name
    var radialSearchChoices = $('input[name="radialSearchChoices"]');
    
    // Setup the search by location
    var locationRadial = $("#optionsLocation");
    if(!Modernizr.geolocation){
        locationRadial.hide();
    }
    
    // init the search time
    var searchType = "name";
    var searchField = $("#searchField");
    var locationHiddenVal = $("#hiddenLocationValues");
    
    // create the change function for the radialSearchChoices
    radialSearchChoices.bind("click", function(event) {
        
        // set the search type based on the radial value
        searchType = event.currentTarget.defaultValue;
        // change search field name
        searchField.attr('name', searchType);
        // if its location, get the Geolocation of the user
        if (searchType == "location") {
            // append geolocation as hidden values and add to searchField
            get_location(locationHiddenVal, searchField);
        }else{
            // clear search field and hidden geo values
            locationHiddenVal.html('');
            searchField.val('');
        }
        
    });
    
});

/*
 * This function gets the current location and appends it in HTML
 * TODO: Separate the HTML bits from this function
 */
function get_location(div, input) {
    navigator.geolocation.getCurrentPosition(function(position){
          console.log({lat:position.coords.latitude, long:position.coords.longitude});
          div.append('<input type="hidden" value="'+position.coords.latitude+'" name="lat"/>');
          div.append('<input type="hidden" value="'+position.coords.longitude+'" name="lng"/>');
          input.val(position.coords.latitude+', '+position.coords.longitude);
    });
}