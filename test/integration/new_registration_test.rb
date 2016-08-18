require 'test_helper'

class NewRegistrationTest < ActionDispatch::IntegrationTest
   test "creates a new registration" do
     # Ensure the existing registration does not already exist
     @newreg = Registration.find_by(domain: 'creationdomain.com')
     refute @newreg

     #Create the registration
     get "/registrations/new"
     assert_response :success
     post "/registrations", params: {
       registration: {email: "anew@creationdomain.com",
       domain: "creationdomain.com"} }
     assert_response :success

     # Test the registration now exists
     @newreg = Registration.find_by(domain: 'creationdomain.com')
     assert @newreg

     # A new account is inactive
     assert_equal 0, @newreg.active

     # Perform a verify
     get "/registrations/verify/" + @newreg.id.to_s + "/" + @newreg.nonce
     assert_response :success
     assert_select "body div", {text: "Click to verify your registration"}

     post "/registrations/verify",
       params: {id: @newreg.id, nonce: @newreg.nonce}
     assert_response :success
     assert_select "body div", {text: "User has been verified."}

     # Test verify worked
     @newreg.reload
     assert_equal 1, @newreg.active

   end
end
