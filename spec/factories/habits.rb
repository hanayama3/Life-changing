FactoryBot.define do
  factory :habit do
    sequence(:task) { |n| "ランニング#{n}"}
    frequency { 3 }
    user
  end
end
