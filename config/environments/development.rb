Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true
  config.serve_static_files = true
  config.consider_all_requests_local = true

  # email stuff
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :test
  host = 'localhost:3000'
  config.action_mailer.default_url_options = { host: host }

  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :bucket => ENV.fetch('S3_BUCKET_NAME'),
      :access_key_id => ENV.fetch('AWS_ACCESS_KEY_ID'),
      :secret_access_key => ENV.fetch('AWS_SECRET_ACCESS_KEY')
    }
  }
end
