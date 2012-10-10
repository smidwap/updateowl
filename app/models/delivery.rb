class Delivery < ActiveRecord::Base
  # TODO: rename to recipient
  belongs_to :parent
  has_one :school, through: :parent

  belongs_to :student_message
  has_one :student, through: :student_message
  has_one :message, through: :student_message
  has_one :user, through: :message

  scope :recipient, lambda { |parents| where(parent_id: parents) }
  scope :not_these, lambda { |deliveries| where("id NOT IN (?)", deliveries) }
  scope :checked, where("checked_at IS NOT NULL")
  scope :unchecked, where(checked_at: nil)
  scope :with_access_codes, lambda { |access_codes| where(access_code: access_codes) }
  scope :latest_first, order("created_at DESC")
  scope :oldest_first, order("created_at ASC")

  before_create :set_access_code
  after_create :deliver_via_email, if: :should_deliver_immediately?
  after_save :update_student_message_as_checked, if: :checked_at_changed?

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

  # TODO: Maybe move into decorator and check for IL8n?
  def message_body
    return message.spanish_body if parent.spanish_speaking?
    return message.body
  end

private

  def update_student_message_as_checked
    student_message.update_attribute(:checked_at, Time.now) unless student_message.checked?
  end

  def should_deliver_immediately?
    parent.preference == 'email'
  end

  def set_access_code
    self.access_code = UUID.new.generate
  end
end
