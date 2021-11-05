FactoryBot.define do
  factory :proposal do
    motivation { 'Por pura diversão' }
    weekly_hours_available { 40 }
    status { 0 }
    developer
    project
  end
end
