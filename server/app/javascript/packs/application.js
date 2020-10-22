// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// This file is the entry point for webpack, which means webpack first look in this
// file. So, the 'application' pack is the entry point of all of our JavaScript files
// We can create custom packs and palce them in the app/javascript/packs directory
// and webpacker will find them easily while compiling. and this setting is
// configured in 'config/webpacker.yml'.

// Rails frameworks which have JavaScript components such as Rails-UJS,
// Turbolinks, ActiveStorage are migrated to support webpacker

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap"
import "underscore" //👈🏻 Step 6: Add this 
import "../stylesheets/application"
import "./question"

import "./selectize"
import "./payments.js.erb"
//Important: rails g gmaps4rails:copy_js after running this command in terminal move your  'gmaps_google.js' to javascript/packs/ folder
import Gmaps from "./gmaps_google" //👈🏻 Step 6: Add this 
window.jQuery = $;
window.$ = $;



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

console.log("Hello from app/javascript/packs/application.js")