class NotificationsController < ApplicationController
  include LoginUser
  before_action :redirect_root
  
    def index
     @notifications = current_user.passive_notifications
     @notifications.where(checked: false).each do |notifications|
      notifications.update_attributes(checked: true)
    end
    end
    
end
