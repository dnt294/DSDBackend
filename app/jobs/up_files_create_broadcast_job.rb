class UpFilesCreateBroadcastJob < ApplicationJob
    queue_as :default

    def perform(father_id)
        ActionCable.server.broadcast "structure",
            order: 'create_up_file',
            father_id: father_id
        head :ok
    end
end
