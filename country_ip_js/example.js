var userCountry;
var isFocus = false;

function isfocusMember(userCountry) {
    var focusCountry = ["United States", "Canada", "Australia", "Russia", "Germany", "United Kingdom", "Italy", "Spain", "Ukraine", "Poland", "Romania", "Netherlands", "Belgium", "Greece", "Portugal", "Czech Republic", "Hungary", "Sweden", "Belarus", "Austria", "Switzerland", "Bulgaria", "Denmark", "Finland", "Slovakia", "Norway", "Ireland", "Croatia", "Luxembourg", "Iceland", "Singapore", "Hong Kong", "Brazil", "New Zealand"];
    if (focusCountry.indexOf(userCountry) !== -1) {
        return true;} else {
        return false;
    }
}

function showfreeTrial(isFocus) {
  if (isFocus) {
    $("#nav-cta-btn").html("FREE TRIAL");
  }
}

$.getJSON("http://www.telize.com/geoip?callback=?",
    function(json) {
        userCountry = json.country;
        isFocus = isfocusMember(userCountry);
        return showfreeTrial(isFocus);
    }
);


// sync with ajax
// why ternanry didn't work?
// focus_country.indexOf(userCountry) != -1 ? true : false;

