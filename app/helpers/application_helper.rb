module ApplicationHelper
    
  def flash_color(key)
    case key
      when "alert"
        "warning"
      when "notice"
        "success"
      when "error"
        "danger"
    end
  end
  
end
