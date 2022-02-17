class ProposalSerializer < ApplicationSerializer
  attributes :id, :status, :motivation, :weekly_hours_available, :developer

  belongs_to :project
  belongs_to :developer

  def developer
    ActiveModelSerializers::SerializableResource.new(object.developer, serializer: ProposalDeveloperSerializer)
  end
end
