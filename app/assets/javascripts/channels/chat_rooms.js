$(document).on('turbolinks:load', function() {
    App.chat_rooms = App.cable.subscriptions.create({

        channel: 'ChatRoomsChannel',
        chat_room_id: $('.comment-list').data('chat-room-id')
    }, {
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
});