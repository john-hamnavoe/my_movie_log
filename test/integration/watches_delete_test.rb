require 'test_helper'

class WatchesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @watch = watches(:one)
    @user_michael = users(:michael)
    @user_archer = users(:archer)
  end  
  
  test "should not delete if not logged in" do
    delete watch_path(@watch)
    assert_redirected_to login_path
  end

  test "should delete watch" do
    log_in_as(@user_michael)
    assert_difference 'Watch.count', -1 do
      delete watch_path(@watch)
    end
    assert_not flash.empty?
    assert_redirected_to watches_path
  end
  
  test "should not delete watch of invalid user" do
    log_in_as(@user_archer)
    assert_no_difference 'Watch.count' do
      delete watch_path(@watch)
    end
    assert_redirected_to watches_path
  end  
end
