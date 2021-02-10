FactoryBot.define do
  factory :habit do
    sequence(:task) { |n| "ランニング#{n}"}
    frequency { 3 }
    complete { 0 }
    user
  end
end
