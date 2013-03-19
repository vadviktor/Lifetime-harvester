class Task < ActiveRecord::Base
  attr_accessible :description

  belongs_to :user

  validates :description, presence: true, length: {minimum: 1}

  def harvesting?
    started.present? and finished.blank? ? true : false
  end

  def current_timer
    return Time.diff(Time.now, Time.now) if started.nil? and finished.nil?

    if harvesting?
      Time.diff(started, Time.now, '%h:%m:%s')
    else
      Time.diff(started, finished, '%h:%m:%s')
    end
  end
end
