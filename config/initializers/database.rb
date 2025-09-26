# Database connection initialization for production
if Rails.env.production?
  # Ensure database connection is established
  begin
    ActiveRecord::Base.connection
  rescue ActiveRecord::NoDatabaseError
    # Database doesn't exist, this is expected on first deploy
    Rails.logger.info "Database doesn't exist yet, will be created during release phase"
  rescue => e
    Rails.logger.error "Database connection issue: #{e.message}"
  end
end