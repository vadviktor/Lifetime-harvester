class Task < ActiveRecord::Base
  attr_accessible :description, :time_spent

  def harvesting?
    finished.blank? ? true : false
  end

  def current_timer
    seconds = time_spent % 60
    minutes = (time_spent / 60) % 60
    hours = time_spent / (60 * 60)

    format("%02d:%02d:%02d", hours, minutes, seconds) #=> "01:00:00"
  end
end
