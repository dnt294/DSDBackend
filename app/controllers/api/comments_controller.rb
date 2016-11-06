class Api::CommentsController < Api::ApiController

    def create
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        if @comment.save
            CommentsBroadcastJob.perform_later @comment
            render status: 200, json: {message: 'Tạo comment thành công!', comment: @comment}
        else
	render status: 401, json: {message: 'Tạo comment không thành công!'}
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.permit(:content, :user_id, :chat_room_id)
    end

end
