require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @location = locations(:one)  
  end
  
  test "should index if not logged on or not" do
    get locations_path
    assert_response :success
    assert_select "a[href=?]", new_location_path, { count: 0 }
    locations = assigns(:locations)
    #eager load test so not N+1 if access these lookups
    assert locations[0].association(:location_type).loaded?    
    log_in_as(users(:michael))
    get locations_path
    assert_response :success
    assert_select "a[href=?]", new_location_path, { count: 1 }
  end  
  
  test "should get new if logged in" do
    get new_location_path
    assert_redirected_to login_path
    log_in_as(users(:michael))
    get new_location_path
    assert_response :success
    location = assigns(:location)
    assert_not location.nil?
  end

  test "should get show if logged in or not" do
    get location_path(@location.id)
    assert :success
    log_in_as(users(:michael))
    get location_path(@location.id)
    assert :success
    location = assigns(:location)
    assert_equal @location.id, location.id
  end

  test "should get edit if logged in" do
    get edit_location_path(@location.id)
    assert_redirected_to login_path
    log_in_as(users(:michael))
    get edit_location_path(@location.id)
    assert_response :success
    location = assigns(:location)
    assert_equal @location.id, location.id
  end  
end
