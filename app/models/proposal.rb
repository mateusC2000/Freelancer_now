class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :developer

  enum status: { pending: 0, accepted: 1, recused: 2 }

  validates :motivation, :weekly_hours_available, presence: true
  validates :weekly_hours_available, numericality: { greater_than: 0 }

  validates :project_id, uniqueness: { scope: :developer_id }
end
