var userCountry;
var isFocus = false;

function isfocusMember(userCountry) {
    var focusCountry = ["United States", "Canada", "Australia", "Russia", "Germany", "United Kingdom", "Italy", "Spain", "Ukraine", "Poland", "Romania", "Netherlands", "Belgium", "Greece", "Portugal", "Czech Republic", "Hungary", "Sweden", "Belarus", "Austria", "Switzerland", "Bulgaria", "Denmark", "Finland", "Slovakia", "Norway", "Ireland", "Croatia", "Luxembourg", "Iceland", "Singapore", "Hong Kong", "Brazil", "New Zealand"];
    if (focusCountry.indexOf(userCountry) !== -1) {
        return true;
    } else {
        return false;
    }
}


function showfreeTrial(isFocus) {
    if (isFocus) {
        $("#nav-cta-btn").html("FREE TRIAL");
    }
}

function getCountryinfo() {
    var url = 'https://countryip.herokuapp.com?callback=?';
    $.ajax({
        type: 'GET',
        url: url,
        async: false,
        jsonpCallback: 'jsonCallback',
        dataType: 'jsonp',
        success: function(json) {
            userCountry = json.country;
            isFocus = isfocusMember(userCountry);
            return showfreeTrial(isFocus);
        }
    });
}

$(document).ready(function(){
    getCountryinfo();
});