class FoldersDestroyBroadcastJob < ApplicationJob
    queue_as :default

    def perform(folder_ids)
        ActionCable.server.broadcast "structure",
            order: 'delete_folders',
            folders: folder_ids
        head :ok
    end
end
