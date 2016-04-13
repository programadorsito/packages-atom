'use babel';
var path=require("path"); 
var child_process=require("child_process"); 
var utils=require("utils-atom");

import { CompositeDisposable } from 'atom';

rutaArchivo=path.join(path.dirname(__filename), "..", "data", "comandos.json");

export default {
  REGEX_VAR: /@[\w]+/, 
  subscriptions: null,
  comando_actual: null,
  activate(state) {
    this.subscriptions = new CompositeDisposable();
    this.activarComandos();

    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'voicecommand-atom:interpretar': () => this.interpretar()
    }));

    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'voicecommand-atom:crearComando': () => this.crearComando()
    }));
  },

  deactivate() {
  },

  serialize() {
  },

  interpretar() {
    utils.hear(function (text){
      if(text){
        text=text.toLowerCase();
        console.log("el comando es : "+text);
        utils.run_command(text);
      }
    });
  },

  activarComandos(){
    console.log("va a activar los comandos");
    comandos=utils.load_json(rutaArchivo);
    keys=Object.keys(comandos);
    for(var i=0;i<keys.length;i++){
      var key=keys[i];
      var comando=comandos[key].replace("", "");
      this.encolarComando(key, comando);
    }
  },

  encolarComando(key, comando){
    objecto={};
    objecto[key]= () => this.procesarYEjecutarComando(comando);
    this.subscriptions.add(atom.commands.add('atom-workspace', objecto));
  },

// Ejecutar comando  
// $dir
// $path
// $name
// $fullname
  ejecutarComando(comando){
    if(comando){
      project_path = directorioChdir=atom.project.getPaths()[0];
      file_path = atom.workspace.getActiveTextEditor().getPath();
      file_fullname = path.basename(file_path)
      file_name = file_fullname.substring(0,file_fullname.indexOf("."));
      comando = comando.replace("$dir", project_path).replace("$path", file_path).replace("$name", file_name);
      directorioChdir=null;
      if(comando.indexOf("^")!=-1){
        comando = comando.replace("^", "");
        if(atom.project.getPaths() && atom.project.getPaths()[0]){
          directorioChdir=atom.project.getPaths()[0];
        }
      }else{
        if(atom.workspace.getActiveTextEditor().getPath()){
          directorioChdir=path.dirname(atom.workspace.getActiveTextEditor().getPath());
        }
      }
      if(directorioChdir){
        process.chdir(directorioChdir);
      }
      console.log(comando);
      child_process.exec("start "+comando);
    }
  },

  crearComando(){
    utils.input_dialog(function(comando){
      comandos=utils.load_json(rutaArchivo);
      comando = comando.split(";");
      comandos[comando[1]]=comando[0];
      utils.save_json(rutaArchivo, comandos);
      key=comando[1];
    });
  },

  procesarComando(valor){
    matches = this.comando_actual.match(this.REGEX_VAR);
    if (matches)this.comando=this.comando_actual.replace(matches[0], valor);
    matches = this.comando_actual.match(this.REGEX_VAR);
    if(matches){
      utils.input_dialog(this.procesarComando);
    }else{
      this.ejecutarComando(this.comando_actual);
    }
  },

  procesarYEjecutarComando(comando){
    if(comando){
      this.comando_actual=comando;
      if(comando.indexOf("@")!=-1)utils.input_dialog(this.procesarComando);
      else this.ejecutarComando(comando)
    }
  },

  fijarComandoActual(comando){
    this.comando_actual=comando;
  }
};
