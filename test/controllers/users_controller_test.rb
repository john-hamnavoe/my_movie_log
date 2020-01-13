require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "viewlog.me" 
    @user = users(:michael)
    @other_user = users(:archer)
    @not_active = users(:malory)
  end
  
  test "should get signup" do
    get signup_path
    assert_response :success
    assert_select "title", "sign up | #{@base_title}"
  end
  
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                  user:   { password:               "password",
                                            password_confirmation:  "password",
                                            admin:                   true }}
    assert_not @other_user.reload.admin?
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end  
  
  test "should redirect show when user is not active" do
    get user_path(@not_active)
    assert_redirected_to root_url
  end  
  
end