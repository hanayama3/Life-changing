class NotificationsController < ApplicationController
  # include NotLogged
  before_action :redirect_root
  
    def index
     @notifications = current_user.passive_notifications
     @notifications.where(checked: false).each do |n|
      n.update_attributes(checked: true)
    end
    end
    
 private
    
 def redirect_root
  if current_user.nil?
  flash[:notice] = "ログインしてください"
  redirect_to root_path
end
end

end
