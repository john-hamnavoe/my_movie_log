require 'test_helper'

class SubscriptionsHelperTest < ActionView::TestCase

  def setup
  end

  test "test 0 values" do
    assert_equal 0, cost_per_movie(0, 8)
    assert_nil cost_per_movie(0, 0)
    assert_nil cost_per_movie(17.9, 0)
  end

  test "test average and rounding" do
    assert_equal 3.58, cost_per_movie(17.9, 5)
    assert_equal 4.96, cost_per_movie(9.91, 2)
    assert_equal 4.95, cost_per_movie(9.909, 2)
  end
end