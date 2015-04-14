<script src="https://code.jquery.com/jquery-git2.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
<style>
    html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
    }
</style>
<div id="map-canvas"></div>
<script>
    $(document).ready(function () {
        google.maps.event.addDomListener(window, 'load', initialize);
    });
    var MY_MAPTYPE_ID = 'custom_style';
    var featureOpts = [
        {
            featureType: 'road.highway',
            elementType: 'geometry',
            stylers: [
                { color: '#8B4513' }
            ]
        },{
            featureType: 'road.arterial',
            elementType: 'geometry',
            stylers: [
                { color: '#FA9A50' }
            ]
        },{
            featureType: 'road.local',
            elementType: 'geometry',
            stylers: [
                { color: '#C76114' }
            ]
        },{
            featureType: 'water',
            elementType: 'geometry',
            stylers: [
                { color: '#1B4170'}
            ]
        },{
            featureType: 'landscape.man_made',
            elementType: 'geometry',
            stylers: [
                { hue: '#EECBAD' }
            ]
        },{
            featureType: 'landscape.natural',
            elementType: 'geometry',
            stylers: [
                { hue: '#EECBAD' }
            ]
        }
    ];

    function initialize() {
        // Basic initialization & customization options
        var myLatLng = new google.maps.LatLng( getParameterByName("lat"), getParameterByName("lng") );
        console.log(myLatLng);
        myOptions = {
            zoom: 14,
            center: myLatLng,
            mapTypeControlOptions: {
                mapTypeIds: [google.maps.MapTypeId.ROADMAP, MY_MAPTYPE_ID]
            },
            mapTypeId: MY_MAPTYPE_ID
        };
        // Set map to custom map
        map = new google.maps.Map( document.getElementById( 'map-canvas' ), myOptions );
        var styledMapOptions = {
            name: 'Custom Style'
        };
        var customMapType = new google.maps.StyledMapType(featureOpts, styledMapOptions);
        map.mapTypes.set(MY_MAPTYPE_ID, customMapType);
        // Places request
        // ALL TYPES: https://developers.google.com/places/documentation/supported_types
        var places = [];
        if(getParameterByName("school_check") == 1){
            places.push('school');
        }
        if(getParameterByName("shopping_check") == 1){
            places.push('shopping_mall');
        }
        var request = {
            location: myLatLng,
            radius: 500,
            types: places
        };
        // Marker for center of map
        new google.maps.Marker({
            position: myLatLng,
            map: map
        });
        // Clickable labels for places request
        infowindow = new google.maps.InfoWindow();

        if(getParameterByName("shopping_check") == 1 || getParameterByName("school_check") == 1){
            var service = new google.maps.places.PlacesService(map);
            service.nearbySearch(request, callback);
        }

    }

    // Places map markers
    function createMarker(place) {
        var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';
        var icon = iconBase + 'schools_maps.png';
        if(place.types[0] == 'shopping_mall'){
            icon = iconBase + 'shopping_maps.png';
        }
        if(place.types[0] == 'school'){
            icon = iconBase + 'schools_maps.png';
        }
        var placeLoc = place.geometry.location;
        var marker = new google.maps.Marker({
            map: map,
            icon: icon,
            position: place.geometry.location
        });
        google.maps.event.addListener(marker, 'click', function() {
            infowindow.setContent(place.name);
            infowindow.open(map, this);
        });
    };

    function callback(results, status) {
        if (status == google.maps.places.PlacesServiceStatus.OK) {
            for (var i = 0; i < results.length; i++) {
                createMarker(results[i]);
            }
        }
    }

    function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }
</script>