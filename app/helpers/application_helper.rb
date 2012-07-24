module ApplicationHelper
  def js_redirect(url)
    raw("App.main.redirect('#{url}')")
  end

  def time_or_date_format(time)
    time.to_date == Date.today ? time.strftime("%l:%M%P") : time.strftime("%b %e")
  end

  def blank_or_link_for_stat(stat, link)
    stat == 0 ? "-" : link_to(stat, link)
  end

  def second_or_third_person(user)
    user == current_user ? "you" : user.try(:professional_name)
  end

  def flash_class_from_type(type)
    case type
    when "alert"
      "error"
    when "notice"
      "success"
    end
  end
end
