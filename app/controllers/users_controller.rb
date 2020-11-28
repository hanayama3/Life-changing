class UsersController < ApplicationController
  include LoginUser
  before_action :set_user, except: [:index]
  before_action :redirect_root
  before_action :habit_ids_nil?, only: [:complete]
  
  def index
    @users = User.select("id,name,level,created_at").order(level: "desc").limit(10)
  end
  
  def show
  end
  
  def following
    @title = "フォロー"
    @users = @user.following
    render 'show_follow'
  end
  
  def followers
    @title = "フォロワー"
    @users = @user.followers
    render 'show_follow'
  end
  
def mission
end

def complete
 before_level = @user.level
  @habit = Habit.find(complete_params)
  @habit.each do |habit|
  habit.update(complete: habit.complete += 1)
  @user.update(level: @user.level += 1)
  flash[:notice] = "達成！"
end
@user.record(before_level)
redirect_to @user
end

private

def set_user
  @user = User.find(params[:id])
end

def habit_ids_nil?
  if params[:user][:habit_ids].join.empty?
  flash[:notice] = "チェックを入れてください"
   redirect_to request.referer
  end
end

def complete_params
  params.require(:user).permit(habit_ids: []).values.flatten.compact.reject(&:empty?)
end

end

