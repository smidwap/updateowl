class FamilyTie  < ActiveRecord::Base
  belongs_to :student, counter_cache: :parents_count
  belongs_to :parent
end
