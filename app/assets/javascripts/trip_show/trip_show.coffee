$ ->
  slug = $('.tripShowInfo').data("id")
  username = $('.tripShowInfo').data("name")
  $.getJSON '/u/' + username + '/travelstories/' + slug + '.json', (data) ->
    trip = data.trip
    biz = trip.businesses
    tripText = '<h2>' + trip.title + '</h2>'
    tripText += '<p>by <a href=\'/u/' + username + '\'>' + username + '</a></p>'
    tripText += '<p>' + trip.description + '</p>'
    tripText += '<hr><h4>Places I visited</h4>'
    tripText += '<ul>'
    i = 0
    while i < biz.length
      tripText += '<li>' + biz[i].name + '</li>'
      i++
    tripText += '</ul>'
    $('.tripShowInfo').append tripText
  return
