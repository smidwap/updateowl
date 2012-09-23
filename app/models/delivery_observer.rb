class DeliveryObserver < ActiveRecord::Observer
  def after_create(delivery)
    Analytics.track_delivery_event(delivery, "Delivery: Created")
  end

  def after_update(delivery)
    Analytics.track_delivery_event(delivery, "Delivery: Checked") if just_checked?(delivery)
  end

private

  def just_checked?(delivery)
    delivery.checked_at_changed? && delivery.checked_at.present?
  end
end