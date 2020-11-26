class Habit < ApplicationRecord
    
validates :task, presence: true, length: { maximum: 12 }, uniqueness: { scope: :user }
validates :frequency, presence: true

belongs_to :user

end
