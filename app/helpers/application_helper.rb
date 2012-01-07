module ApplicationHelper

 def user_name(user)
   name = user.login
   name ||= user.email
 end

 def competition_name(competition)
    name = competition.name
 end

end
