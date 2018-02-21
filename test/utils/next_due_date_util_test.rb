require 'test_helper'

class NextDueDateUtilTest < ActionView::TestCase
  test "should do monthly increment and set correct day" do
    assert_equal '15 Feb 2018'.to_date, NextDueDateUtil.next_due_date('15 Jan 2018'.to_date, '15 Jan 2018'.to_date, 1)
    assert_equal '28 Feb 2018'.to_date, NextDueDateUtil.next_due_date('29 Jan 2018'.to_date, '29 Jan 2018'.to_date, 1)
    assert_equal '29 Mar 2018'.to_date, NextDueDateUtil.next_due_date('28 Feb 2018'.to_date, '29 Jan 2018'.to_date, 1)
    assert_equal '29 Feb 2020'.to_date, NextDueDateUtil.next_due_date('29 Jan 2020'.to_date, '29 Jan 2018'.to_date, 1)
    assert_equal '29 Mar 2020'.to_date, NextDueDateUtil.next_due_date('29 Feb 2020'.to_date, '29 Jan 2018'.to_date, 1)
    assert_equal '30 Apr 2020'.to_date, NextDueDateUtil.next_due_date('31 Mar 2020'.to_date, '31 Jan 2018'.to_date, 1)
    assert_equal '31 May 2020'.to_date, NextDueDateUtil.next_due_date('30 Apr 2020'.to_date, '31 Jan 2018'.to_date, 1)
  end

  test "should do yearly increment and set correct day" do
    assert_equal '15 Jan 2019'.to_date, NextDueDateUtil.next_due_date('15 Jan 2018'.to_date, '15 Jan 2018'.to_date, 12)
    assert_equal '28 Feb 2021'.to_date, NextDueDateUtil.next_due_date('28 Feb 2020'.to_date, '28 Feb 2018'.to_date, 12)
    assert_equal '1 Mar 2021'.to_date,  NextDueDateUtil.next_due_date('1 Mar 2020'.to_date, '1 Mar 2017'.to_date, 12)
    assert_equal '28 Feb 2021'.to_date, NextDueDateUtil.next_due_date('29 Feb 2020'.to_date, '29 Feb 2016'.to_date, 12)
    assert_equal '29 Feb 2024'.to_date, NextDueDateUtil.next_due_date('28 Feb 2023'.to_date, '29 Feb 2016'.to_date, 12)
  end
end