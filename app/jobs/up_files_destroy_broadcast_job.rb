class UpFilesDestroyBroadcastJob < ApplicationJob
    queue_as :default

    def perform(up_file_id)
        ActionCable.server.broadcast "structure",
            order: 'delete_up_file',
            up_file_id: up_file_id
        head :ok
    end
end
