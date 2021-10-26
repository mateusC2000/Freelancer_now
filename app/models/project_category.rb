class ProjectCategory < ApplicationRecord
  has_many :projects

  validates :category, presence: true
end
