InputDialog  = require 'input-dialog'
fs  = require 'fs'

module.exports =
  input_dialog : (f) ->
    dialog = new InputDialog({
      callback: (text) ->
        f(text)
    })
    dialog.attach()

  select_dialog : (f) ->
    return

  load_json : (path) ->
    if fs.existsSync(path)
      return JSON.parse(fs.readFileSync(path))

  save_json : (path, jsonObject) ->
    fs.writeFile(path, JSON.stringify(jsonObject))

  get_language : ->
    return atom.workspace.getActiveTextEditor().getGrammar().name

  get_line : ->
    editor = atom.workspace.getActiveTextEditor()
    cursor = editor.getCursors()[0]
    return cursor.getCurrentBufferLine()

  get_folder : ->
    return

  go_line : (line) ->
    return

  get_text: ->
    return atom.workspace.getActiveTextEditor().getBuffer().getText()

  show_msg: (msg) ->
    return

  get_ext : ->
    return

  get_files : ->
    return

  get_path : ->
    return

  get_filename : ->
    return

  get_filebasename : ->
    return

  get_filedir : ->
    return

  get_files_project : ->
    return

  say: (text, lang, rate) ->
    u = new SpeechSynthesisUtterance()
    u.text = text
    u.lang = lang || "en-US" 
    u.rate = rate || 1.2
    speechSynthesis.speak(u)

  hear: (f, lang) ->
    recognition = new webkitSpeechRecognition();
    recognition.lang= lang || "es-CO"
    recognition.onresult = (event) ->
      if event.results.length > 0
        f(event.results[0][0].transcript)
    recognition.start()

  set_preference : (key, value, tipo) ->
    tipo = tipo || "project"

  get_preference : (key) ->
    return

  get_preferences : ->
    return

  get_env : (variable) ->
    return

  get_completion_list : (list, tipo) ->
    return ({displayText:c, type:tipo, description:c, descriptionMoreURL:c, snippet:c} for c in list)

  get_editor : ->
    return atom.workspace.getActiveTextEditor()

  get_buffer : ->
    return atom.workspace.getActiveTextEditor().getBuffer()

  get_var : ->
    line = @get_line() 
    prefix = line.match(/[a-zA-Z0-9_.]*$/) or ['']
    prefix = prefix[0]
    if prefix.indexOf(".") != -1
      return prefix.substring(0, prefix.indexOf("."))
    return prefix

  get_last_word : ->
    line = @get_line() 
    prefix = line.match(/[a-zA-Z0-9_.]*$/) or ['']
    prefix = prefix[0]
    return prefix

  get_lines : ->
    return atom.workspace.getActiveTextEditor().getBuffer().getLines()

  get_first_match : (regex) ->
    text = @get_text()
    matches = text.match(regex)
    if matches
      return matches[0]

  get_last_match : (regex) ->
    lines = @get_lines()
    l = lines.length-1
    for i in [0..lines.length]
      line = lines[l]
      matches = line.match(regex)
      if matches
        return matches[0]
      l-=1

  replaces : (text) ->
    return

  put_cursor : (cadena) ->
    newCadena = ""
    i=1 
    for k in [0..(cadena.length-1)]
      c = cadena[k]
      switch c
        when "[," then c = ",["
        when "." then c = ""
        when "(" then c = "(${@:"
        when ")" then c = "})"
        when "," then c = "},${@:"
        else c = c
      
      
      if c.indexOf("@") != -1
        c=c.replace("@", i)
        i+=1
      newCadena+=c
    return newCadena

  on_save : (f) ->
    atom.workspace.observeTextEditors (editor) ->
      editor.onDidSave ->
        f(editor)


#def d(msg):
#def get_path_plugin(pluginName):
#def get_file_plugin(pluginName, filename):
#def go_and_check(line):
#def go(line, column):
#def go_point(point):
#def get_view(args=None):
#def get_window(args=None):
#def get_files_base(ruta, l, ext=None, ignores=[], match=None):
#def get_files(args=None):
#def get_dict_files(args=None):
#def get_folders(args=None):
#def get_files_java():
#def get_files_project(exts):
#def replace_region(text="", region=None):
#def replace_regions(regions=None, words=None):
#def get_sel(args={}):
#def get_sels(args={}):
#def set_sel(args={}):
#def get_parts(args={}):
#def get_parts_java(args={}):
#def get_parts_python(args=None):
#def get_parts_css(args=None):
#def get_parts_ruby(args=None):
#def get_temp(ext='', name='app'):
#def get(key):
#def set(key, value=True):
#def thread(f, args=None):
#def run_command(command, args=None):
#def execute(silent=True, thread=True):
#def input(f, msg="", default=""):
#def select(lista, f=None):
#def show_status(msg="ok"):
#def get_packages_path(*lista):
#def file_write(ruta, text=None):
#def file_read(ruta):
#def file_append():
#def get_point():
#def load_json_packages_path(*lista):
#def file_read_packages_path(*lista):
#def get_word(step=0):
#def get_back_word():
#def get_next_word():
#def is_point():
#def get_back_module():pass
#def put_cursor(cadena):
#def get_character():
#def get_views():
#def get_views_text():
#def get_views_words():
#def sort(l, cmp=None, reverse=False):
#def get_last_word():
#def get_line():
#def get_last_character():
#def clean_file_java(text):
#def clean(text, begin, end):
#def get_java_members(ruta):
#def replaceForSelection():pass
#def get_ext_by_lang(lang):
#def get_project_type():
#def get_file_package(args={}):
#def get_prefix_project_package():
#def set_text(text, args={}):
#def __init__(self, escape="\", encloses=None, dictEncloses=None, breakers=None, ignores=None):pass
#def __init__(self):pass
#def getObjectFunctions():
#def __init__(self, args={}):
#def package(self):
#def clase(self):
#def __init__(self, args={}):
#def package(self):return self.archivo.package()
#def clase(self):return self.archivo.clase()
#def View():
#def Window():
#def get_data_path(ruta=None):
#def get_word_signature():
#def is_method():
#def get_line_of_point(point):
#def create_folder_if_not_exist(ruta):
#def create_json_if_not_exist(ruta):
#def get_package():
#def agregarCursores(texto):
#def get_reference_page():
