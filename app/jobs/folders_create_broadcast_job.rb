class FoldersCreateBroadcastJob < ApplicationJob
    queue_as :default

    def perform(new_folder_id, father_id)
        ActionCable.server.broadcast "structure",
            order: 'create_folder',
            father_id: father_id,            
            new_folder_id: new_folder_id
        head :ok
    end
end
