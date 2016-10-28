module ApplicationHelper
    def current_controller_is name
        controller_name == name
    end

    def current_folder
        @current_folder || Folder.find_by(id: session[:current_folder])
    end

    def set_current_folder (folder_id)
        session[:current_folder] = folder_id
        @current_folder = Folder.find_by(id: folder_id)
    end

    def truncate_title input, opt = {}
        length = opt[:length] || 20
        truncate(input, length: length)    
    end

    def aut_params bool_var
        bool_var ? 'Có' : 'Không'
    end

    def shared_with_me_page
        @shared_with_me_page
    end
   

end
