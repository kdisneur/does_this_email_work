module.exports = {
  entry: "./web/static/js/app.js",
  output: {
    path: "./priv/static/js",
    filename: "bundle.js"
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style!css" },
      { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" },
      { test: /\.scss$/,
        loader: "style!css!sass-loader?" +
          "includePaths[]=" +
            (__dirname + "/node_modules") + "&" +
          "includePaths[]=" +
            (__dirname + "/node_modules/compass-mixins/lib")
      }
    ]
  }
};
