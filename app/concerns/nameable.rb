module Nameable
  extend ActiveSupport::Concern

  included do
    scope :ordered_by_name, order("last_name ASC, first_name ASC")
  end
  
  def full_name
    "#{try(:first_name)}" + (last_name? ? " #{try(:last_name)}" : "")
  end
end