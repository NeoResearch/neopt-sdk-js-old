module.exports = {
  mode : 'production',
  entry : './src/neopt-sdk/index.js',
  output: {
    library: 'neopt',
    libraryTarget: 'umd',
    filename: 'neopt-sdk.js',
    auxiliaryComment: 'Neo3 (Portable for all Things) SDK library'
  },
  node: {
    fs: "empty"
  },
  externals :  {
    'neopt-lib-cpp' : 'NeoptLib'
  }
};
