class ChatRoomsChannel < ApplicationCable::Channel
    def subscribed
        stream_from "chat_rooms_#{params['chat_room_id']}"
    end

    def unsubcribed

    end
end
