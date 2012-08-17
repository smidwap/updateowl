module Nameable
  extend ActiveSupport::Concern
  
  def full_name
    "#{try(:first_name)}" + (last_name? ? " #{try(:last_name)}" : "")
  end
end