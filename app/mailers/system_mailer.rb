class SystemMailer < ApplicationMailer
  default from: Rails.application.config.smtp_from || 'noreply@cryptopay.com'
  
  def welcome_email(user)
    @user = user
    @url = Rails.application.config.frontend_url
    
    mail(
      to: @user.email,
      subject: 'Welcome to CryptoPay Platform'
    )
  end
  
  def notification_email(user, subject, message)
    @user = user
    @message = message
    
    mail(
      to: @user.email,
      subject: subject
    )
  end
  
  def payment_confirmation(payment)
    @payment = payment
    @user = payment.user
    
    mail(
      to: @user.email,
      subject: "Payment Confirmation - #{@payment.id}"
    )
  end
end
