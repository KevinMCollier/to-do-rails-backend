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

  # New methods

  # Method to filter todos by date
  def self.filter_by_date(user_id, date)
    where(user_id: user_id).select do |todo|
      case todo.repeat
      when 'never'
        todo.date.to_date == date
      when 'daily'
        true
      when 'daily_weekdays'
        !date.saturday? && !date.sunday?
      when 'daily_weekends'
        date.saturday? || date.sunday?
      when 'weekly'
        todo.day_of_week.downcase == date.strftime('%A').downcase
      end
    end
  end

  # Method to set day of week for weekly todos
  def assign_day_of_week
    if repeat == 'weekly' && !day_of_week.present?
      self.day_of_week = date.strftime('%A') if date
    end
  end

  # Override save method to include assign_day_of_week
  def save(*args)
    assign_day_of_week
    super
  end
end
