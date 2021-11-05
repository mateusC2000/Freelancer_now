FactoryBot.define do
  factory :developer do
    email { generate(:email) }
    password { '123456789' }
  end
end

FactoryBot.define do
  sequence :gmail do |n|
    "dev#{n}@gmail.com"
  end
end
