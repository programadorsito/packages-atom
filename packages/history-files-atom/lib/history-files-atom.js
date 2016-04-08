'use babel';

var utils=require("utils-atom");

import { CompositeDisposable } from 'atom';



export default {

  subscriptions: null,

  activate(state) {
    console.log("haciendo lo posible porque se den las cosas");
    this.subscriptions = new CompositeDisposable();

    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'history-files-atom:mostrar': () => this.mostrar()
    }));
  },

  deactivate() {
  },

  serialize() {
  },

  mostrar() {
    console.log("historia de archivos");
  }
};
