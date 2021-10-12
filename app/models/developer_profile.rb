class DeveloperProfile < ApplicationRecord
  belongs_to :developer
  validates :full_name, :social_name, :date_birth,
            :academic_formation, :performance_zone,
            :professional_experiences, presence: true
end
