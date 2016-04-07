fs = require 'fs'
path = require 'path'
utils = require './utils-atom'

module.exports =
    selector: '.source.java'
    disableForSelector: '.source.java .comment, .source.java .string'

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
        unless strVar 
            return []
        esClase = strVar[0]==strVar[0].toUpperCase() && strVar.toUpperCase()!=strVar
        strClass = strVar
        unless esClase
            strClass = utils.get_first_match("[A-Z][a-zA-Z0-9<>,]* "+strVar)
        if strClass
            strClass = strClass.replace(/\<[a-zA-Z,]*\>/, "")
            strClass = strClass.substring(0, strClass.indexOf(" "))
            strPackage = utils.get_first_match("import [a-z0-9.]*"+strClass+";")
            unless strPackage
                strPackage = "java.lang."+strClass+";"
            if strPackage
                strPackageClass = strPackage.replace("import ", "").split(".").join("/").replace(";", "")
                strPackage = "D:/completion/java/json/"+strPackageClass+".json"
                jsonObject = utils.load_json(strPackage)
                unless jsonObject
                    return
                console.log jsonObject
                lista = []
                if esClase
                    lista = jsonObject["clase"]
                else
                    lista = jsonObject["object"]
                lista=({displayText:c, type:"function", description:c, descriptionMoreURL:"https://docs.oracle.com/javase/7/docs/api/?"+strPackageClass+".html", snippet:utils.put_cursor(c)} for c in lista)
                return lista
        return []