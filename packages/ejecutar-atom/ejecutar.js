'use babel';

var path=require("path"); 
var child_process=require("child_process"); 

import { CompositeDisposable } from 'atom';

export default {
  subscriptions: null,
  activate(state) {
    console.log("se activo el modulo de ejecucion y se cambio este mensaje por ese otro");
    this.subscriptions = new CompositeDisposable();
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'ejecutar-atom:ejecutar': () => this.ejecutar()
    }));
  },

  deactivate() {
  },

  serialize() {
  },

  ejecutar(){
    lang=atom.workspace.getActiveTextEditor().getGrammar().name;
    lang=lang.toLowerCase();
    path=atom.workspace.getActiveTextEditor().getPath();
    dir=path.dirname(path);
    fullname=path.basename(path);
    name=fullname.substring(0,fullname.lastIndexOf());
    process.chdir(dir);
    comandos={"c":"gcc "+fullname+" -o "+name, "python":"python "+path};
    comando=comandos[lang];
    console.log(comando);
    child_process.exec("start "+comando);    
  }
};
