module UpFilesHelper

    def get_ftp_connection
        ftp = ExFTP.new        
        ftp.connect(ENV['ftp_host'], ENV['ftp_port'])

        begin
            ftp.passive = ENV['ftp_passive']
            ftp.login(ENV['ftp_user'], ENV['ftp_passwd'])

            yield ftp
        ensure
            ftp.quit
        end
    end

end
