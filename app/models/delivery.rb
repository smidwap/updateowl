class Delivery < ActiveRecord::Base
  include ArrayMaker

  belongs_to :parent
  has_one :school, through: :parent

  belongs_to :student
  
  belongs_to :message
  has_one :user, through: :message

  scope :recipient, lambda { |parents| where(parent_id: ids_from(parents)) }
  scope :not_these, lambda { |deliveries|
    delivery_ids = ids_from(deliveries)
    where("id NOT IN (?)", delivery_ids.blank? ? '' : delivery_ids)
  }
  scope :checked, where("checked_at IS NOT NULL")
  scope :unchecked, where(checked_at: nil)
  scope :with_access_codes, lambda { |access_codes| where(access_code: access_codes) }
  scope :latest_first, order("created_at DESC")
  scope :oldest_first, order("created_at ASC")

  before_create :set_access_code
  after_create :deliver_via_email, if: :should_deliver_immediately?

  def deliver_via_email
    MessageMailer.notification(self).deliver
  rescue AWS::SES::ResponseError
    # Don't stop execution if this exception is raised.
  end

  def checked!
    return if checked_at?
    
    self.checked_at = Time.now
    self.save!
  end

  def next_delivery?
    !next_delivery.nil?
  end

  def next_delivery
    Delivery.recipient(parent).not_these(self).unchecked.first
  end

  def message_body
    return message.spanish_body if parent.spanish_speaking?
    return message.body
  end

private

  def should_deliver_immediately?
    parent.preference == 'email'
  end

  def set_access_code
    self.access_code = UUID.new.generate
  end
end
