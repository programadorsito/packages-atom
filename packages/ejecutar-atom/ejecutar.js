'use babel';

var path=require("path"); 
var fs=require("fs"); 
var child_process=require("child_process"); 

import { CompositeDisposable } from 'atom';

export default {
  subscriptions: null,
  activate(state) {
    this.subscriptions = new CompositeDisposable();
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'ejecutar-atom:ejecutar': () => this.ejecutar()
    }));
  },
  deactivate() {},
  serialize() {},
  ejecutar(){
    lang=atom.workspace.getActiveTextEditor().getGrammar().name;
    lang=lang.toLowerCase();
    ruta=atom.workspace.getActiveTextEditor().getPath();
    dir=path.dirname(ruta);
    console.log("el dir es : "+dir);
    fullname=path.basename(ruta);
    name=fullname.substring(0,fullname.lastIndexOf());
    process.chdir(dir);
    comandos={
      "c":`gcc ${fullname} -o ${name}`, 
      "python":`python ${ruta}`,
      "java":`java ${name}`,
      "go":`go run ${ruta}`,
      "ruby":`ruby ${ruta}`
    };
    comando=comandos[lang];
    console.log(comando);
    this.ejecutarComando(comando);
  },

  ejecutarComando(comando){
    rutaArchivo=path.join(path.dirname(path.dirname(__filename)), "ejecutar.bat");
    comando="@echo off\n"+comando+"\npause>nul";
    fs.writeFileSync(rutaArchivo, comando);
    child_process.exec("start "+rutaArchivo);
  }
};
