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
  
  has_many :messages, order: 'created_at DESC'
  has_many :deliveries, through: :messages
  has_many :classroom_relationships, dependent: :destroy
  has_many :students, through: :classroom_relationships
  has_many :parents, through: :students
  has_many :student_messages, through: :students, class_name: 'Message', source: :messages


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :title, :school_id

  def has_student?(student)
    students.include?(student)
  end

  def professional_name
    "#{try(:title)}" + " #{try(:last_name)}"
  end

  def events
    Event::Builder.new(self).events
  end
end
