# Part 5 - CoffeeScript with Rails 6

Webpacker requires these npm packages to process CoffeeScript files.

Add this snippet to your `package.json`file

```json
	"coffee-loader": "0.9.0",
	"coffeescript": "1.12.7",

# Add alias
	  "_moduleAliases": {
        "coffee-script": "node_modules/coffeescript/lib/coffeescript"
    }
```

# https://webpack.js.org/loaders/coffee-loader/

## Doesn't work
cat <<'EOF' >> webpack.config.js
module.exports = {
  module: {
    rules: [
      {
        test: /\.coffee$/,
        loader: 'coffee-loader',
        options: {
          transpile: {
            presets: ['@babel/env'],
          },
        },
      },
    ],
  },
};
EOF


## Loader
cat <<'EOF' >> webpack.config.js
module.exports = {
  debug: true,
  entry: './app/javascript/coffee',
  loaders: [
    //{ test: /\.(png|jpg)$/, loader: 'url-loader?limit=8192'},
    //{ test: /\.css$/, loader: 'style!css' },
    { test: /\.coffee$/, loader: 'coffee' }
  ],
  resolve: {
    // you can now require('file') instead of require('file.coffee')
    extensions: ['', '.js', '.json', '.coffee']
  },
  output: {
    filename: 'bundle.js'
  }
}
EOF
