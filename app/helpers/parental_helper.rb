module ParentalHelper
  def translation_feedback_message
    post_feedback_message = t('parental.thank_you_feedback')
    link = link_to(
      t('parental.web.translation_feedback_link'),
      feedback_parental_web_delivery_path(@delivery.access_code),
      remote: true,
      "data-no-second-tier" => true,
      onclick: "$(this).parent().text('#{post_feedback_message}')")
    t('parental.web.translation_feedback', link: link).html_safe
  end
end