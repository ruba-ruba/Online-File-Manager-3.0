$ ->
  $(".files_chart_sum").highcharts
    chart:
      type: "bar"

    title:
      text: "Chart of total files sum in system"

    xAxis:
      categories: ["Media files", "Text files", "Maps"]

    yAxis:
      min: 0
      title:
        text: "Total sum of files"

    legend:
      backgroundColor: "#FFFFFF"
      reversed: true

    plotOptions:
      series:
        stacking: "normal"

    series: [
      name: "Images"
      data: [images_sum, 0, 0]
    ,
      name: "Video"
      data: [video_sum, 0, 0]
    ,
      name: "Music"
      data: [music_sum, 0, 0]
    ,
      name: "Text"
      data: [0, texts_sum, 0]
    ,
      name: "Map"
      data: [0, 0, maps_sum]
    ]

  $(".files_chart_count").highcharts
    chart:
      plotBackgroundColor: null
      plotBorderWidth: null
      plotShadow: false

    title:
      text: "Chart of total files count in system"

    tooltip:
      pointFormat: "{series.name}: <b>{point.percentage:.1f}%</b>"

    plotOptions:
      pie:
        allowPointSelect: true
        cursor: "pointer"
        dataLabels:
          enabled: true
          color: "#000000"
          connectorColor: "#000000"
          formatter: ->
            "<b>" + @point.name + "</b>: " + @percentage + " %"

    series: [
      type: "pie"
      name: "Total files"
      data: [["Images", images_count], ["Video", video_count], ["Music", music_count], ["Text", texts_count], ["Map", maps_count]]
    ]
