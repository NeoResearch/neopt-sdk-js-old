//let csbiginteger = lt_csbn;

//let lNeo3 = require('./build/librarytest');
let lNeo3 = require('neopt-lib-node-cpp');
// c function needs wrapping... cpp don't!
var myteststr = lNeo3.cwrap('myteststr', 'string', ['string', 'number']);

let SDK = require('./src/neopt-sdk/index.js');

let csBN = require('csbiginteger').csBigInteger;

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
    console.log("");
    console.log("TEST1");
    var vout = lNeo3.cpp_SmartContract_Contract_CreateSignatureRedeemScript(strJson);
    console.log(vout);
    //
    // Using SDK 'Neo3'
    console.log("");
    console.log("TEST2 (SDK testing)");
    var vout2 = SDK.Neo3.Contract_CreateSignatureRedeemScript(strJson);
    console.log(vout2);

}

// ----------- wait until loading ----------

setTimeout(function () {
    testMain()
}, 500);
