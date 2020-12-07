class Habit < ApplicationRecord
belongs_to :user

validates :task, presence: true, length: { maximum: 12 }, uniqueness: { scope: :user }
validates :frequency, presence: true
validate :user_habits_size_validate

 HABIT_MAX = 6
def user_habits_size_validate
    if self.user && self.user.habits.size >=  HABIT_MAX
        errors.add(:task,"は#{HABIT_MAX}つまでしか登録出来ません")
    end
end

end
