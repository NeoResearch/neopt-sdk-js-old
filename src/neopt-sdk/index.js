// Neo3 Portable for all Things (neopt) SDK in Javascript

const Neo3 = require('./Neo3').Neo3;

let CppModule = require('neopt-lib-node-cpp');

module.exports = {
  Neo3,
  CppModule // emscripten Module
}

