require 'carrierwave/storage/fog'

CarrierWave.configure do |config|

  if %w(development test).include?(Rails.env)
    config.storage = :file
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  else
    config.storage = :fog
  end

  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET_KEY'],
      :region                 => ENV['S3_REGION']
  }

  config.fog_directory  = ENV['S3_BUCKET_NAME']
end
