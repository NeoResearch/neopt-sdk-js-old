/**
 * Copyright 2018 Google Inc. All Rights Reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import ourtest from './ourtest.js';
import ourtestWasm from './ourtest.wasm';



// Since webpack will change the name and potentially the path of the 
// `.wasm` file, we have to provide a `locateFile()` hook to redirect
// to the appropriate URL.
// More details: https://kripken.github.io/emscripten-site/docs/api_reference/module.html
const mymodule = ourtest({
  locateFile(path) {
    if(path.endsWith('.wasm')) {
      return ourtestWasm;
    }
    return path;
  }
});

export const myfib = mymodule._fib;

mymodule.onRuntimeInitialized = () => {
  console.log(mymodule._fib(12));
};


//export const Neo3 = require('../src/neopt-sdk/Neo3').Neo3; // THIS CRASHES!!
export const csbig = require('csbiginteger');
export const CryptoJS = require('crypto-js');
//const CppModule = require('../../build/neopt-lib-cpp-node/neopt-lib-cpp-node');
// Can't resolve 'env' in '/home/imcoelho/git-reps/neopt-sdk-js/build/neopt-lib-cpp-node'
//const cppFunc = require('../build/neopt-lib-cpp-node/neopt-lib-cpp-node').cpp_SmartContract_Contract_CreateSignatureRedeemScript;
//const cppFunc2 = require('../build/neopt-lib-cpp-node/neopt-lib-cpp-node').cpp_SmartContract_Contract_CreateSignatureRedeemScript2;


//module.exports = {
  //Neo3,
  //CppModule, // emscripten Module

  //CryptoJS,
  //myfib,
  
  //cppFunc, // function
  //cppFunc2, // function

  //csbig
//}


// THIS IS A ES6 MODULE... NO MORE 'module.exports' HERE!!!
// ONLY USE: 'export bla bla bla...'