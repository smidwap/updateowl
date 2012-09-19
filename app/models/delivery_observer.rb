class DeliveryObserver < ActiveRecord::Observer
  def after_update(delivery)
    if should_track_check?(delivery)
      Analytics.with_current_user(delivery.user) do
        Analytics.track_event "Update: Checked by Parent", {
          "School" => delivery.try(:user).try(:school).try(:name)
        }
      end
    end
  end

  private

  # Is this the first checked delivery of this message 
  def should_track_check?(delivery)
    delivery.checked_at_changed? && delivery.message.deliveries.checked.count == 1 #TODO: Is this complexity worth it?
  end
end