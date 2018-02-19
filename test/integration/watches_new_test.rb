require 'test_helper'

class WatchesNewTest < ActionDispatch::IntegrationTest
  def setup
    @watch = Watch.new(date: '1/1/2018'.to_date, movie_id: movies(:movie_one).id)
    @user_michael = users(:michael)
  end
  
  test "should not create without login" do
    assert_no_difference 'Watch.count' do
      post watches_path, params: { watch: { movie_id: @watch.movie_id, date: @watch.date } }
    end
    assert_redirected_to login_path    
  end
  
  test "should create with login" do
    log_in_as(@user_michael)
    assert_difference 'Watch.count', +1 do
      post watches_path, params: { watch: { movie_id: @watch.movie_id, date: @watch.date } }
    end
    assert_redirected_to watches_path
    watch = Watch.find_by(date: @watch.date)
    assert_equal watch.user_id, @user_michael.id
    assert_not flash.empty?
  end  
  
  test "should not create with login and invalid details" do
    log_in_as(@user_michael)
    assert_no_difference 'Watch.count' do
      post watches_path, params: { watch: { movie_id: @watch.movie_id, date: nil } }
    end
    assert_template 'watches/new'
    assert flash.empty?
    watch = assigns(:watch)
    assert_not watch.nil?
  end    
end
