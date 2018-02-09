require 'test_helper'

class HomePagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "my movie log" 
  end
  
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "home | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "contact | #{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "about | #{@base_title}"    
  end

end
