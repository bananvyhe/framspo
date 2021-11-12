// const { dev_server: devServer } = require('@rails/webpacker').config

// const isProduction = process.env.NODE_ENV === 'production'
// const inDevServer = process.argv.find(v => v.includes('webpack-dev-server'))
// const extractCSS = !(inDevServer && (devServer && devServer.hmr)) || isProduction
module.exports = {
      // SASS has different line endings than SCSS
      // and cannot use semicolons in the markup
      // SCSS has different line endings than SASS
      // and needs a semicolon after the import.
       
        test: /\.scss$/,
        use: [
          'vue-style-loader',
             
          {
            loader: 'sass-loader',
     
            // Requires sass-loader@^8.0.0
            options: {
              // implementation: require('sass'),

              // This is the path to your variables
                // additionalData: "@import '@/app/javascript/stylesheets/scss/_variables.scss';"
            },
       
          },
        ],
       
     
   
}