import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// Added for bootstrap support --START SCSS
// other scss files and partials are included in those two file application.scss, main.scss
import "bootstrap";

// import 'bootstrap/js/dist/util';
// import 'bootstrap/js/dist/dropdown';

// import "../../stylesheets/application"
// import "../../stylesheets/main"
// Added for bootstrap support --END

// This is added by the stimulus install
import "controllers"
// command (bundle exec rails webpacker:install:stimulus)

// custom Javascript import
import "./validate_email"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


console.log('This is generated from Webpacker for React')
// Support component names relative to this directory:
//Added by rails generate react:install
var ReactRailsUJS = require("react_ujs");
var componentRequireContext = require.context("components", true);
ReactRailsUJS.useContext(componentRequireContext);
