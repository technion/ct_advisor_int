require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
    assert_template "registrations/new"
  end

  test "should require capcha" do
    # Recaptcha disables by default in test - enable for this test.
    Recaptcha.configuration.skip_verify_env.delete("test")
    post :create, registration: {email: "anew@creationdomain.com",
            domain: "creationdomain.com"}
    Recaptcha.configuration.skip_verify_env.push("test")
    assert_select "body div", {text: "Captcha incorrectly entered"}
    assert_response :success
  end


  test "should get delete" do
    get :unsub
    assert_response :success
    assert_template "registrations/unsub"
  end

  test "should get verify invalid id" do
    get :verify, {'id' => 10, 'nonce' => 'erwgrwegwerg'}
    assert_response :success
    assert_select "body div", {text: "ID not found"}
    assert_template "status"
  end

  test "should get verify invalid nonce" do
    get :verify, {'id' => 1, 'nonce' => 'erwgrwegwerg'}
    assert_response :success
    assert_select "body div", {text: "Nonce not valid"}
    assert_template "status"
  end

  test "should get destroy invalid id" do
    get :verify, {'id' => 10, 'nonce' => 'erwgrwegwerg'}
    assert_response :success
    assert_select "body div", {text: "ID not found"}
    assert_template "status"
  end


end
