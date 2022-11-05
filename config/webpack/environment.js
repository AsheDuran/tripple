const { environment } = require('@rails/webpacker')

module.exports = environment

const webpack = require('webpack')//BootStrapの際に記述
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)