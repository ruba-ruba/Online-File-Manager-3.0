FileManager.Views.Filelists ||= {}

class FileManager.Views.Filelists.IndexView extends Backbone.View
  template: JST["backbone/templates/filelists/index"]

  render: ->
          $(@el).html(@template())       
          this 
