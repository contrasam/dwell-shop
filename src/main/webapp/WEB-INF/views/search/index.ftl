<style>
    #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
    }
</style>
<div class="flexcontainer">
    <div class="small-column">
        <div class="filter-form">
            <h5>Filter Search</h5>

            <p><b>Property Type</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="type_switch"
                                                                        class="js-switch"/></p><br/>
            <select name="type" class="form-control">
                <option value="Row House">Row House</option>
                <option value="Apartments">Apartments</option>
                <option value="Detached House">Detached House</option>
                <option value="Condominium">Condominium</option>
            </select>
            <hr/>
            <p><b>Price Range</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="price_switch"
                                                                      class="js-switch"/></p><br/><br/>
            <b>$ 10</b> <input id="ex2" data-slider-id='ex1Slider' type="text" class="span2" value=""
                               data-slider-min="10" data-slider-max="2000" style="width:150px;" data-slider-step="5"
                               data-slider-value="[250,450]"/> <b>$ 2000</b>
            <hr/>
            <p><b>Number of Rooms</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="room_switch"
                                                                          class="js-switch"/></p>
            <b>1</b><input id="ex1" data-slider-id='ex2Slider' type="text" data-slider-min="0" data-slider-max="20"
                           data-slider-step="1" data-slider-value="3" style="width:180px;"/><b>20</b><br/><br/>
            <input type="button" class="btn btn-primary" value="Filter" onclick="search(true)"/>
            <hr/>
        </div>
    </div>
    <div class="large-column">
        <div class="search-box">
            <div class="input-group">
                <span class="input-group-addon" id="sizing-addon2">Search</span>
                <input type="text" class="form-control" name="query" placeholder="Search Term"
                       aria-describedby="sizing-addon2">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" onclick="search(false)">Go!</button>
                </span>
            </div>
        </div>
        <div class="search-results">

        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="propertyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel"><span id="property_title"></span></h4>
            </div>
            <div class="modal-body">
                <div id="property_content">

                </div>
                <input type="hidden" id="property_lat" value=""/>
                <input type="hidden" id="property_lng" value=""/>
                <iframe src="" style="zoom:0.60" width="99.6%" height="250" frameborder="0" id="map_frame"></iframe>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));

        elems.forEach(function (html) {
            var switchery = new Switchery(html);
        });
        $("#ex2").slider({});
        var slider = new Slider('#ex1', {
            formatter: function (value) {
                return 'Current value: ' + value;
            }
        });
    });

    function reloadSwitchery() {
        var elems = Array.prototype.slice.call(document.querySelectorAll('.modal-js-switch'));

        elems.forEach(function (html) {
            var switchery = new Switchery(html);
        });
    }

    function showProperty(property_id) {
        var url = "/property/query/";
        var data = {property_id: property_id};
        $.ajax({
            type: "POST",
            url: url,
            data: data
        }).done(function (response) {
            var property = response.attributes;
            var sale_type_obj = JSON.parse(response.sale_type_obj).attributes;
            var location_obj = JSON.parse(response.location_obj).attributes;
            $("#property_title").html(location_obj.street_name + ',' + location_obj.city + ',' + location_obj.state + ',' + location_obj.zip_code);
            var buttonEl = '';
            var price = '';
            if (property.sale_type == 'buyable') {
                buttonEl = '<button type="button" class = "btn btn-primary" >Buy</button>';
                price = "Price: $" + sale_type_obj.price;
            } else if (property.sale_type == 'biddable') {
                buttonEl = '<button type="button" class = "btn btn-success" >Bid Now</button>';
                price = "Minimum bidding price: $" + sale_type_obj.minimum_bidding_price;
            }
            if (property.sale_status == 'closed') {
                buttonEl = '<button type="button" class = "btn btn-danger" disabled="disabled">SOLD</button>';
            }
            $("#property_lat").val(location_obj.latitude);
            $("#property_lng").val(location_obj.longitude);
            $("#property_content").html('<div class="row"><div class = "col-md-4"><img src = "/images/' + Math.floor((Math.random() * 10) + 1) + '.jpg" class="bordered-image"/></div><div class="col-md-6"><p><b>' + price + '</b></p> <p>Type: ' + property.type + '</p> <p>Sub-Type: ' + property.sub_type + '</p> <p>Number of Rooms: ' + property.number_of_rooms + '</p>' + buttonEl + '<br/><br/><input type="checkbox" name="school_check" class="modal-js-switch"  />Show nearby schools&nbsp;&nbsp;&nbsp;<input type="checkbox" name="shopping_check" class="modal-js-switch"  />Show nearby malls<br/><br/></div></div>');
            $("input[name='school_check']").on('change', function () {
                $('#map_frame').attr("src", "/property/map?lat=" + $("#property_lat").val() + "&lng=" + $('#property_lng').val() + "&school_check=" + $("input[name='school_check']:checked").length + "&shopping_check=" + $("input[name='shopping_check']:checked").length);
            });
            $("input[name='shopping_check']").on('change', function () {
                $('#map_frame').attr("src", "/property/map?lat=" + $("#property_lat").val() + "&lng=" + $('#property_lng').val() + "&school_check=" + $("input[name='school_check']:checked").length + "&shopping_check=" + $("input[name='shopping_check']:checked").length);
            });
            $('#map_frame').attr("src", "/property/map?lat=" + $("#property_lat").val() + "&lng=" + $('#property_lng').val() + "&school_check=0&shopping_check=0");
            reloadSwitchery();
            $('#propertyModal').modal('show');
        });

    }

    function search(enableFilters) {
        var url = "/search/query";
        var query = $("input[name='query']").val();
        var data = {query: query};
        if (enableFilters) {
            var type = '';
            var number_of_rooms = '';
            var minimum_price = '';
            var maximum_price = '';
            if ($("input[name='type_switch']:checked").length == 1) {
                type = $("select[name='type'] option:selected").val();
            }
            if ($("input[name='price_switch']:checked").length == 1) {
                minimum_price = $("#ex2").val().split(',')[0];
                maximum_price = $("#ex2").val().split(',')[1];
            }
            if ($("input[name='room_switch']:checked").length == 1) {
                number_of_rooms = $("#ex1").val();
            }
            data = {query: query, type: type, number_of_rooms: number_of_rooms,minimum_price:minimum_price,maximum_price:maximum_price};
        }

        $.ajax({
            type: "POST",
            url: url,
            data: data
        }).done(function (response) {
            var results = response;
            var buttonEl = '';
            $(".search-results").html('');
            for (var key in results) {
                if (results[key].sale_type == 'buyable') {
                    buttonEl = '<button type="button" class = "btn btn-primary" onclick="showProperty(' + results[key].id + ')">Buy</button>';
                } else if (results[key].sale_type == 'biddable') {
                    buttonEl = '<button type="button" class = "btn btn-success" onclick="showProperty(' + results[key].id + ')">Bid Now</button>';
                }
                if (results[key].sale_status == 'closed') {
                    buttonEl = '<button type="button" class = "btn btn-danger" disabled="disabled">SOLD</button>';
                }
                var resultTemplate = '<div class="row result-box"><div class = "col-md-4"><img src = "/images/' + Math.floor((Math.random() * 10) + 1) + '.jpg" class="bordered-image"/></div><div class="col-md-6"><p id = "p1"><a href="#" onclick="showProperty(' + results[key].id + ')">' + results[key].street_name + ',' + results[key].city + ',' + results[key].state + ',' + results[key].zip_code + '</a></p><p><b>$' + results[key].price + '</b></p> <p>Type: ' + results[key].type + '</p> <p>Sub-Type: ' + results[key].sub_type + '</p> <p>Number of Rooms: ' + results[key].number_of_rooms + '</p>' + buttonEl + '</div></div>';
                $(".search-results").append(resultTemplate);
            }
        });
    }
</script>