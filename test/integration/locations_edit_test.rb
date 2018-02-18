require 'test_helper'

class LocationsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @location = locations(:one)
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_location_path(@location)
    assert_template 'locations/edit'
    patch location_path(@location), params: {location: {name: "",
                                            location_type_id: nil }}
    assert_template 'locations/edit'
    assert flash.empty?
  end
  
  test "successful edit" do
    log_in_as(@user)
    name = "New Location Name!"
    location_type_id = location_types(:two).id
    patch location_path(@location), params: {location: {name: name,
                                            location_type_id: location_type_id }} 
    location = assigns(:location)
    assert_not flash.empty?, location.errors.full_messages
    assert_redirected_to locations_path
    @location.reload
    assert_equal name, @location.name
    assert_equal location_type_id, @location.location_type_id
  end
  
  test "should redirect update when not logged in" do
    name = "New Location Name!"
    location_type_id = location_types(:two).id
    patch location_path(@location), params: {location: {name: name,
                                            location_type_id: location_type_id }} 
    assert_not flash.empty?
    assert_redirected_to login_path
  end
end
