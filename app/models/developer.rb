class Developer < ApplicationRecord
  has_one :developer_profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
