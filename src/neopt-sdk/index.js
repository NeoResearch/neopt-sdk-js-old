"use strict";
// Neo3 Portable for all Things (neopt) SDK in Javascript

const Neo3 = require('./Neo3').Neo3;
//import Neo3 from './Neo3';


const csbig = require('csbiginteger');
const CryptoJS = require('crypto-js');

const CppModule = require('../../build/neopt-lib-cpp-node/neopt-lib-cpp-node');

const cppFunc = require('../../build/neopt-lib-cpp-node/neopt-lib-cpp-node').cpp_SmartContract_Contract_CreateSignatureRedeemScript;
const cppFunc2 = require('../../build/neopt-lib-cpp-node/neopt-lib-cpp-node').cpp_SmartContract_Contract_CreateSignatureRedeemScript2;

//console.log("MODULE:"+CppModule);
//console.log("FUNC: "+CppModule._mytest);
//CppModule._mytest(1);

module.exports = {
  Neo3,
  CppModule, // emscripten Module
  CryptoJS,
  cppFunc, // function
  cppFunc2, // function
  csbig
}

