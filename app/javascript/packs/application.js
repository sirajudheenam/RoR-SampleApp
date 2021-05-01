// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.



import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// Added for bootstrap support --START SCSS
import "bootstrap"
import "../stylesheets/application"
import "../stylesheets/main"
// Added for bootstrap support --END

// This is added by the stimulus install 
import "controllers"
// command (bundle exec rails webpacker:install:stimulus)

// Javascript import
import "./validate_email"
// Javascript import

//CoffeeScript import
import "coffee"

// import "coffeescript/register"
// WARNING in ./node_modules/coffeescript/lib/coffee-script/register.js 15:6-24
// require.extensions is not supported by webpack. Use a loader instead.
// require('coffee')




Rails.start()
Turbolinks.start()
ActiveStorage.start()