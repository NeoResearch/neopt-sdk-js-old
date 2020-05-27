"use strict";
// Neo3 cpp library (from node to web)

const CppModule = require('neopt-lib-cpp-node');
const csbig = require('csbiginteger');
const CryptoJS = require('crypto-js');

function test(x)
{
    return x+1;
}

module.exports = {
    CppModule, // emscripten Module
    CryptoJS,
    test,
    csbig
}

