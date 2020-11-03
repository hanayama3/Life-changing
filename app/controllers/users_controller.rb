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
if params[:complete]
complete = params[:complete].map(&:to_i)
@user.habits.zip(complete) do |h,i|
  h.complete += i
  flash[:notice] = "レベルアップ！"
  h.save!
end
end
redirect_to @user
end

end

