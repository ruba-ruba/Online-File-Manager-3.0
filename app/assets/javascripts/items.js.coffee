$ -> 
  $(".alert > div > span").click ->
    $(".alert").hide()

  Dropzone.options.myDropzone =
    paramName: "item[file]"
    init: ->
      @on "success", (file, response) ->
        $("tbody").append(response.html)
      @on "error", (file, response) ->
        alert response
      @on "complete", (file) ->
        @removeAllFiles(true)