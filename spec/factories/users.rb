FactoryBot.define do
    factory :user do
        sequence(:email) { |n| "kato#{n}@gmail.com"}
        name  {"加藤"}
        password {"password"}
        password_confirmation {"password"}
        level { 0 }
    end
    factory :other_user, class: User do
        email {"tanaka@gmail.com"}
        name  {"田中"}
        password {"password"}
        password_confirmation {"password"}
        level { 0 }
    end
    
end