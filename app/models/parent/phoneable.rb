module Parent::Phoneable
  extend ActiveSupport::Concern

  included do
    attr_writer :phone_area_code, :phone_three_digits, :phone_four_digits
    attr_accessible :phone_area_code, :phone_three_digits, :phone_four_digits

    before_save :set_phone

    validates :phone_area_code, presence: true, length: { is: 3 }, if: :should_validate_phone_parts?
    validates :phone_three_digits, presence: true, length: { is: 3 }, if: :should_validate_phone_parts?
    validates :phone_four_digits, presence: true, length: { is: 4 }, if: :should_validate_phone_parts?
  end

  def phone_area_code
    @phone_area_code || phone.to_s[2..4]
  end

  def phone_three_digits
    @phone_three_digits || phone.to_s[5..7]
  end

  def phone_four_digits
    @phone_four_digits || phone.to_s[8..11]
  end

  private

  def set_phone
   self.phone = "+1#{phone_area_code}#{phone_three_digits}#{phone_four_digits}"
  end

  def should_validate_phone_parts?
    prefers_phone? && !phone.blank?
  end
end