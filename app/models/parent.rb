  class Parent < ActiveRecord::Base
  include Phoneable

  belongs_to :school
  has_many :family_ties, dependent: :destroy
  has_many :students, through: :family_ties
  has_many :deliveries, dependent: :destroy

  scope :school, lambda { |schools| where(school_id: schools) }
  scope :with_unchecked_messages, lambda {
     joins(:deliveries)
    .where(deliveries: {checked_at: nil})
    .select("parents.*, count(parents.id) as n_delivered_messages")
    .group("parents.id")
    .having("n_delivered_messages > 0")
  }
  scope :of_students, lambda { |students|
     joins(:students)
    .where(students: {id: students})
  }
  scope :prefers_phone, where(preference: 'phone')
  scope :prefers_email, where(preference: 'email')
  scope :spanish_speaking, where(spanish_speaking: true)

  validates_inclusion_of :preference, in: %w(email phone), message: "is required to be either email or phone"
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

  def locale
    spanish_speaking? ? 'es': 'en'
  end

private

  def sufficient_contact_details
    unless has_and_prefers_phone? || has_and_prefers_email?
      errors[:base] << "Contact details must be provided for the parent's communication preference."
    end
  end

  def has_and_prefers_phone?
    prefers_phone? && !phone.blank?
  end

  def has_and_prefers_email?
    prefers_email? && !email.blank?
  end
end
