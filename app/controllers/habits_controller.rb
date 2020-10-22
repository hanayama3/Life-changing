class HabitsController < ApplicationController

def new
@habit = current_user.habits.new
end

def create
habit = Habit.new(habit_params)
if habit.save
flash[:notice] = "習慣を登録しました"
redirect_to habit.user
else
flash[:alert] = "習慣の登録に失敗しました"
render 'new'
end
end

def edit
@habit = Habit.find_by(id: params[:id])
end

def update
    render html: "俺は天才"
end

def destroy
end

private

def habit_params
params.require(:habit).permit(:task, :frequency, :user_id)
end

end
