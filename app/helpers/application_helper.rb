module ApplicationHelper
  def js_redirect(url)
    raw("App.main.redirect('#{url}')")
  end

  def time_or_date_format(time)
    time.to_date == Date.today ? time.strftime("%l:%M%P") : time.strftime("%b %e")
  end
end
