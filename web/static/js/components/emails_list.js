var React         = require("react/lib/React");
var EmailsSummary = require("./emails_summary");
var EmailsResult  = require("./emails_result");

module.exports = React.createClass({
  render: function() {
    return <div className="row">
      <div className="small-12 medium-offset-3 medium-6 columns end">
        <div className="callout warning">
          <h5>Warning</h5>
          <p>
            We do not store any of your information so stay on this page. If you
            refresh or close the page, you will have to restart the analyze from
            scratch.
          </p>
        </div>
      </div>
      <div className="small-12 columns">
        <EmailsSummary results={this.props.results} />
      </div>
      <div className="small-12 columns">
        <EmailsResult results={this.props.results} />
      </div>
    </div>;
  }
});
