module.exports = {
  entry: "./web/static/js/app.js",
  output: {
    path: "./priv/static/assets/",
    filename: "bundle.js"
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style!css" },
      { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader",  query: { presets:['react'] } },
      { test: /\.scss$/,
        loader: "style!css!sass-loader?" +
          "includePaths[]=" +
            (__dirname + "/node_modules") + "&" +
          "includePaths[]=" +
            (__dirname + "/node_modules/compass-mixins/lib")
      },
      { test: /\.(ttf|eot|svg|woff2?)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "file-loader" }
    ]
  }
};
