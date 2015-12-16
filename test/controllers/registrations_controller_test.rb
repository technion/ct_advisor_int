require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get delete" do
    get :unsub
    assert_response :success
  end

  test "should get verify" do
    get :verify, {'id' => 3, 'nonce' => 'erwgrwegwerg'}
    assert_response :success
  end

end
