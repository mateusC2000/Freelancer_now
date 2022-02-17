class ProjectSerializer < ApplicationSerializer
  attributes :id, :title, :description, :requirements, :maximum_value_per_hour,
             :end_date, :working_model

  belongs_to :project_owner
  belongs_to :project_category
  has_many :proposals
end
