class DeliveryObserver < ActiveRecord::Observer
  def after_update(delivery)
    if delivery.delivered_at_changed?
      with_current_user(delivery.user) do
        track_event "Update: Checked by Parent", {
          "School" => delivery.try(:user).try(:school).try(:name)
        }
      end
    end
  end
end