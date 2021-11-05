class ProjectCategory < ApplicationRecord
  has_many :projects, dependent: :destroy

  validates :category, presence: true
end
