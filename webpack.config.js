module.exports = {
  mode : 'production',
  entry : './src/neopt-sdk/index.js',
  output: {
    library: 'neopt-sdk',
    libraryTarget: 'umd',
    filename: './src/neopt-sdk/Neo3.js',
    auxiliaryComment: 'Neo3 (Portable for all Things) SDK library'
  }
};
