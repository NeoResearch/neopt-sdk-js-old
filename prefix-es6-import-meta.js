// Prefix-node.js for loading dependent libraries with backup
// this works for Node (CommonJS) versions (that have "require()")
/*
define(function() {
    return function(Module) {
        */

//import csbiginteger from "https://unpkg.com/csbiginteger/dist/csbiginteger-es6.mjs";
//import CryptoJS from 'crypto-js';

//Module["csBN"] = csbiginteger.csBigInteger;
//Module["CryptoJS"] = CryptoJS;


// some prefer: var _scriptDir = (typeof document !== 'undefined' && document.currentScript) ? document.currentScript.src : undefined;
// over: var _scriptDir = import.meta.url;