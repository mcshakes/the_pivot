require File.expand_path('../boot', __FILE__)
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module DinnerDash
  class Application < Rails::Application
    config.exceptions_app = self.routes
    config.active_record.raise_in_transactional_callbacks = true
    config.serve_static_files = true

    config.active_job.queue_adapter = :sidekiq

    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
             address: "smtp.mandrillapp.com",
                port: "587",
              domain: "example.com",
           user_name: "mirjoy.moser@gmail.com",
            password: "yU3nkotqFA34HGpIy60oQA",
      authentication: "plain",
 enablestarttls_auto: true
    }
  end
end
