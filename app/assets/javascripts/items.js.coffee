$ -> 
  $(".alert > div > span").click ->
    $(".alert").hide()

  Dropzone.options.myDropzone =
    paramName: "item[file]"
    init: ->
      @on "complete", (file) ->
        location.reload()
