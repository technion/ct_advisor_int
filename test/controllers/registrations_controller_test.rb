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

  test "should get verify invalid id" do
    get :verify, {'id' => 10, 'nonce' => 'erwgrwegwerg'}
    assert_response :success
    assert_select "body div", {text: "ID not found"}
  end

  test "should get destroy invalid id" do
    get :verify, {'id' => 10, 'nonce' => 'erwgrwegwerg'}
    assert_response :success
    assert_select "body div", {text: "ID not found"}
  end


end
