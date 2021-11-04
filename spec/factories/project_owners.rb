FactoryBot.define do
  factory :project_owner do
    email { generate(:email) }
    password { "123456789" }
  end
end


FactoryBot.define do
  sequence :email do |n|
    "user#{n}@email.com"
  end
end 