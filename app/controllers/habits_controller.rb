class HabitsController < ApplicationController
include LoginUser

before_action :set_habit, only: [:edit, :update, :destroy]
before_action :ensure_current_user, only: [:edit, :update]
before_action :redirect_root

def new
@habit = current_user.habits.new
@title = "習慣の登録"
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
  @title = "習慣の編集"
end

def update
@habit.update(habit_params)
flash[:notice] = "習慣を変更しました"
redirect_to @habit.user
end

def destroy
@habit.destroy
flash[:alert] = "習慣を削除しました"
redirect_to @habit.user
end

private

def set_habit
  @habit = Habit.find(params[:id])
end

def ensure_current_user
  unless current_user == @habit.user
     flash[:alert] = "このページにはアクセスできません"
    redirect_to root_url
  end
end

def habit_params
params.require(:habit).permit(:task, :frequency, :user_id)
end

end
