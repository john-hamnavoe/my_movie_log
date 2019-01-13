require 'test_helper'

class SubscriptionsHelperTest < ActionView::TestCase

  def setup
  end

  test "test 0 values - cost_per_movie" do
    assert_equal 0, cost_per_movie(0, 8)
    assert_nil cost_per_movie(0, 0)
    assert_nil cost_per_movie(17.9, 0)
  end

  test "test average and rounding - cost_per_movie" do
    assert_equal 3.58, cost_per_movie(17.9, 5)
    assert_equal 4.96, cost_per_movie(9.91, 2)
    assert_equal 4.95, cost_per_movie(9.909, 2)
  end

  test "test 0 values - total_full_price" do
    assert_equal 0, total_full_price(0, 8)
    assert_equal 0, total_full_price(0, 0)
    assert_nil total_full_price(nil, 0)
    assert_nil total_full_price(11.7, nil)
  end

  test "test sum and rounding - total_full_price" do
    assert_equal 23.4, total_full_price(11.70, 2)
    assert_equal 23.43, total_full_price(11.713, 2)
  end

  test "total_savings - calculations" do
    assert_equal -17.90, total_savings(17.90, 11.70, 0), "if no watches  savings - amount"
    assert_equal -6.2, total_savings(17.90, 11.70, 1), "if less watches than amount -ve saving"
    assert_equal 17.2, total_savings(17.90, 11.70, 3), "if more watches then +ve saving"
  end
end


