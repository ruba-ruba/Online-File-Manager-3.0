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

  $(".items").on "click", ->
    $(".item_details").html($(this).children(".item_info_hidden").html())