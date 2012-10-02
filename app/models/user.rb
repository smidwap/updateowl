class User < ActiveRecord::Base
  include HasManyMessages
  include Nameable

  TITLES = ['Mr.', 'Mrs', 'Ms.', 'Miss', 'Dr.', 'Coach', 'Professor']

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :school
  has_many :colleagues, through: :school, class_name: 'User', source: :users, conditions: Proc.new { "users.id <> #{id}" }
  
  has_many :messages, order: 'messages.created_at DESC'
  has_many :deliveries, through: :messages
  
  has_many :classroom_relationships, dependent: :destroy
  has_many :students, through: :classroom_relationships
  has_many :parents, through: :students
  has_many :student_messages, through: :students, class_name: 'Message', source: :messages, uniq: true

  scope :has_sent_a_message_since, lambda { |time|
     joins(:messages)
    .merge(Message.in_date_range(time, Time.now))
    .select("users.*, COUNT(users.id) AS num_messages")
    .group("users.id")
    .having("num_messages > 0")
  }

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :title, :school_id

  def has_this_student?(student)
    has_these_students?([student])
  end

  def has_these_students?(students)
    common_student_ids = student_ids & students.map(&:id)
    common_student_ids.length == students.length
  end

  def professional_name
    "#{try(:title)}" + " #{try(:last_name)}"
  end

  def events
    Event::Builder.new(self).events
  end

  def consistency
    @consistency ||= Consistency.new(self)
  end

  def weekly_message_counts(num_trailing_weeks = 1)
    counts = num_trailing_weeks.times.inject([]) do |counts, index|
      counts << messages.weeks_ago(index).count
      counts
    end
  end
end
