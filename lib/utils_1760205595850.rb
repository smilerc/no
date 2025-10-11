# Utility functions for FluxPay Platform
module Utils
  extend self
  
  def generate_secure_token(length = 32)
    SecureRandom.hex(length)
  end
  
  def format_currency(amount, currency = 'USD')
    case currency.upcase
    when 'BTC'
      "#{amount.round(8)} BTC"
    when 'ETH'
      "#{amount.round(6)} ETH"
    when 'USD'
      "$#{amount.round(2)}"
    else
      "#{amount} #{currency}"
    end
  end
  
  def validate_email(email)
    email.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end
  
  def sanitize_params(params, allowed_keys)
    params.select { |key, _| allowed_keys.include?(key.to_sym) }
  end
  
  def log_api_request(request, response_status)
    Rails.logger.info "API: #{request.method} #{request.path} - #{response_status}"
  end
end