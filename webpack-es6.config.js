const EsmWebpackPlugin = require("@purtuga/esm-webpack-plugin");
module.exports = {
  mode : 'production',
  entry : './src/neopt-sdk/index.js',
  output: {
    library: 'neopt',
    libraryTarget: 'var',
    filename: 'neopt-sdk-es6.mjs',
    auxiliaryComment: 'Neo3 (Portable for all Things) SDK library'
  },
  node: {
    fs: "empty"
 },
  plugins: [
    new EsmWebpackPlugin()
  ]

};
