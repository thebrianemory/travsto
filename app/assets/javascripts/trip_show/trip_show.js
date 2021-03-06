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
