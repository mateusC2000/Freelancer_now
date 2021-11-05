class Developer < ApplicationRecord
  has_one :developer_profile, dependent: :destroy
  has_many :proposals, dependent: :destroy
  has_many :projects, through: :proposals

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
