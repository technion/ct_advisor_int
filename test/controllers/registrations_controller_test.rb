require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should require capcha" do
    # Recaptcha disables by default in test - enable for this test.
    Recaptcha.configuration.skip_verify_env.delete("test")
    post :create, params: { registration: {email: "anew@creationdomain.com",
            domain: "creationdomain.com"} }
    Recaptcha.configuration.skip_verify_env.push("test")
    assert_response :success
    assert_select "body div", {text: "Captcha incorrectly entered"}
  end

  test "should reject invalid domain" do
    ["com", ".com", "google", "cloudflaressl.com"].each do |domain|
      # Recaptcha disables by default in test - enable for this test.
      post :create, params: {registration: {email: "anew@creationdomain.com",
              domain: domain} }
      assert_response :success
      assert_select "body div", {text: "Entered domain is not valid"}
    end
  end


  test "should get delete" do
    get :unsub
    assert_response :success
  end

  test "should get verify invalid id" do
    get :verify, params: {'id' => 10, 'nonce' => 'erwgrwegwerg'}
    assert_response :success
    assert_select "body div", {text: "ID not found"}
  end

  test "should get verify invalid nonce" do
    get :verify, params: {'id' => 1, 'nonce' => 'erwgrwegwerg'}
    assert_response :success
    assert_select "body div", {text: "Nonce not valid"}
  end

  test "should get destroy invalid id" do
    get :verify, params: {'id' => 10, 'nonce' => 'erwgrwegwerg'}
    assert_response :success
    assert_select "body div", {text: "ID not found"}
  end

end
