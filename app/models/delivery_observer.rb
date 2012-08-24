class DeliveryObserver < ActiveRecord::Observer
  def after_update(delivery)
    if should_track_check?(delivery)
      with_current_user(delivery.user) do
        track_event "Update: Checked by Parent", {
          "School" => delivery.try(:user).try(:school).try(:name)
        }
      end
    end
  end

  private

  # Is this the first successful delivery of this message 
  def should_track_check?(delivery)
    delivery.delivered_at_changed? && delivery.message.deliveries.successful.count == 1
  end
end