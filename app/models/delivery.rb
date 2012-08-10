class Delivery < ActiveRecord::Base
  belongs_to :parent
  belongs_to :message
  has_one :user, through: :message

  scope :successful, where(success: true)
  scope :unsuccessful, where(success: false)

  attr_accessible :parent, :message

  before_create :set_access_code
  after_create :deliver_via_email, if: :should_deliver_immediately?

  def deliver_via_email
    MessageMailer.notification(self).deliver
  end

  def checked!
    self.success = true
    save!
  end

  private

  def should_deliver_immediately?
    parent.preference == 'email'
  end

  def set_access_code
    self.access_code = UUID.new.generate
  end
end
