rails new rails_app --database=postgresql --webpacker=react

# Add React support to your Rails project
Add `webpacker` and `react-rails` in to your Gemfile.

```
# to install webpacker and react-rails
bundle install

rails webpacker:install

create  config/webpacker.yml
create  config/webpack
create  config/webpack/development.js
create  config/webpack/environment.js
create  config/webpack/production.js
create  config/webpack/test.js
create  postcss.config.js
create  babel.config.js
create  .browserslistrc
create    bin
create    bin/webpack
create    bin/webpack-dev-server

rails webpacker:install:react

Copying babel.config.js to app root directory
   identical  babel.config.js
Copying react example entry file to /Users/i072278/Development/rails/rails_app/app/javascript/packs
   identical  app/javascript/packs/hello_react.jsx
Updating webpack paths to include .jsx file extension
File unchanged! The supplied flag value not found!  config/webpacker.yml
Installing all react dependencies
         run  yarn add react react-dom @babel/preset-react prop-types babel-plugin-transform-react-remove-prop-types from "."
yarn add v1.22.17
....
Webpacker now supports react.js 🎉

rails generate react:install

Running via Spring preloader in process 18403
       exist  app/javascript/components
      create  app/javascript/components/.keep

      append  app/javascript/packs/application.js
      create  app/javascript/packs/server_rendering.js


```
# Setting up ActionCable:

brew install redis
