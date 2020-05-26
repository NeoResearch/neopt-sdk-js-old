//let csbiginteger = lt_csbn;

//let lNeo3 = require('./build/librarytest');
let lNeo3 = require('neopt-lib-node-cpp');
// c function needs wrapping... cpp don't!
var myteststr = lNeo3.cwrap('myteststr', 'string', ['string', 'number']);

// loading BigNum module
let lt_csbn = require('./thirdparty/neo3-cpp-core/libs/lib/node_modules/csBigInteger.js/csBigInteger.js');
let lt_bn = require('./thirdparty/neo3-cpp-core/libs/lib/node_modules/bn.js/lib/bn.js');
let lt_cryptojs = require('./thirdparty/neo3-cpp-core/libs/lib/node_modules/crypto-js/crypto-js.js');

lNeo3['BN'] = lt_bn.BN; // "injecting" module
lNeo3['csBN'] = lt_csbn.csBigInteger;
lNeo3['CryptoJS'] = lt_cryptojs;

let csBN = lt_csbn.csBigInteger;


function testMain() {
    console.log(" ======== testMain() ====== ");

    // =============
    console.log("");
    console.log("experimenting with ECPoint");
    console.log("");
    //

    var vx = new csBN("43563478194357645732161043749214420341576583724275881899443933055754116882936", 10);
    var vy = new csBN("6800198406926458502571476951697947402787919362010374841430910815761615021861", 10);
    //console.log(vx);
    //console.log(vy);
    var ecpoint = {
        "X" : vx.toHexString(),
        "Y" : vy.toHexString(),
        "curve" : "secp256r1"
    };
    var strJson = JSON.stringify(ecpoint);
    console.log("json str point: "+strJson);
    var vout = lNeo3.cpp_SmartContract_Contract_CreateSignatureRedeemScript(strJson);
    console.log(vout);

}

// ----------- wait until loading ----------

setTimeout(function () {
    testMain()
}, 500);
