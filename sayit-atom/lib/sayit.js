'use babel';

var utils=require("./utils-atom");

import { CompositeDisposable } from 'atom';

export default {

  subscriptions: null,

  activate(state) {
    this.subscriptions = new CompositeDisposable();

    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'sayit:toggle': () => this.toggle()
    }));
  },

  deactivate() {
  },

  serialize() {
  },

  toggle() {
    console.log("va a insertar");
    utils.hear(function (text){
      console.log("el texto insertado  es : "+text);
      utils.insert_text(text);
    });
  },

  otra(){
    console.log("que mierda es esto");
  }

};
