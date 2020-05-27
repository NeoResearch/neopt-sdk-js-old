"use strict";
// Neo3 Portable for all Things (neopt) SDK in Javascript

const Neo3 = require('./Neo3').Neo3;
//import Neo3 from './Neo3';


const csbig = require('csbiginteger');

const CppModule = require('neopt-lib-node-cpp');

const cppFunc = require('neopt-lib-node-cpp').cpp_SmartContract_Contract_CreateSignatureRedeemScript;
const cppFunc2 = require('neopt-lib-node-cpp').cpp_SmartContract_Contract_CreateSignatureRedeemScript2;

//console.log("MODULE:"+CppModule);
//console.log("FUNC: "+CppModule._mytest);
//CppModule._mytest(1);

module.exports = {
  Neo3,
  CppModule, // emscripten Module
  cppFunc, // function
  cppFunc2, // function
  csbig
}

