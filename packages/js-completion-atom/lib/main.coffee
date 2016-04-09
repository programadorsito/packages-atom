utils = require "./utils-atom"
packageDeps = require 'atom-package-deps'
provider = require './autocomplete-provider'

module.exports =
    activate: ->
        atom.workspace.observeTextEditors (editor) ->
            editor.onDidSave ->
                ruta = editor.getPath()
                list=utils.load_json("D:/atom/packages/packages/history-files-atom/data/history_files.json")
                for i in [0..list.length]
                    if ruta == list[i]
                        return
                        
                list.push(ruta)
                utils.save_json("D:/atom/packages/packages/history-files-atom/data/history_files.json", list)
        packageDeps.install()
        .then ->
          provider.loadCompletions()


     getAutocompleteJavascript: ->
        provider
