class ProjectOwner < ApplicationRecord
  has_many :projects
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
