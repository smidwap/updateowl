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
end
