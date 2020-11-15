class HabitsController < ApplicationController

def new
@habit = current_user.habits.new
end

def create
@habit = Habit.new(habit_params)
@habit.end_time = Date.current.since(1.weeks)
if @habit.save
flash[:notice] = "習慣を登録しました"
redirect_to @habit.user
else
render 'new'
end
end

def edit
@habit = Habit.find_by(id: params[:id])
end

def update
@habit = Habit.find_by(id: params[:id])
@habit.update(habit_params)
flash[:notice] = "習慣を変更しました"
redirect_to @habit.user
end

def destroy
@habit = Habit.find_by(id: params[:id])
@habit.destroy
flash[:alert] = "習慣を削除しました"
redirect_to @habit.user
end

private

def habit_params
params.require(:habit).permit(:task, :frequency, :user_id)
end

end
