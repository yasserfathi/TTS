module.exports = {
  "transpileDependencies": [
    "vuetify"
  ],
  chainWebpack: config => {
    config
    .plugin('html')
    .tap(args => {
      args[0].title = 'ترحال'
      return args
    })
  },
  devServer: {
    proxy : {
      "/" : {
        target : "http://127.0.0.1/backend",
        /*headers: {
                Authorization: 'Basic <someBase64EncodedString>',
                Accept: "application/json"
            },
            bypass: function(req, res, proxyOptions) {
              if (req.headers.accept.indexOf('html') !== -1) {
                console.log('Skipping proxy for browser request.');
                return 'public/index.html';
              }
            },*/
      }
    },
    historyApiFallback: true,
  publicPath:'',
},
}