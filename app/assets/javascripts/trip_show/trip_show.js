var Trip, TripUser;

Trip = function(title, description, user, businesses) {
  this.title = title;
  this.description = description;
  this.user = user;
  this.businesses = businesses;
};

TripUser = function(slug, first_name, last_name) {
  this.slug = slug;
  this.first_name = first_name;
  this.last_name = last_name;
};

$(function() {
  var slug, username;
  slug = void 0;
  username = void 0;
  slug = $('.tripShowInfo').data('id');
  username = $('.tripShowInfo').data('name');
  $.getJSON('/u/' + username + '/travelstories/' + slug + '.json', function(data) {
    var biz, i, trip, tripText, user;
    biz = void 0;
    i = void 0;
    trip = void 0;
    tripText = void 0;
    user = void 0;
    trip = new Trip(data.trip.title, data.trip.description, data.trip.user, data.trip.businesses);
    biz = trip.businesses;
    user = new TripUser(trip.user.slug, trip.user.first_name, trip.user.last_name);
    tripText = '<h2>' + trip.title + '</h2>';
    tripText += '<p>by <a href=\'/u/' + username + '/travelstories\'>' + user.fullName() + '</a></p>';
    tripText += '<p>' + trip.description + '</p>';
    tripText += '<hr><h4>Places I visited</h4>';
    tripText += '<ul>';
    i = 0;
    while (i < biz.length) {
      tripText += '<li>' + biz[i].name + '</li>';
      i++;
    }
    tripText += '</ul>';
    return $('.tripShowInfo').append(tripText);
  });
});

TripUser.prototype.fullName = function() {
  return this.first_name + ' ' + this.last_name;
};

$(document).ready(function() {

  $("#owl-example").owlCarousel({

    // Most important owl features
    items : 1,
    itemsCustom : false,
    itemsDesktop : [1199,1],
    itemsDesktopSmall : [980,1],
    itemsTablet: [768,1],
    itemsTabletSmall: false,
    itemsMobile : [479,1],
    singleItem : true,
    itemsScaleUp : false,

    //Basic Speeds
    slideSpeed : 200,
    paginationSpeed : 800,
    rewindSpeed : 1000,

    //Autoplay
    autoPlay : false,
    stopOnHover : false,

    // Navigation
    navigation : true,
    navigationText : ["prev","next"],
    rewindNav : true,
    scrollPerPage : false,

    //Pagination
    pagination : true,
    paginationNumbers: false,

    // Responsive
    responsive: true,
    responsiveRefreshRate : 200,
    responsiveBaseWidth: window,

    // CSS Styles
    baseClass : "owl-carousel",
    theme : "owl-theme",

    //Lazy load
    lazyLoad : false,
    lazyFollow : true,
    lazyEffect : "fade",

    //Auto height
    autoHeight : true,

    //JSON
    jsonPath : false,
    jsonSuccess : false,

    //Mouse Events
    dragBeforeAnimFinish : true,
    mouseDrag : true,
    touchDrag : true,

    //Transitions
    transitionStyle : false,

    // Other
    addClassActive : false,

    //Callbacks
    beforeUpdate : false,
    afterUpdate : false,
    beforeInit: false,
    afterInit: false,
    beforeMove: false,
    afterMove: false,
    afterAction: false,
    startDragging : false,
    afterLazyLoad : false

})
});
