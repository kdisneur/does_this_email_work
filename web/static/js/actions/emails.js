var AppDispatcher  = require("../dispatcher");
var EmailConstants = require("../constants/emails");

module.exports = Actions = {
  analyze: function(emails) {
    AppDispatcher.dispatch({
      type: EmailConstants.ANALYZE,
      emails:  emails
    });
  }
};
