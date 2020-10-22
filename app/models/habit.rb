class Habit < ApplicationRecord
    
validates :task, presence: true
validates :frequency, presence: true

belongs_to :user
end
