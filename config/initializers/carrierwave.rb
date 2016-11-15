require 'ftp'
#require 'carrierwave/storage/ftp'

CarrierWave.configure do |config|
    #config.storage = :file
    #config.asset_host = ActionController::Base.asset_host

    config.storage_engines[:ftp] = "CarrierWave::Storage::FTP"

    config.ftp_host = ENV['ftp_host']
    config.ftp_port = ENV['ftp_port']
    config.ftp_user = ENV['ftp_user']
    config.ftp_passwd = ENV['ftp_passwd']
    config.ftp_folder = ENV['ftp_folder']
    config.ftp_url = ENV['ftp_url']
    config.ftp_passive = ENV['ftp_passive']

end
