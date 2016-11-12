class Api::ChatRoomsController < Api::ApiController

    def show
        @chat_room = ChatRoom.find(params[:id])
        render json: @chat_room, include: [comments: :user]
    end

end
