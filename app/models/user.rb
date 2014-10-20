class User < ActiveRecord::Base
  
  TIMELINE = [['Day', 'day'], ['Week', 'week'], ['Month', 'month']]
  GROUP    = [['Walking', 'walking'], ['Running', 'running']]
  ORDER    = [['Time', 'time'], ['Least to greatest', 'ltg'], ['Greatest to lease', 'gtl']]
  
  has_many :activities
  
  def self.create_with_omniauth(auth)
    # if auth[:credentials][:token].blank? || auth[:credentials][:token] == self.try(:access_token)
      create! do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.access_token = auth[:credentials][:token]
      end
    # else
    #   User.update_attributes!(access_token: auth[:credentials][:token])
    # end
  end
end
