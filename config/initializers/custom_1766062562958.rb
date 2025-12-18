# Custom initializer for FluxPay Platform
# This file contains custom configurations and setup

Rails.application.config.after_initialize do
  # Custom configuration goes here
  
  # Set default time zone
  Time.zone = 'UTC'
  
  # Configure logging
  Rails.logger.formatter = proc do |severity, datetime, progname, msg|
    "[#{datetime.strftime('%Y-%m-%d %H:%M:%S')}] #{severity}: #{msg}\n"
  end
  
  # Load custom validators
  Dir[Rails.root.join('app/validators/*.rb')].each { |f| require f }
  
  # Configure ActionMailer
  ActionMailer::Base.default charset: 'utf-8'
  
  # Custom middleware
  # Rails.application.config.middleware.use CustomMiddleware
end