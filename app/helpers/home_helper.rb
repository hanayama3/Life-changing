module HomeHelper
    
def time_out?(user)
 end_time = user.habits.map(&:end_time)
 complete = user.habits.map(&:complete)
 frequency = user.habits.map(&:frequency)
 before_level = user.level
 
  user.habits.each do |habit|
  if habit.end_time < Date.current
   habit.start_time = Time.current
   habit.end_time = Time.current.since(1.weeks)
  
   if habit.complete < habit.frequency
    user.level -= 5
    user.save!
    habit.complete = 0
    habit.save!
    user.level_change(before_level)
    flash[:notice] = "失望したよ お前には"
   else
   habit.complete = 0
   habit.save!
   end
   
  end
  
 end
end

end
