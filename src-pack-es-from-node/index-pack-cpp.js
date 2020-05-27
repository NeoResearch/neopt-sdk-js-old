"use strict";
// Neo3 cpp library (from node to web)

// following this example (node + webpack)
// https://gist.github.com/surma/b2705b6cca29357ebea1c9e6e15684cc

import Neo3CppLibNode from '../build/neopt-lib-cpp-node/neopt-lib-cpp-node.js';
import Neo3CppLibNodeWasm from '../build/neopt-lib-cpp-node/neopt-lib-cpp-node.wasm';

// Since webpack will change the name and potentially the path of the 
// `.wasm` file, we have to provide a `locateFile()` hook to redirect
// to the appropriate URL.
// More details: https://kripken.github.io/emscripten-site/docs/api_reference/module.html
const mymodule = Neo3CppLibNode({
  locateFile(path) {
    if(path.endsWith('.wasm')) {
      return Neo3CppLibNodeWasm;
    }
    return path;
  }
});

mymodule.onRuntimeInitialized = () => {
    console.log(mymodule._mytest(10));
  };

//const CppModule = require('neopt-lib-cpp-node');
const csbig = require('csbiginteger');
const CryptoJS = require('crypto-js');

function test(x)
{
    return x+1;
}

//CppModule._mytest(10); // Runtime not ready...

module.exports = {
    //CppModule, // emscripten Module
    mymodule,
    CryptoJS,
    test,
    csbig
}

