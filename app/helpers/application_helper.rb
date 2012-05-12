module ApplicationHelper

 def user_name(user)
   name = user.login
   name ||= user.email
 end

 def competition_name(competition)
    name = competition.name
 end
 def date_for_form(date)
    return date.nil? ? '' : date.strftime('%Y-%m-%d %H:%M')
 end
 def date_for_form_with_default(date, default_date)
    if date.nil? then date=default_date end
    return date_for_form(date)
 end
end
