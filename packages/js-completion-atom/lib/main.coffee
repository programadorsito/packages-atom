utils = require "./utils-atom"
packageDeps = require 'atom-package-deps'
provider = require './autocomplete-provider'

module.exports =
    activate: ->
        atom.workspace.observeTextEditors (editor) ->
            editor.onDidSave ->
                buf = editor.getBuffer()
                console.log 'saved' + buf.getBaseName()
        packageDeps.install()
        .then ->
          provider.loadCompletions()


     getAutocompleteJavascript: ->
        provider
