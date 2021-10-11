class Project < ApplicationRecord
  belongs_to :project_owner
  enum working_model: { presential: 1, remote: 2 }

  validates :title, :description, :requirements,
            :maximum_value_per_hour, :end_date,
            :working_model, presence: true

  validates :maximum_value_per_hour, numericality: { greater_than: 0 }
end
