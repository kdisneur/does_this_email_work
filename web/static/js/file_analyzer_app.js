var Actions        = require("./actions/emails");
var React          = require("react/lib/React");
var EmailFileInput = require("./components/email_file_input");
var EmailsList     = require("./components/emails_list");
var Store          = require("./stores/emails");
var _              = require("lodash");

module.exports = React.createClass({
  getInitialState: function() {
    return {
      results: Store.getResults(),
    };
  },

  componentDidMount: function() {
    Store.addChangeListener(this._onNewAnalyze);
  },

  render: function() {
    return <div className="row">
      <div className="small-12 medium-offset-3 medium-6 columns text-center">
        { this.state.results.length == 0 ?
            <EmailFileInput onEmailsLoaded={this._onEmailsLoaded} />
          :
            ""
        }
      </div>
      <div className="small-12 columns">
        { this.state.results.length > 0 ?
            <EmailsList results={this.state.results} />
          :
            ""
        }
      </div>
    </div>;
  },

  _onEmailsLoaded: function(emails) {
    Actions.analyze(emails);
  },

  _onNewAnalyze: function() {
    this.setState({ results: Store.getResults() });
  }
});
