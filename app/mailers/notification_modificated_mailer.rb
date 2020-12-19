class NotificationModificatedMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_modificated_mailer.when_modificated.subject
  #
  def when_modificated (user)
    @user = user 
    mail(to: @user.email)
  end
end
