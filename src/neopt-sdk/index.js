// Neo3 Portable for all Things (neopt) SDK in Javascript

const Neo3 = require('./Neo3').Neo3;
//import Neo3 from './Neo3';


const csbig = require('csbiginteger');

const CppModule = require('neopt-lib-node-cpp');

//console.log("MODULE:"+CppModule);
//console.log("FUNC: "+CppModule._mytest);
//CppModule._mytest(1);

module.exports = {
  Neo3,
  CppModule, // emscripten Module
  csbig
}

