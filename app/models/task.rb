class Task < ActiveRecord::Base
  attr_accessible :description

  def counting?
    finished.blank? ? true : false
  end



end
