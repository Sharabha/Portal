module ApplicationHelper

 def competition_name(competition)
    name = competition.name
 end
 def date_for_form(date)
    return date.nil? ? '' : date.strftime('%Y-%m-%d %H:%M')
 end

end
