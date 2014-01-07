# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  initialize_index = ->
    mapOptions =
      zoom: 7
      center: new google.maps.LatLng(48.8566, 2.35222)

    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

  initialize_show = (lat, lng) ->
    mapOptions =
      zoom: 7
      center: new google.maps.LatLng(lat, lng)

    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)
