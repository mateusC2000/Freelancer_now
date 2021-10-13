class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :developer

  enum status: { pending: 0 }
end
