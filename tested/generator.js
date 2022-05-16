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
  generate_test_data: function(context, events, done) {
    
    const number_strings = NUMBER_STRINGS[Math.floor(Math.random() * NUMBER_STRINGS.length)];

    context.vars.id = number_strings;

    return done();
  },
};