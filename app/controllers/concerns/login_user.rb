module LoginUser
extend ActiveSupport::Concern
 
 def redirect_root
  if current_user.nil?
  flash[:notice] = "ログインしてください"
  redirect_to root_path
end
end

end