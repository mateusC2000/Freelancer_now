FactoryBot.define do
  factory :project do
    title { 'Desenvolvedor de Sites' }
    description { 'Desenvolvimento de sites e-commerce e institucionais' }
    requirements { 'Buscamos pessoas com experiência em e-commerce Google ADS CMS SEO' }
    maximum_value_per_hour { 10 }
    end_date { 10.days.from_now }
    working_model { 2 }
    project_owner
    project_category
  end
end
