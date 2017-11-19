CarrierWave.configure do |config|
  if Rails.env == 'production'
    Excon.defaults[:ciphers] = 'DEFAULT'
    config.fog_provider = 'fog/aws' 
    config.fog_credentials = {
      # Configuration for Amazon S3 should be made available through an Environment variable.
      # For local installations, export the env variable through the shell OR
      # if using Passenger, set an Apache environment variable.
      #
      # In Heroku, follow http://devcenter.heroku.com/articles/config-vars
      #
      # $ heroku config:add S3_KEY=AKIAIZ2JSDFDTROSJG5A S3_SECRET=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 S3_REGION=us-west-1 S3_ASSET_URL=http://urgarden.s3-website-us-west-1.amazonaws.com S3_BUCKET_NAME=urgarden -a urgarden
   
      # Configuration for Amazon S3
      :provider               => 'AWS',                        # required
      :aws_access_key_id     => ENV['S3_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET'],
      :region                => ENV['S3_REGION']
    
    }
   
    # For testing, upload files to local `tmp` folder.
    if Rails.env.development? || Rails.env.cucumber?
      config.storage = :file
      config.enable_processing = false
      config.root = "#{Rails.root}/tmp"
    else
      config.storage = :fog
    end
   
    config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
    config.fog_directory  = ENV['S3_BUCKET_NAME']
    config.fog_public     = false 
  end
end