require("../css/app.scss");
require("file?name=[name].[ext]!font-awesome/fonts/FontAwesome.otf");
require("file?name=[name].[ext]!font-awesome/fonts/fontawesome-webfont.eot");
require("file?name=[name].[ext]!font-awesome/fonts/fontawesome-webfont.svg");
require("file?name=[name].[ext]!font-awesome/fonts/fontawesome-webfont.ttf");
require("file?name=[name].[ext]!font-awesome/fonts/fontawesome-webfont.woff");
require("file?name=[name].[ext]!font-awesome/fonts/fontawesome-webfont.woff2");
jquery = require("jquery");

(function($) {
  $(document).ready(function() {
    $(".m-try-out--button-js").click(function(e) {
      $(e.target).parents("form").submit();
    });
    $(".m-try-out--callback-js").click(function(e) {
      $(".m-try-out--focus-field-js").focus();
    });

    var fileAnalyzerAppDOM = $(".m-file-analyzer-app-js");
    if (fileAnalyzerAppDOM.length > 0) {
      var React    = require("react/lib/React");
      var ReactDOM = require("react/lib/ReactDOM");

      var FileAnalyzerApp = require("./file_analyzer_app");
      ReactDOM.render(<FileAnalyzerApp />, fileAnalyzerAppDOM[0]);
    }
  });
})(jquery);
