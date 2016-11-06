App.comments = App.cable.subscriptions.create('CommentsChannel', {

    // main socket function

    connected: function() {

    },

    disconnected: function() {

    },

    received: function(data) {
        return $('#comments').append(this.renderMessage(data));
    },

    // extra function
    renderMessage: function(data) {
        return "<p> <b>" + data.user + ": </b>" + data.comment + "</p>";
    }
});