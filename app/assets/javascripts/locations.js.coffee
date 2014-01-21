# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class @FileManagerMap
  constructor: (coordinates) ->
    @pointers = coordinates
    @drawMap()

  coordinates: ->
    @pointers

  drawMap: ->
    # google map is being drawn here
    myLatlng = new google.maps.LatLng(@pointers[0].latitude, @pointers[0].longitude)
    mapOptions =
      zoom: 4
      center: myLatlng
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)
    marker = new google.maps.Marker(
      position: myLatlng
      map: map
      title: "New marker"
    )
    marker.setMap map

    # yandex map is being drawn here
    ymaps.ready ->
      yMap = new ymaps.Map(document.getElementById("yandex-map"),
        center: [55.87, 37.66]
        zoom: 4
        behaviors: ['default', 'scrollZoom']
      )
