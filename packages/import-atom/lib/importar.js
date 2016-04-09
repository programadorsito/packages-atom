'use babel';

var utils=require("./utils-atom");

import { CompositeDisposable } from 'atom';

export default {

  subscriptions: null,

  activate(state) {
    this.subscriptions = new CompositeDisposable();
    atom.commands.emitter.on("importar", this.toggle);
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'importar:toggle': () => this.toggle()
    }));
  },

  deactivate() {
  },

  serialize() {
  },

  toggle() {
    var lang=utils.get_language();
    if(!lang)return;
    lang=lang.toLowerCase();
    switch(lang){
      case "java":this.import_java();break;
      case "ruby":this.import_ruby();break;
      case "python":this.import_python();break;
      case "nodejs":this.import_nodejs();break;
      default:break;
    }
  },

  import_js(){
    console.log("quiere importar javascript");
  },

  import_java(){
    clases=[];
    matches=utils.get_matches(/[A-Z][\w]* [\w]+;/g);
    for(var i=0;i<matches.length;i++){
      match=matches[i];
      match=match[0];
      match=match.slice(0,match.indexOf(" "));
      rutaClase=utils.get_first_match("import [\\w.]+\\."+match+";");
      clases.push(rutaClase);
    }
    console.log("las rutas de clase son  : ");
    console.log(clases);
  },

  import_python(){
    console.log("quiere importar python");
  },

  import_nodeJs(){
    console.log("quiere importar nodejs");
  },

  import_ruby(){
    console.log("quiere importar ruby");
  }
};
