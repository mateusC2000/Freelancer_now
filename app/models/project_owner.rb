class ProjectOwner < ApplicationRecord
  has_many :projects, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
