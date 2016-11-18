$(document).on('turbolinks:load', function() {
    App.structure = App.cable.subscriptions.create("StructureChannel", {
        connected: function() {
            // Called when the subscription is ready for use on the server
        },

        disconnected: function() {
            // Called when the subscription has been terminated by the server
        },

        received: function(data) {
            // Called when there's incoming data on the websocket for this channel
            this.executeMessage(data);
        },

        //extraFunction
        executeMessage: function(data) {
            console.log('something new!');
            switch (data.order) {
                case 'delete_folders':
                    var current_folder = $('#current_folder').text();
                    if (current_folder) {
                        var deleted_folders = $.map(data.folders, function(value, index) {
                            return [value];
                        });

                        // nếu current folder bị xóa => refresh
			for (var i = 0; i< deleted_folders.length; i++) {
				if (deleted_folders[i] == current_folder) {
					console.log('deleted current folder! Return to home page');
					window.location.replace('/folders');
					break;
				}
			}

                        if (deleted_folders.indexOf(current_folder) > -1) {
                            console.log('deleted current folder! move to root!');
                            window.location.replace('/folders');
                        }
                        // nếu con của current bị xóa => load lại list
                        var children_folder_ids = $('.children_folder_id').map(function() {
                            return $(this).text();
                        });
                        console.log('Các con ' + children_folder_ids);
                        var collapse = arrayContainsAnotherArray(children_folder_ids, deleted_folders);
                        if (collapse) {
                            console.log('has children deleted ! Refresh !');
                            $.get('/folders/' + current_folder + '/refresh');
                        }
                    }
                    break;
                case 'create_folder':
                    var current_folder = $('#current_folder').text();
                    if (current_folder) {
                        var father_id = data.father_id;
                        var new_folder_id = data.new_folder_id;
                        if (current_folder == father_id) { // kiểm tra xem có đúng là thêm vào folder cha này ko.
                            if ($('.' + new_folder_id).length == 0) { // chưa có item này -> ko phải tab vừa tạo item.
                                console.log('new folder!' + current_folder + ' ' + father_id);
                                $.get("/folders/" + father_id + "/refresh?part=folder");
                            }
                        }
                    }
                    break;
                case 'create_up_file':
                    var current_folder = $('#current_folder').text();
                    if (current_folder) {
                        var father_id = data.father_id;
                        if (current_folder == father_id) { // kiểm tra xem có đúng là thêm vào folder cha này ko.
                            console.log('new file shortcut!' + current_folder + ' ' + father_id);
                            $.get("/folders/" + current_folder + "/refresh?part=file");
                        }
                    }
                    break;
                case 'delete_up_file':
                    var up_file_id = data.up_file_id;
                    var current_folder = $('#current_folder').text();
                    if (current_folder) {
                        // kiểm tra xem trong đống con của mình có bị xóa ko => nếu có => refresh                        
                        var children_up_file_ids = $('.children_up_file_id').map(function() {
                            return $(this).text();
                        });
                        for (var i = 0; i < children_up_file_ids.length; i++) {
                            if (children_up_file_ids[i] == up_file_id) {
                                console.log('có 1 file bị xóa! Load lại cho chắc!');
                                $.get("/folders/" + current_folder + "/refresh?part=file");
                                break;
                            }
                        }
                    } else {
                        var current_file = $('#current_file').text();
                        console.log(current_file + ' ' + up_file_id);
                        if (current_file == up_file_id) {
                            console.log('đang coi file! kiểm tra lại xem có bị xóa không !');
                            $.getJSON("/up_files/" + current_file + "/check_exist.json", function(data) {
                                if (data == false) {
                                    window.location.replace('/folders');
                                }
                            });
                        }
                    }
                    break;
            }
        }
    });
});