$(function() {
  $.getJSON('/travelstories.json', function(data) {
    var i, tripText, trips;
    trips = data.trips;
    i = 0;
    while (i < trips.length) {
      tripText = '<div class=\'col-md-12 well well-white\'><p><span class=\'trip-title\'>';
      tripText += '<a href=\'/u/' + trips[i].user.username + '/travelstories/' + trips[i].slug + '\'>' + trips[i].title + '</a></span> by ';
      tripText += '<a href=\'/u/' + trips[i].user.slug + '/travelstories\'>' + trips[i].user.name + '</a></p>';
      tripText += '<p>' + trips[i].description.substring(0, 250) + '...';
      tripText += '<a href=\'/u/' + trips[i].user.username + '/travelstories/' + trips[i].slug + '\'> Read More</a></p></div>';
      $('#tripInfo').append(tripText);
      i++;
    }
  });
});
