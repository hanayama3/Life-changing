module NotificationsHelper
    
def unchecked
    current_user.passive_notifications.where(checked: false)
end

end