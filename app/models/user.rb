class User < ActiveRecord::Base
  include HasManyMessages

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :classroom_relationships
  has_many :students, through: :classroom_relationships

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def has_student?(student)
    students.include?(student)
  end
end
