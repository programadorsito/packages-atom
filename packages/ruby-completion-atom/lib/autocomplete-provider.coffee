fs = require 'fs'
path = require 'path'
utils = require './utils-atom'

module.exports =
    selector: '.source.ruby'
    disableForSelector: '.source.ruby .comment, .source.ruby .string'

    inclusionPriority: 1
    excludeLowerPriority: false
    filterSuggestions: true

    getSuggestions: ( { editor, prefix, bufferPosition } ) ->
        @completions = @completar(prefix)
        return @completions

    loadCompletions: ->
        @completions = {}

    compareStrings: ( a, b ) ->
        a[0].toLowerCase() is b[0].toLowerCase()

    completar : (prefix) ->
        strVar = utils.get_var()
        strPath = "D:/completion/ruby/librerias/"+strVar+".json"
        unless fs.existsSync(strPath)
            return
        lista = utils.load_json(strPath)
        lista=({displayText:c, type:"function", description:c, descriptionMoreURL:c, snippet:c} for c in lista)
        return lista