require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  def setup
    @location = Location.new(name: "new location", location_type: location_types(:one))
    @stored_location = locations(:one)
  end
  
  test "should be valid" do
    assert @location.valid?
  end
  
  test "should be invalid name and name length max 75" do
    @location.name = "        "
    assert_not @location.valid?
    @location.name = "a"*76
    assert_not @location.valid?
    @location.name = "a"*75
    assert @location.valid?
  end
  
  test "should have unique name" do
    @location.name = @stored_location.name
    assert_not @location.valid?
  end
  
  test "post_code should be max of 10" do
    @location.post_code = "a"*11
    assert_not @location.valid?
    @location.post_code = "a"*10
    assert @location.valid?
  end
  
  test "should be invalid with no location type" do
    @location.location_type_id = nil
    assert_not @location.valid?
  end
  
  test "website should be max of 255" do
    @location.website = "a"*256
    assert_not @location.valid?
    @location.website = "a"*255
    assert @location.valid?
  end  
end
