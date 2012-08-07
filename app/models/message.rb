class Message < ActiveRecord::Base
  include ArrayMaker

  belongs_to :user
  belongs_to :student

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
  scope :checked
  scope :unchecked

  attr_accessible :body, :user_id, :student_id

  after_create :queue_delivery_setup

  def checked?
    true
  end

  private

  def queue_delivery_setup
    Resque.enqueue(DeliverySetup, id)
  end
end