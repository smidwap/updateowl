module ApplicationHelper
  def js_redirect(url)
    raw("App.main.redirect('#{url}')")
  end
end
