class DeliveryObserver < ActiveRecord::Observer
  def after_update(delivery)
    Analytics.with_current_user(delivery.user) do
      Analytics.track_event "Update: Checked by Parent", {
        "School" => delivery.try(:user).try(:school).try(:name),
        "Translated" => delivery.parent.spanish_speaking?
      }
    end
  end
end