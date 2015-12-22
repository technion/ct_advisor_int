require 'test_helper'

class BoundaryTest < ActionDispatch::IntegrationTest
  test "unsubscribe_deny" do
    @registration = Registration.find(1)
    assert @registration

    get "/registrations/destroy/" + @registration.id.to_s + "/" +
      "thisisnotthenonce"
    assert_response :success
    assert_select "body div", {text: "Nonce is invalid"}

    delete "/registrations", 
      id: @registration.id, nonce: "thisisnothenonce"
    assert_response :success
    assert_select "body div", {text: "Nonce is invalid"}

    # Ensure the record still exists
    assert @registration.reload
  end
end
