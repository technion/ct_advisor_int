# Preview all emails at http://localhost:3000/rails/mailers/email_alert
class EmailAlertPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/email_alert/activate
  def activate
    EmailAlert.activate
  end

  # Preview this email at http://localhost:3000/rails/mailers/email_alert/unsubscribe
  def unsubscribe
    EmailAlert.unsubscribe
  end

end
