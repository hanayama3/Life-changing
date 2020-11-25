class NotificationsController < ApplicationController
  include LoginUser
  before_action :redirect_root
  
    def index
     @notifications = current_user.passive_notifications.page(params[:page]).per(9)
     @notifications.where(checked: false).each do |notifications|
      notifications.update_attributes(checked: true)
    end
    end
    
    def destroy
     @user = User.find(params[:id])
     @user.passive_notifications.destroy_all
     flash[:notice] = "通知を全件削除しました"
     redirect_to @user
    end
    
end
