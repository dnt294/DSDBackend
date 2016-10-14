class ChatRoomsController < ApplicationController

    def show
        @chatroom = ChatRoom.find_by(crmid: params[:id])
        @new_comment = Comment.new
    end

end
