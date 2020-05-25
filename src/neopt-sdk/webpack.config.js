module.exports = {
  mode : 'production',
  entry : './index.js',
  output: {
    library: 'neopt-sdk',
    libraryTarget: 'umd',
    filename: './Neo3.js',
    auxiliaryComment: 'Neo3 (Portable for all Things) SDK library'
  }
};
