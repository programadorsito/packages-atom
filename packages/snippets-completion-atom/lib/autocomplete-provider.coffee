fs = require 'fs'
path = require 'path'
utils = require './utils'

module.exports =
    selector: '*'
    disableForSelector: '.comment, .string'

    inclusionPriority: 2
    excludeLowerPriority: false
    filterSuggestions: false

    getSuggestions: ( { editor, prefix, bufferPosition } ) ->
        @completions = utils.completar(prefix)
        return @completions

    loadCompletions: ->
        @completions = {}
        fs.readFile path.resolve( __dirname, '..', './data/corona-data.json' ), ( error, data ) =>
            console.log "intento"
            @completions = JSON.parse( data ) unless error?
            return

    compareStrings: ( a, b ) ->
        a[0].toLowerCase() is b[0].toLowerCase()

    getPrefix: (editor, bufferPosition) ->
      regex = /[a-zA-Z0-9_\.]*$/
      line = editor.getTextInRange([[bufferPosition.row, 0], bufferPosition])
      console.log ""
      line.match(regex)?[0] or ''
