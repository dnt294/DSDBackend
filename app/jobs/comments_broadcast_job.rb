class CommentsBroadcastJob < ApplicationJob
    queue_as :default

    def perform(comment)
    	ActionCable.server.broadcast 'comments',
                comment: comment.content,
                user: comment.user.username
            head :ok
    end
end
