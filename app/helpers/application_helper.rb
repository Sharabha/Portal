module ApplicationHelper

 def user_name(user)
   name = user.login
   name ||= user.email
 end

end
