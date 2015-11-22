var React       = require("react/lib/React");
var EmailResult = require("./email_result");
var _           = require("lodash");

module.exports = React.createClass({
  render: function() {
    return <div className="row">
      {_.map(this.props.results, function(result) {
        return <div key={result.email} className="small-12 columns">
          <EmailResult email={result.email} state={result.state} />
        </div>;
      })}
    </div>;
  }
});
