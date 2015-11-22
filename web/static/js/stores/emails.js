var AppDispatcher  = require("../dispatcher");
var EventEmitter   = require("events").EventEmitter;
var EmailConstants = require("../constants/emails");
var assign         = require("object-assign");
var $              = require("jquery");
var _              = require("lodash");

var CHANGE_EVENT = "change";
var _results     = {};

function initializeEmptyResult(emails) {
  var results = {};

  _.each(emails, function(email) {
    results[email] = { state: "pending", email: email };
  });

  return results;
};

function analyze(emails, callback) {
  _results = initializeEmptyResult(emails);

  _.each(_.chunk(_.values(_results), 20), function(chunk) {
    var emails = _.map(chunk, function(result) {
      return result.email;
    });

    $.post("/api/validation", { emails: emails }, function(analyzedEmails) {
      _.each(analyzedEmails, function(result) {
        var state = result.valid ? "valid" : "invalid";
        _results[result.email].state = state;
      });
      callback();
    });
  });
};

var Store = assign({}, EventEmitter.prototype, {
  getResults: function() {
    return _.values(_results);
  },

  addChangeListener: function(callback) {
    this.on(CHANGE_EVENT, callback);
  },

  emitChange: function() {
    this.emit(CHANGE_EVENT);
  }
});

AppDispatcher.register(function(action) {
  switch(action.type) {
    case EmailConstants.ANALYZE:
      analyze(action.emails, function() {
        Store.emitChange();
      });
      break;
    default:
  }
});

module.exports = Store;
