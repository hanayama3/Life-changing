class Habit < ApplicationRecord
    
validates :task, presence: true, length: { maximum: 12 }
validates :frequency, presence: true

belongs_to :user
end
