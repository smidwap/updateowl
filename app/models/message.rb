class Message < ActiveRecord::Base
  include ArrayMaker
  include Translatable

  belongs_to :user
  has_one :school, through: :user
  belongs_to :student
  has_many :recipients, through: :student, source: :parents, class_name: 'Parent'
  has_one :grade_level, through: :student

  has_many :deliveries

  validates :body, presence: true

  scope :from_user, lambda { |users| where(user_id: ids_from(users)) }
  scope :for_student, lambda { |students| where(student_id: ids_from(students)) }
  scope :last_week, lambda { weeks_ago(1) }
  scope :weeks_ago, lambda { |weeks_ago|
    in_date_range(
      weeks_ago.week.ago.beginning_of_week.to_s,
      weeks_ago.week.ago.end_of_week.to_s
    )
  }
  scope :in_date_range, lambda { |start_date, end_date|
    where(created_at: start_date..end_date)
  }
  scope :checked, lambda {
     joins(:deliveries)
    .where("deliveries.delivered_at IS NOT NULL")
    .select("messages.*, count(messages.id) as n_checked_deliveries")
    .group("messages.id")
    .having("n_checked_deliveries > 0")

  }
  scope :unchecked, lambda {
    checked_ids = ids_from(checked.all)
    where("id NOT IN (?)", checked_ids.blank? ? '' : checked_ids)
  }

  attr_accessible :body, :user_id, :student_id

  after_create :queue_delivery_setup

  def checked?
    deliveries.checked.count > 0
  end

  private

  def queue_delivery_setup
    Resque.enqueue(DeliverySetup, id)
  end
end