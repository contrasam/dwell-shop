<div class="sign-up-form">
    <h3>Sign Up</h3>
    <p>
    <@flash name="register_error"/>
    </p>
    <form method="POST" action="${context_path}/home/register">
        <input type="email" class="form-control text-box-top-margin" placeholder="Email address" name="email_address" />
        <input type="password" class="form-control text-box-top-margin" placeholder="Enter Password" name="password" />
        <input type="text" class="form-control text-box-top-margin" placeholder="Enter First Name" name="first_name" />
        <input type="text" class="form-control text-box-top-margin" placeholder="Enter Last Name" name="last_name" />
        <input type="text" class="form-control text-box-top-margin" placeholder="Enter Profession (Optional)" name="profession" />
        <input type="text" class="form-control text-box-top-margin" placeholder="Enter Company (Optional)" name="company" />
        <input type="text" class="form-control text-box-top-margin" id="autocomplete" onFocus="geolocate()" placeholder="Enter Address" />
        <input type="number" class="form-control text-box-top-margin" id="street_number" placeholder="Enter Street Number" name="street_number" />
        <input type="text" class="form-control text-box-top-margin" id="route" placeholder="Enter Street Name" name="street_name" />
        <input type="text" class="form-control text-box-top-margin" placeholder="Enter Suite Number" name="suite_number" />
        <input type="text" class="form-control text-box-top-margin" id="locality" placeholder="Enter City" name="city" />
        <input type="text" class="form-control text-box-top-margin" id="administrative_area_level_1" placeholder="Enter State" name="state" />
        <input type="text" class="form-control text-box-top-margin" id="postal_code" placeholder="Enter Zip Code" name="zip_code" />
        <input type="text" class="form-control text-box-top-margin" id="country" placeholder="Enter Country" name="country" />
        <input type="hidden" class="form-control text-box-top-margin"  id="lat" name="latitude" />
        <input type="hidden" class="form-control text-box-top-margin"  id="lng" name="longitude" />
        <input type="submit" class="btn btn-primary" value="Sign Up"/>
    </form>
</div>
<script>
    $(document).ready(function(){
        initialize();
    });
    var placeSearch, autocomplete;
    var componentForm = {
        street_number: 'short_name',
        route: 'long_name',
        locality: 'long_name',
        administrative_area_level_1: 'short_name',
        country: 'long_name',
        postal_code: 'short_name'
    };

    function geolocate() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var geolocation = new google.maps.LatLng(
                        position.coords.latitude, position.coords.longitude);
                $("#lat").val(position.coords.latitude);
                $("#lng").val(position.coords.longitude);
                var circle = new google.maps.Circle({
                    center: geolocation,
                    radius: position.coords.accuracy
                });
                autocomplete.setBounds(circle.getBounds());
            });
        }
    }

    function fillInAddress() {
        // Get the place details from the autocomplete object.
        var place = autocomplete.getPlace();

        for (var component in componentForm) {
            document.getElementById(component).value = '';
            document.getElementById(component).disabled = false;
        }

        // Get each component of the address from the place details
        // and fill the corresponding field on the form.
        for (var i = 0; i < place.address_components.length; i++) {
            var addressType = place.address_components[i].types[0];
            if (componentForm[addressType]) {
                var val = place.address_components[i][componentForm[addressType]];
                document.getElementById(addressType).value = val;
            }
        }
    }

    function initialize() {
        // Create the autocomplete object, restricting the search
        // to geographical location types.
        autocomplete = new google.maps.places.Autocomplete(
                /** @type {HTMLInputElement} */(document.getElementById('autocomplete')),
                { types: ['geocode'] });
        // When the user selects an address from the dropdown,
        // populate the address fields in the form.
        google.maps.event.addListener(autocomplete, 'place_changed', function() {
            fillInAddress();
        });
    }
</script>