fs = require 'fs'

rutaJs = "D:/completion/javascript/functions.json"

read_json = (path) ->
  return JSON.parse(fs.readFileSync(rutaJs))

obtener_completaciones = (list, tipo) ->
  return ({displayText:c, type:tipo, description:c, descriptionMoreURL:c, snippet:c} for c in list)

module.exports =
  completar : (word) ->
    tipo = "function"
    unless word
      return []
    d=read_json()
    lista=[]
    if word.indexOf(".") != -1
        word=word.substring(0, word.indexOf("."))
        lista=d[word]
    else
        lista = Object.keys(d)
        tipo="class"

    if lista
      return obtener_completaciones(lista, tipo)
    else
      return []
