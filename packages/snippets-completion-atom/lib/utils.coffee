fs = require 'fs'

rutaJson = "D:/completion/snippets/"
dLang={"pl/sql (oracle)":"plsql", "coffeescript":"javascript"}

put_cursor = (texto) ->
  simbolo = "@"
  if texto.indexOf("~") != -1
    simbolo = "~"
  completacion = ""
  k=5
  for i in [0..(texto.length-1)]
    if !isNaN(parseInt(texto[i])) && texto[i-1]==simbolo
      continue
    if texto[i] == simbolo
      if texto.length < i+1 && !isNaN(parseInt(texto[i+1]))
        completacion+="${"+texto[i+1]+":}"
        continue
      completacion+="${"+k+":}"
      k+=1
      continue
    completacion+=texto[i]
  return completacion

read_json = (path) ->
  if dLang[path]
    path=dLang[path]
  ruta=rutaJson+path+".json"
  if fs.existsSync(ruta)
    return JSON.parse(fs.readFileSync(ruta, "utf8"))

generar_snippet = (dict, c, word, list) ->
  if c.replace("_", "").indexOf(word) != -1
    list.push({displayText:c, type:"snippet", description:c, descriptionMoreURL:c, snippet:put_cursor(dict[c])})

obtener_snippets = (dict, word) ->
  list = []
  (generar_snippet(dict, c, word, list) for c in Object.keys(dict))
  return list

module.exports =
  completar : (word) ->
    unless word
      return []
    if word.indexOf(".") != -1
      return []

    str = atom.workspace.getActiveTextEditor().getGrammar().name
    str = str.toLowerCase()
    dict = read_json(str)
    if dict
      return obtener_snippets(dict, word)
    else
      return []
