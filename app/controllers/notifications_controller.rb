class NotificationsController < ApplicationController
    def index
     @notifications = current_user.passive_notifications
     @notifications.where(checked: false).each do |n|
      n.update_attributes(checked: true)
    end
    end
end
