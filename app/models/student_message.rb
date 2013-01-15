class StudentMessage < ActiveRecord::Base
  include Deliverable
  include ActsAsMessage

  belongs_to  :student
  has_many    :parents, through: :student
  belongs_to  :message, counter_cache: true
  has_many    :deliveries, dependent: :destroy

  after_save :increment_checks_counter, if: :checked_at_changed?
  after_save :update_message_last_checked_at, if: :checked_at_changed?

  after_destroy { message.destroy_if_individual_student_is_destroyed }
  after_destroy :decrement_checks_counter, if: :checked_at?

private

  def increment_checks_counter
    message.increment!(:checks_count)
  end

  def decrement_checks_counter
    message.decrement!(:checks_count)
  end

  def update_message_last_checked_at
    message.update_attribute(:last_checked_at, Time.now)
  end
end