module ApplicationHelper

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
 def formatted(text, format_type="plain text")
    case format_type
    when "markdown"
        markdown text
    when "simple html"
        sanitize text
    when "textilize"
        textilize text
    else
        text
    end
 end
  def available_formats
    ["plain text", "simple html" ,"markdown", "textilize"]
  end
end
