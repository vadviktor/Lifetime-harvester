class Task < ActiveRecord::Base
  attr_accessible :description, :time_spent

  def harvesting?
    started.present? and finished.blank? ? true : false
  end

  def current_timer
    if harvesting?
      self.time_spent += Time.now - started
    end

    hours = self.time_spent / 3600
    minutes = (self.time_spent - (hours * 3600)) / 60
    seconds = self.time_spent - (hours * 3600) - (minutes * 60)

    format("%02d:%02d:%02d", hours.floor, minutes.floor, seconds.round) #=> "01:00:00"
  end
end
