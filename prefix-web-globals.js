// prefix-web.js
/*
define(function() {
  return function(Module) {
*/

// for global "polluted" browser version
// we must load <script> ... </script> the csBigInteger.js and crypto-js BEFORE this
// -------------
console.log("prefix: will need csbiginteger now...");
Module["csBN"] = csbiginteger.csBigInteger;
console.log("prefix: will need CryptoJS now...");
Module["CryptoJS"] = CryptoJS;