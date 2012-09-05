class Delivery < ActiveRecord::Base
  include ArrayMaker

  belongs_to :parent
  belongs_to :message
  has_one :user, through: :message
  has_one :student, through: :message

  scope :recipient, lambda { |parents| where(parent_id: ids_from(parents)) }
  scope :not_these, lambda { |deliveries|
    delivery_ids = ids_from(deliveries)
    where("id NOT IN (?)", delivery_ids.blank? ? '' : delivery_ids)
  }
  #TODO: rename to checked/unchecked to fit domain vocab
  scope :checked, where("delivered_at IS NOT NULL")
  scope :unchecked, where(delivered_at: nil)

  attr_accessible :parent, :message

  before_create :set_access_code
  after_create :deliver_via_email, if: :should_deliver_immediately?

  def deliver_via_email
    MessageMailer.notification(self).deliver
  end

  def checked!
    return if delivered_at?
    self.delivered_at = Time.now
    save!
  end

  def next_delivery?
    !next_delivery.nil?
  end

  def next_delivery
    Delivery.recipient(parent).not_these(self).unchecked.first
  end

  private

  def should_deliver_immediately?
    parent.preference == 'email'
  end

  def set_access_code
    self.access_code = UUID.new.generate
  end
end
