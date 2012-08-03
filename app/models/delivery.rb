class Delivery < ActiveRecord::Base
  belongs_to :parent
  belongs_to :message

  attr_accessible :parent, :message

  before_create :set_access_code
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
    MessageMailer.notification(message, parent).deliver
  end

  def delivery_via_phone
  end

  def set_access_code
    self.access_code = UUID.new.generate
  end
end
