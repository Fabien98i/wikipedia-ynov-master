# Preview all emails at http://localhost:3000/rails/mailers/notification_modificated_mailer
class NotificationModificatedMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification_modificated_mailer/when_modificated
  def when_modificated
    NotificationModificatedMailer.when_modificated
  end

end
