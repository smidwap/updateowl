class Delivery < ActiveRecord::Base
  belongs_to :parent
  belongs_to :message

  attr_accessible :parent, :message

  after_create :deliver, if: :should_deliver_immediately?

  def deliver
    deliver_via_email if parent.prefers_email?
    deliver_via_phone if parent.prefers_phone?
  end

  private

  def should_deliver_immediately?
    parent.preference == 'email'
  end

  def deliver_via_email
  end

  def delivery_via_phone
  end
end
