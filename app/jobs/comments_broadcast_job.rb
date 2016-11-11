class CommentsBroadcastJob < ApplicationJob
    queue_as :default

    def perform(comment)    	
    	ActionCable.server.broadcast "chat_rooms_#{comment.chat_room.id}",
                comment: comment.content,
                user: comment.user.username
            head :ok
    end
end
