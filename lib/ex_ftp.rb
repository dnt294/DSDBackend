require 'net/ftp'

class ExFTP < Net::FTP

    def mkdir_p(dir)
        parts = dir.split("/")
        
        for part in parts
            next if part == ""
            begin
                mkdir(part)
            rescue
            end
            begin
                chdir(part)
            rescue                
            end
        end
    end

end
