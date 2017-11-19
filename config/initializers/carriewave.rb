CarrierWave.configure do |config|
  if Rails.env == 'production'
    config.fog_credentials = {
      # Configuration for Amazon S3 should be made available through an Environment variable.
      # For local installations, export the env variable through the shell OR
      # if using Passenger, set an Apache environment variable.
      #
      # In Heroku, follow http://devcenter.heroku.com/articles/config-vars
      #
      # $ heroku config:add S3_KEY=AKIAIZ2JSDFDTROSJG5A S3_SECRET=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 S3_REGION=us-west-1 S3_ASSET_URL=http://agora.rockstars.mx S3_BUCKET_NAME=agora-shapes-and-forms
   
      # Configuration for Amazon S3
      :provider               => 'AWS',                        # required
      :aws_access_key_id     => 'AKIAIZ2JSDFDTROSJG5A',
      :aws_secret_access_key => 'slFlq33/0Z/wzTlzaG0cgiXqOiF+c5rZ+qe01nM',
      :region                => 'us-west-1',
    
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
    config.fog_directory  = 'urgarden'
    config.fog_public     = false 
  end
end