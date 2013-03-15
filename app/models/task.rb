class Task < ActiveRecord::Base
  attr_accessible :description

  belongs_to :user

  def harvesting?
    started.present? and finished.blank? ? true : false
  end

  def current_timer
    if harvesting?
      Time.diff(started, Time.now, '%h:%m:%s')
    else
      Time.diff(started, finished, '%h:%m:%s')
    end
  end
end
