// module.exports = {
//   debug: true,
//   entry: './app/javascript/coffee',
//   loaders: [
//     //{ test: /\.(png|jpg)$/, loader: 'url-loader?limit=8192'},
//     //{ test: /\.css$/, loader: 'style!css' },
//     { test: /\.coffee$/, loader: 'coffee' }
//   ],
//   resolve: {
//     // you can now require('file') instead of require('file.coffee')
//     extensions: ['', '.js', '.json', '.coffee']
//   },
//   output: {
//     filename: 'bundle.js'
//   }
// }

module.exports = {
  module: {
    rules: [
      {
        test: /\.coffee$/,
        loader: 'coffee-loader',
      },
    ],
  },
};