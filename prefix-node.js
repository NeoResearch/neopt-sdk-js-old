// prefix.js

// this works for Node (CommonJS) versions (that have "require()")

let lt_csbn = require('csbiginteger');
let lt_cryptojs = require('crypto-js');

Module["csBN"] = lt_csbn.csBigInteger;
Module["CryptoJS"] = lt_cryptojs;

