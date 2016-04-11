{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: -&gt;
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'ascii-art:convert': =&gt; @convert()

  deactivate: -&gt;
    @subscriptions.dispose()

  convert: -&gt;
    console.log("entro aqui")
    if editor = atom.workspace.getActiveTextEditor()
      editor.insertText('Hello, World!')
