module HomeHelper
    
  def time_out?(user)
    before_level = user.level
    @tasks = []
    user.habits.each do |habit|
      if habit.end_time < Date.current
        habit.end_time = Date.current.since(1.weeks)
          if habit.complete < habit.frequency
            user.update(level: user.level -= 5)
            habit.update(complete: 0)
            user.record(before_level)
            @tasks << habit.task
            @message = "Lvが#{before_level}から#{user.level}になりフォロワーに通知を送信しました"
          else
            habit.update(complete: 0)
          end
      end
    end
  end

end
