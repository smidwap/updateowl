module ApplicationHelper
  def time_or_date_format(time)
    time.to_date == Date.today ? time.strftime("%l:%M%P") : time.strftime("%b %e")
  end

  def blank_or_link_for_stat(stat, link)
    stat == 0 ? "-" : link_to(stat, link)
  end

  def second_or_third_person(user)
    user == current_user ? "you" : user.try(:professional_name)
  end

  def render_flash
    if flash.any?
      render "shared/alert", alert_class: alert_class_for_flash, message: flash_message
    else
      ""
    end
  end

  private

  def alert_class_for_flash
    alert_class = if flash[:notice]
              "alert-success"
            elsif flash[:alert]
              "alert-error"
            else
              ""
            end
    alert_class
  end

  def flash_message
    message = if flash[:notice]
                flash[:notice]
              elsif flash[:alert]
                flash[:alert]
              end
    message
  end
end
