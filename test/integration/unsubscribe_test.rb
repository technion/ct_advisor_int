require 'test_helper'

class UnsubscribeTest < ActionDispatch::IntegrationTest
  test "unsubscribe" do
    # User 2 is a fixture - unsubscribe it
    @registration = Registration.find(2)
    assert @registration

    get "/registrations/unsubscribe"
    assert_response :success

    post "/registrations/unsubscribe",
      registration: {email: @registration.email, domain: @registration.domain}
    assert_response :success
    assert_select "body div", {text: "Unsubscribe email sent."}

    get "/registrations/destroy/" + @registration.id.to_s + "/" +
      @registration.nonce
    assert_response :success
    assert_select "body div", {text: "Click to confirm unsubscribe"}

    delete "/registrations/destroy", 
      id: @registration.id, nonce: @registration.nonce
    assert_response :success
    assert_select "body div", {text: "Registration removal confirmed"}

    # Ensure the record is now deleted
    assert_raises(ActiveRecord::RecordNotFound) { @registration.reload }
  end
end
