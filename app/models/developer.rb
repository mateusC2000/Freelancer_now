class Developer < ApplicationRecord
  has_one :developer_profile
  has_many :proposals
  has_many :projects, through: :proposals

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
