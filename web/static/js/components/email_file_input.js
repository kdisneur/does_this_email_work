var React           = require("react/lib/React");
var FileReaderInput = require("react-file-reader-input");
var _               = require("lodash");

module.exports = React.createClass({
  render: function() {
    return <form>
      <FileReaderInput as="text"
                       id="plop"
                       onChange={this._onFileChange}>
        <a href="#" className="button">Import a file</a>
      </FileReaderInput>
    </form>;
  },

  _onFileChange: function(e, result) {
    var progressEvent = result[0][0];
    var rawEmails     = progressEvent.target.result;
    var emails        = _.compact(rawEmails.split("\n"));

    this.props.onEmailsLoaded(emails);
  }
});
