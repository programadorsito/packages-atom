{SelectListView} = require 'atom-space-pen-views'

module.exports =
class MySelectListView extends SelectListView
 initialize: ->
   super
   @addClass('overlay from-top')
   @setItems(['Hello', 'World'])
   @panel ?= atom.workspace.addModalPanel(item: this) 
   @panel.show()
   @focusFilterEditor()

 viewForItem: (item) ->
    unless item
      return
    if typeof(item) == "string"
        "<li>#{item}</li>"
    else
        "<li><p style='font-size:1.5em'>#{item[0]}</p><p>#{item[1]}</p></li>"

 confirmed: (item) ->
   console.log("#{item} was selected")

 cancelled: ->
   console.log("This view was cancelled")