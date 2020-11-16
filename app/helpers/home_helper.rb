module HomeHelper
    
def time_out?(user)
 end_time = user.habits.map(&:end_time)
 complete = user.habits.map(&:complete)
 frequency = user.habits.map(&:frequency)
 before_level = user.level
 
  user.habits.each do |habit|
  if habit.end_time < Date.current
   habit.end_time = Date.current.since(1.weeks)
   if habit.complete < habit.frequency
    user.update_attributes(level: user.level -= 5)
    habit.update_attributes(complete: 0)
    user.record(before_level)
    flash[:notice] = "失望したよ お前には"
   else
   habit.update_attributes(complete: 0)
   flash[:notice] = "道切り開くもの　勇者よ"
   end
   
  end
  
 end
end

end
