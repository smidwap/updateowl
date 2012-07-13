class User < ActiveRecord::Base
  include Stats

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages, foreign_key: :sender_id, order: "created_at DESC" do
    def in_date_range(start_date, end_date)
      where(created_at: start_date..end_date)
    end
  end
  has_many :classroom_relationships
  has_many :students, through: :classroom_relationships

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def has_student?(student)
    students.include?(student)
  end

  def messages_last_week
    messages.in_date_range(
      1.week.ago.beginning_of_week.to_s,
      1.week.ago.end_of_week.to_s
    )
  end

  def messages_unchecked
  end
end
