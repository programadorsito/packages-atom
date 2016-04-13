'use babel';
var path=require("path"); 
var fs=require("fs"); 
var child_process=require("child_process"); 
var utils=require("utils-atom");

import { CompositeDisposable } from 'atom';

rutaArchivo=path.join(path.dirname(__filename), "..", "data", "comandos.json");
comando_actual="";


function escribirBatYEjecutar(comando){
  rutaArchivo=path.join(path.dirname(path.dirname(__filename)), "ejecutar.bat");
  comando="@echo off\n"+comando+"\npause>nul"; 
  fs.writeFileSync(rutaArchivo, comando);
  child_process.exec("start "+rutaArchivo);
}

// Ejecutar comando  
// $dir
// $path
// $name
// $fullname
function ejecutarComando(comando){
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
      if(atom.workspace.getActiveTextEditor()){
        directorioChdir=path.dirname(atom.workspace.getActiveTextEditor().getPath());
      }
    }
    if(directorioChdir){
      process.chdir(directorioChdir);
    }
    console.log(comando);
    escribirBatYEjecutar(comando);
  }
}



export default {
  REGEX_VAR: /~[\w]+/, 
  subscriptions: null,
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
    console.log(this);
    matches = comando_actual.match(/~[\w]+/);
    console.log("el comando entro asi : "+comando_actual);
    console.log("los matches son  : "+matches);
    if (comando_actual.indexOf("~")!=-1)comando_actual=comando_actual.replace(matches[0], valor);
    console.log("el comando salio asi : "+comando_actual);
    matches = comando_actual.match(/~[\w]+/);
    if(comando_actual.indexOf("~")!=-1){
      utils.input_dialog(this.procesarComando, matches[0].replace("~", ""));
    }else{
      ejecutarComando(comando_actual);
    }
  },

  procesarYEjecutarComando(comando){
    if(comando){
      comando_actual=comando;
      matches=comando_actual.match(/~[\w]+/);
      if(comando_actual.indexOf("~")!=-1)utils.input_dialog(this.procesarComando, matches[0].replace("~", ""));
      else ejecutarComando(comando)
    }
  },

  fijarComandoActual(comando){
    comando_actual=comando;
  }
};
