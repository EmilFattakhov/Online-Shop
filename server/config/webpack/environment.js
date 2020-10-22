// Here, the default webpack configuration is imported via @rails/webpacker
const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

const webpack = require('webpack')
// Add 'const jQuery = require('jquery') to legacy jQuery plugins and
// const popper = require('popper')
// and also set window.$ = require('jquery')

environment.plugins.append(
    "Provide",
    new webpack.ProvidePlugin({
        $: "jquery",
        jQuery: "jquery",
        Popper: ["popper.js", "default"]
    })
)

environment.loaders.prepend('erb', erb)
module.exports = environment
