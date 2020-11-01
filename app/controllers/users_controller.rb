class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
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
@complete = params[:complete]
if @complete
@complete.each do |complete|
  @user.level += 1
  # @user.habits.map {|habit| habit.complete += 1}
  flash[:notice] = "レベルアップ！"
  @user.save
end
end
redirect_to @user
end

end
