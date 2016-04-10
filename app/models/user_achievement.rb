class UserAchievement < ActiveRecord::Base
  belongs_to :user
  belongs_to :achievement
end
