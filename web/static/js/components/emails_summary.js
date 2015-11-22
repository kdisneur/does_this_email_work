var React = require("react/lib/React");

module.exports = React.createClass({
  render: function() {
    return <div className="callout">
      <div className="row">
        <div className="small-12 medium-6 large-3 columns">
          Total unique emails: { this._total() }
        </div>
        <div className="small-12 medium-6 large-3 columns">
          Analyzed emails: { this._totalAnalyzed() }
        </div>
        <div className="small-12 medium-6 large-3 columns">
          Valid emails: { this._totalValid() }
        </div>
        <div className="small-12 medium-6 large-3 columns">
          Invalid emails: { this._totalInvalid() }
        </div>
      </div>
    </div>;
  },

  _total: function() {
    return this.props.results.length;
  },

  _totalAnalyzed: function() {
    return this._countWhere(function(result) {
      return result.state != "pending";
    });
  },

  _totalValid: function() {
    return this._countWhere(function(result) {
      return result.state == "valid";
    });
  },

  _totalInvalid: function() {
    return this._countWhere(function(result) {
      return result.state == "invalid";
    });
  },

  _countWhere: function(filter) {
    return _.filter(this.props.results, filter).length;
  }
});
