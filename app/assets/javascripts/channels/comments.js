App.comments = App.cable.subscriptions.create('CommentsChannel', {
    received: function(data) {
        return $('#comments').append(this.renderMessage(data));
    },
    renderMessage: function(data) {
        return "<p> <b>" + data.user + ": </b>" + data.comment + "</p>";
    }
});