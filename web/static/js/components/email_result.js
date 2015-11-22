var React = require("react/lib/React");

module.exports = React.createClass({
  render: function() {
    var className = "callout m-analyzer--email is-" + this.props.state;

    return <div className={className}>
      { this.props.email }
    </div>;
  }
});
