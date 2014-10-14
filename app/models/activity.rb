class Activity < ActiveRecord::Base
  belongs_to :user
  
  TIMELINE = [['Day', 'day'], ['Week', 'week'], ['Month', 'month']]
end
