class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @data = {'2019-06-01' => 100, '2019-06-02' => 200, '2019-06-03' => 150, '2019-06-04' => 220 }
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
complete = params[:complete]
@user.habits.zip(complete) do |h,i|
if i == "達成"
  h.complete += 1
  @user.level += 1
  flash[:notice]= "達成！"
  @user.save!
  h.save!
end
end
redirect_to @user
end

end

