'use babel';

var utils=require("./utils-atom");

import { CompositeDisposable } from 'atom';

export default {

  subscriptions: null,
  
  activate(state) {
    this.subscriptions = new CompositeDisposable();
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'voicecommand-atom:interpretar': () => this.interpretar()
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
  }
};
