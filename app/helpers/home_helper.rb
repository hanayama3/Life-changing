module HomeHelper
    
def time_out?(user)
 before_level = user.level
  user.habits.each do |habit|
  if habit.end_time < Date.current
   habit.end_time = Date.current.since(1.weeks)
   if habit.complete < habit.frequency
    user.update(level: user.level -= 5)
    habit.update(complete: 0)
    user.record(before_level)
    @message = "Lvが#{before_level}から#{user.level}になりました"
   else
   habit.update(complete: 0)
   end
  end
 end
end

end
