

(function(exports) {
"use strict";

// storing internal information on javascript BN library
//const BN = require('bn.js');
//
// load neo3-cpp-core library dependency (wasm)
const libNeo3 = require('neopt-lib-cpp');

// function utils
function assert(val, msg) {
	if (!val) throw new Error(msg || 'Assertion failed');
}

function Neo3(n) {
}

exports.Neo3 =  Neo3;
})(typeof exports !== 'undefined' ? exports : this);


