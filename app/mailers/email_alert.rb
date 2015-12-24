class EmailAlert < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.email_alert.activate.subject
  #
  def activate(registration)
    @url = Rails.application.config.host + "/registrations/verify/" +
      registration.id.to_s + "/" + registration.nonce

    mail to: registration.email, subject: "Account Activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.email_alert.unsubscribe.subject
  #
  def unsubscribe(registration)
    @url = Rails.application.config.host + "/registrations/destroy/" +
      registration.id.to_s + "/" + registration.nonce

    mail to: registration.email, subject: "Unsubscribe"
  end
end
