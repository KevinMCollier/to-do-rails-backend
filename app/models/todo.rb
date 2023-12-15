class Todo < ApplicationRecord
  enum repeat: {
    never: 'Never',
    daily_weekdays: 'Daily - Weekdays',
    daily_weekends: 'Daily - Weekends',
    daily: 'Daily',
    weekly: 'Weekly'
  }

  enum day_of_week: {
    monday: 'Monday',
    tuesday: 'Tuesday',
    wednesday: 'Wednesday',
    thursday: 'Thursday',
    friday: 'Friday',
    saturday: 'Saturday',
    sunday: 'Sunday'
  }, _prefix: true

  belongs_to :user

  validates :title, presence: true
  validates :date, presence: true
  validates :repeat, presence: true, inclusion: { in: repeats.keys }
  validates :day_of_week, inclusion: { in: day_of_weeks.keys }, allow_nil: true
end
