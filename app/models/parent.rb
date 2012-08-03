class Parent < ActiveRecord::Base  
  has_many :family_ties
  has_many :students, through: :family_ties
  has_many :deliveries

  validates_inclusion_of :preference, in: %w(email phone), message: "is required to be either email or phone"
  validates_as_phone_number :phone, message: "is not valid. Here's a valid example: 219-309-0213 or 2193090213", allow_nil: true
  validates :email, email: true, allow_blank: true
  validate :sufficient_contact_details

  audited

  attr_accessible :phone, :email, :preference

  def prefers_email?
    preference == 'email'
  end

  def prefers_phone?
    preference == 'phone'
  end

  def current_contact
    send(preference)
  end

  private

  def sufficient_contact_details
    if (prefers_phone? && phone.blank?) || (prefers_email? && email.blank?)
      errors[:base] << "Contact details must be provided for the parent's communication preference."
    end
  end
end
