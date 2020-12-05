FactoryBot.define do
  factory :record do
     level { 0 }
     date { Date.current }
     user
  end
end
