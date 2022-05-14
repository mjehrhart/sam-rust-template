const crypto = require('crypto');

const THINGS = [
  "A", "B", "C", "D", "E", "F", "G", "H",
  "I", "J", "K", "L", "M", "N", "O", "P",
  "Q", "R", "S", "T", "U", "V", "W",
  "X", "Y", "Z",
];

const NUMBER_STRINGS = [
  "1", "2", "3", "4", "5", "6", "7",
  "8", "9", "10", "11", "12", "13", "14",
  "15", "16", "17", "18", "19", "20",
];

module.exports = {
  generateProduct: function(context, events, done) {
    const things = THINGS[Math.floor(Math.random() * THINGS.length)];
    const number_strings = NUMBER_STRINGS[Math.floor(Math.random() * NUMBER_STRINGS.length)];

    context.vars.id = crypto.randomUUID();
    context.vars.things =  `${things}`;
    context.vars.price = Math.round(Math.random() * 10000) / 100;

    return done();
  },
};