class Parent < ActiveRecord::Base  
  has_many :student_parents
  has_many :students, through: :student_parents

  validates_inclusion_of :preference, in: %w(email phone)

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
