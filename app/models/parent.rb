class Parent < ActiveRecord::Base  
  has_many :student_parents
  has_many :students, through: :student_parents

  validates_inclusion_of :preference, in: %w(email phone)
  validates_as_phone_number :phone, message: "is not valid. Here's an example: 219-309-0213", allow_nil: true
  validates :email, email: true

  audited

  attr_accessible :phone, :email, :preference

  def prefers_email?
    preference == 'email'
  end

  def prefers_phone?
    preference == 'phone'
  end

  def toggle_preference!
    update_attributes!(
      preference: preference == 'email' ? 'phone' : 'email'
    )
  end
end
