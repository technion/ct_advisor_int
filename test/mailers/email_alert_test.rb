require 'test_helper'

class EmailAlertTest < ActionMailer::TestCase
  test "activate" do
    mail = EmailAlert.activate(Registration.first)
    assert_equal "Account Activation", mail.subject
    assert_equal ["testuser@testdomain.com"], mail.to
    assert_equal ["ct_advisor@lolware.net"], mail.from
  end

  test "unsubscribe" do
    mail = EmailAlert.unsubscribe(Registration.first)
    assert_equal "Unsubscribe", mail.subject
    assert_equal ["testuser@testdomain.com"], mail.to
    assert_equal ["ct_advisor@lolware.net"], mail.from
  end

end
