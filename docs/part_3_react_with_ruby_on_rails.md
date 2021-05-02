# Part - 3: Ruby-On-Rails App with React

Add `react-rails` gem to your Gemfile.

Make sure you have inserted latest `react-rails` gem by checking on [RubyGems](rubygems.org) site.

At the time of writing this guide (2 May 2021), it is '2.6.1'.

```
gem 'react-rails', '~> 2.6.1'

bundle install

# Verify it is installed.
gem list --local | grep react-rails
gem info react-rails

```

Try this first 

X 
```bash
cat <<'EOF' >>.babelrc 
{ "presets": ["@babel/env", "@babel/preset-react"] }
EOF

Trying: 
{ "presets": [ "@babel/preset-env", "@babel/preset-react" ] }

```
npm install --save react react-dom
npm install --save-dev @babel/preset-react
npm install --save prop-types


Make sure you have this `babel.config.js` at root of your directory, watch out for `presets` contains `preset-react`.

```js
module.exports = function(api) {
  var validEnv = ['development', 'test', 'production']
  var currentEnv = api.env()
  var isDevelopmentEnv = api.env('development')
  var isProductionEnv = api.env('production')
  var isTestEnv = api.env('test')

  if (!validEnv.includes(currentEnv)) {
    throw new Error(
      'Please specify a valid `NODE_ENV` or ' +
        '`BABEL_ENV` environment variables. Valid values are "development", ' +
        '"test", and "production". Instead, received: ' +
        JSON.stringify(currentEnv) +
        '.'
    )
  }

  return {
    presets: [
      isTestEnv && [
        '@babel/preset-env',
        {
          targets: {
            node: 'current'
          },
          modules: 'commonjs'
        },
        '@babel/preset-react'
      ],
      (isProductionEnv || isDevelopmentEnv) && [
        '@babel/preset-env',
        {
          forceAllTransforms: true,
          useBuiltIns: 'entry',
          corejs: 3,
          modules: false,
          exclude: ['transform-typeof-symbol']
        }
      ],
      [
        '@babel/preset-react',
        {
          development: isDevelopmentEnv || isTestEnv,
          useBuiltIns: true
        }
      ]
    ].filter(Boolean),
    plugins: [
      'babel-plugin-macros',
      '@babel/plugin-syntax-dynamic-import',
      isTestEnv && 'babel-plugin-dynamic-import-node',
      '@babel/plugin-transform-destructuring',
      [
        '@babel/plugin-proposal-class-properties',
        {
          loose: true
        }
      ],
      ["@babel/plugin-proposal-private-methods", 
        { 
          "loose": true 
        }
      ],
      [
        '@babel/plugin-proposal-object-rest-spread',
        {
          useBuiltIns: true
        }
      ],
      [
        '@babel/plugin-transform-runtime',
        {
          helpers: false
        }
      ],
      [
        '@babel/plugin-transform-regenerator',
        {
          async: false
        }
      ]
    ].filter(Boolean)
  }
}

```




Make sure you have webpack already installed. Else refer part_1 of this guide series.

Let us bootstrap the `react` by invoking `rails generate` command.

```
rails generate react:install

```

Let us inpsect the output:

```
Running via Spring preloader in process 30301
      create  app/javascript/components
      create  app/javascript/components/.keep
      append  app/javascript/packs/application.js
      create  app/javascript/packs/server_rendering.js
```

It created a directory `app/javascript/components` and a file `app/javascript/packs/server_rendering.js`

It also appended the file `app/javascript/packs/application.js` which was created by the `stimulus.js` from part 1 of this guide series.

Let us look at the file `app/javascript/packs/application.js`

```
less app/javascript/packs/application.js

# these three lines were added to existing file

// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);

```


Let us look at the `package.json` file 

```bash
git diff package.json
diff --git a/package.json b/package.json
index b87956d..9da5fd4 100644
--- a/package.json
+++ b/package.json
@@ -11,6 +11,7 @@
     "coffeescript": "1.12.7",
     "jquery": "^3.6.0",
     "popper.js": "^1.16.1",
+    "react_ujs": "^2.6.1",
     "stimulus": "^2.0.0",
     "turbolinks": "^5.2.0",
     "webpack": "^4.46.0",
```

It just added this line `"react_ujs": "^2.6.1",`.



Let us create a Component using `rails generate` command

rails g react:component Post title:string published:bool

Insert this at `home/index.html.erb` file

```
<h3> <%= react_component("MiniPost", { title: "Tamil Language.", published: true, publishedBy: "user1"}) %> </h3>
```


