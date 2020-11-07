class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @data = {"11/1" => 1,"11/2" => 2,"11/3" => 3,"11/5" => 4,"11/6" => 5,"11/7" => 6,"11/8" => 3}
    
  end
  
  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end
  
  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end
  
def mission
 @user = User.find_by(id: params[:id])
end

def complete
@user = User.find_by(id: params[:id])
habit_id = (complete_params).values.flatten.compact.reject(&:empty?)
unless habit_id.empty?
@habit = Habit.find(habit_id)
@habit.each do |h|
  h.complete += 1
  flash[:notice] = "達成！"
  h.save!
  # @level = @user.level += 1
  # @user.save!
  # @time = Time.current.strftime("%m/%d")
  # @data = Hash.new
  # @data.store(@time,@level)
  # binding.pry
end
end
redirect_to @user
end

private

def complete_params
  params.require(:user).permit(habit_ids: [])
end

end

