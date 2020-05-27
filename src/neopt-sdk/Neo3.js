

(function(exports) {
"use strict";

// storing internal information on javascript BN library
//const BN = require('bn.js');
//
// load neo3-cpp-core library dependency (wasm)
let libNeo3cpp = require('neopt-lib-cpp-node');

//
// "injecting" modules (TODO: improve)
//
/*
const lt_bn = require('bn.js');
libNeo3['BN'] = lt_bn.BN; 
const lt_csbn = require('csBigInteger.js');
libNeo3['csBN'] = lt_csbn.csBigInteger;
let lt_cryptojs = require('crypto-js');
libNeo3['CryptoJS'] = lt_cryptojs;
*/
//


// function utils
function assert(val, msg) {
	if (!val) throw new Error(msg || 'Assertion failed');
}

function Neo3(n) {

}

Neo3.Contract_CreateSignatureRedeemScript = function (jsonStr) {
	return jsonStr;
	//return libNeo3cpp.cpp_SmartContract_Contract_CreateSignatureRedeemScript(jsonStr);
};

exports.Neo3 =  Neo3;
})(typeof exports !== 'undefined' ? exports : this);


