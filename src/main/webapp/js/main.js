/**
 * Created by PradeepSamuel on 2015-03-20.
 */

$(document).ready(function(){
    makeItemActivefromRoute();
});

/*
* Script to make tabs active on top menu
* */
function makeItemActivefromRoute() {
    var url = window.location;
    $("a[href='" + url['pathname'] + "']").parent().addClass("active");
}