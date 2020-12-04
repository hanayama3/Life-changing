FactoryBot.define do
  factory :habit do
    task {"ランニング"}
    frequency { 3 }
    user
  end
end
