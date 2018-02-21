# frozen_string_literal: true

module NextDueDateUtil
  def self.next_due_date(current_date, start_date, months)
    date_advanced = current_date.advance(months: months)
    date_advanced = reset_date_to_start_day(date_advanced, start_date) || date_advanced
  end

private
  def self.reset_date_to_start_day(date_advanced, start_date)
    if start_date.day > date_advanced.day
      days_in_month = Time.days_in_month(date_advanced.month, date_advanced.year)
      if days_in_month >= start_date.day 
        Date.new(date_advanced.year, date_advanced.month, start_date.day)
      end
    end
  end
end