'use babel';
utils = require("./utils-atom")

import { CompositeDisposable } from 'atom';

export default {

  subscriptions: null,

  activate(state) {
    this.subscriptions = new CompositeDisposable();

    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'my-package:toggle': () => this.toggle()
    }));
  },

  deactivate() {
  },

  serialize() {
  },

  toggle() {
    utils.show_list(["daniel", "alejandro", "molina", "yepes"], function (item) {
      console.log("este es el otro "+item);
    });
  },
};
