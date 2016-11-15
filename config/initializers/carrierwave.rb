require 'ftp'

CarrierWave.configure do |config|
    #config.storage = :file
    #config.asset_host = ActionController::Base.asset_host

    config.storage_engines[:ftp] = "CarrierWave::Storage::FTP"

    config.ftp_host = '192.168.1.101'
    config.ftp_port = 21
    config.ftp_user = 'tom'
    config.ftp_passwd = '1'
    config.ftp_folder = '/projects/upload'
    config.ftp_url = "http://192.168.1.101/"
    config.ftp_passive = true # false by default

end
