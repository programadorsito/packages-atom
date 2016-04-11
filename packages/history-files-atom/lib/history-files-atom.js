'use babel';

var utils=require("utils-atom");

import { CompositeDisposable } from 'atom';

module.exports= {

  subscriptions: null,

  activate(state) {
    atom.commands.emitter.on("historia archivos", module.exports.mostrar);
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
    list=utils.load_json("D:/atom/packages/packages/history-files-atom/data/history_files.json");
    utils.show_list(list, function(item) {
      atom.workspace.open(item);
    });
  }
};
