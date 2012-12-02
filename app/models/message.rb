class Message < ActiveRecord::Base
  include Translatable
  include Checkable

  has_many :student_messages, dependent: :destroy

  has_many :students, through: :student_messages
  has_many :recipients, through: :students, source: :parents, class_name: 'Parent'
  has_many :grade_levels, through: :students, uniq: true

  # TODO rename to sender
  belongs_to :user
  has_one :school, through: :user

  validates :body, presence: true

  scope :from_user, lambda { |users| where(user_id: users) }
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
  scope :individual, where('student_messages_count = 1')
  scope :mass, where('student_messages_count > 1')
  scope :oldest_first, order('created_at ASC')
  scope :recent_first, order('created_at DESC')

  attr_accessible :body, :user_id, :student_ids

  # TODO: test
  def individual?
    return student_messages_count == 1 unless student_messages_count == 0
    return students.length == 1
  end

  def destroy_if_individual_student_is_destroyed
    destroy if students.length == 0
  end
end