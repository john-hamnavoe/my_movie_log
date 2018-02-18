require 'test_helper'

class LocationsNewTest < ActionDispatch::IntegrationTest
  def setup
    @location = Location.new(name: 'a cinema', 
                             location_type_id: location_types(:one).id, 
                             website: "http://www.acinema.com", 
                             post_code: "G612BN" )
  end

  test 'should not create with out login' do
    assert_no_difference 'Location.count' do
      post locations_path, params: { location: { 
        name: @location.name, 
        location_type_id: @location.location_type_id,
        website: @location.website, 
        post_code: @location.post_code} }
    end
    assert_redirected_to login_path
  end

  test 'should create' do
    log_in_as(users(:michael))
    assert_difference 'Location.count', +1 do
      post locations_path, params: { location: { 
        name: @location.name, 
        location_type_id: @location.location_type_id,
        website: @location.website, 
        post_code: @location.post_code} }
    end
    assert_redirected_to locations_path
    assert_not flash.empty?
  end
  
  test 'should handle failure to create' do
    log_in_as(users(:michael))
    assert_no_difference 'Location.count' do
      post locations_path, params: { location: { 
        name: "        ", 
        location_type_id: @location.location_type_id,
        website: @location.website, 
        post_code: @location.post_code} }
    end
    assert flash.empty?
    assert_template 'locations/new'
  end
end
