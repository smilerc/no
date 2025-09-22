// Refactored for better maintainability
require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CryptopayProcessing
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # API-only mode configurations
    config.api_only = false # We need views for admin interface
    
    # CORS configuration
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins Rails.env.production? ? ENV['ALLOWED_ORIGINS']&.split(',') : ['localhost:3001']
        resource '*',
                 headers: :any,
                 methods: [:get, :post, :put, :patch, :delete, :options, :head],
                 credentials: true,
                 expose: ['X-Total-Count', 'X-Page', 'X-Per-Page']
      end
    end

    # Security headers
    config.force_ssl = Rails.env.production?
    
    # Session configuration
    config.session_store :cookie_store,
                        key: '_cryptopay_session',
                        secure: Rails.env.production?,
                        httponly: true,
                        same_site: :lax

    # ActiveJob configuration
    config.active_job.queue_adapter = :sidekiq

    # Time zone
    config.time_zone = 'UTC'

    # Eager loading
    config.eager_load_paths << Rails.root.join('lib')

    # Generator configuration
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
      g.factory_bot dir: 'spec/factories'
    end

    # Logging configuration
    if Rails.env.production?
      config.log_level = :info
      config.lograge.enabled = true
      config.lograge.formatter = Lograge::Formatters::Json.new
      config.lograge.custom_options = lambda do |event|
        {
          time: event.time,
          remote_ip: event.payload[:remote_ip],
          user_id: event.payload[:user_id],
          request_id: event.payload[:request_id]
        }
      end
    end

    # Exception handling
    config.exceptions_app = self.routes

    # Rate limiting
    config.middleware.use Rack::Attack

    # Health check
    config.middleware.insert_after ActionDispatch::DebugExceptions, 
                                  Rack::ContentLength

    # Redis configuration
    config.redis_url = ENV.fetch('REDIS_URL', 'redis://localhost:6379/0')

    # Cryptocurrency configuration
    config.bitcoin_rpc_url = ENV.fetch('BITCOIN_RPC_URL', 'http://localhost:8332')
    config.ethereum_node_url = ENV.fetch('ETHEREUM_NODE_URL', 'http://localhost:8545')

    # Business logic constants
    config.min_confirmation_btc = ENV.fetch('MIN_CONFIRMATION_BTC', 3).to_i
    config.min_confirmation_eth = ENV.fetch('MIN_CONFIRMATION_ETH', 12).to_i
    config.processing_fee_btc = ENV.fetch('PROCESSING_FEE_BTC', 0.005).to_f
    config.processing_fee_eth = ENV.fetch('PROCESSING_FEE_ETH', 0.003).to_f

    # Webhook configuration
    config.webhook_secret = ENV.fetch('WEBHOOK_SECRET', Rails.application.secret_key_base)
    config.max_webhook_attempts = ENV.fetch('MAX_WEBHOOK_ATTEMPTS', 3).to_i

    # File upload limits
    config.max_file_size = ENV.fetch('MAX_FILE_SIZE', 10.megabytes).to_i
    config.allowed_file_types = ENV.fetch('ALLOWED_FILE_TYPES', 'jpg,jpeg,png,pdf').split(',')
  end
end
