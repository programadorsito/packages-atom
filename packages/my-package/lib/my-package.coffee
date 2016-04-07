MyPackageView = require './my-package-view'
utils = require 'utils-atom'

{CompositeDisposable} = require 'atom'

module.exports = MyPackage =
  myPackageView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @myPackageView = new MyPackageView(state.myPackageViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @myPackageView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'my-package:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @myPackageView.destroy()

  serialize: ->
    myPackageViewState: @myPackageView.serialize()

  toggle: ->
    console.log 'MyPackage was toggled!'
    console.log 'Ingreso bien a mi paquete de control'
    #hablar
    u = new SpeechSynthesisUtterance()
    u.text = 'Bienvenido al sistema'
    u.lang = 'es-CO'
    u.rate = 1.2
    speechSynthesis.speak(u)

    funcion = (texto) ->
        console.log("Este es el texto escrito" + texto)
    utils.input_dialog(funcion)

    #reconocer una frase
    #recognition = new webkitSpeechRecognition();
    #recognition.onresult = (event) ->
    #  if event.results.length > 0
    #    console.log event.results[0][0].transcript;
    #recognition.lang="es-CO"
    #recognition.start()

    #hablada en continuo
    #texto = ""
    #recognizing=false
    #recognition = new webkitSpeechRecognition()
    #recognition.continuous = true
    #reset = ->
    #  recognizing=false
    #recognition.onend = reset

    #recognition.onresult = (event) ->
    #  for i in [event.resultIndex..event.results.length]
    #    if event.results[i].isFinal
    #      texto+=event.results[i][0].transcript
    #      console.log texto



    #toggleStartStop = ->
    #  if recognizing
    #    recognition.stop()
    #    reset()
    #  else
    #    recognition.start()
    #    recognizing = true

    #toggleStartStop()

    #if @modalPanel.isVisible()
    #  @modalPanel.hide()
    #else
    #  @modalPanel.show()
