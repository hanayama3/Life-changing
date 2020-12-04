FactoryBot.define do
    factory :user do
        email {"kato@gmail.com"}
        name  {"加藤"}
        password {"password"}
        password_confirmation {"password"}
        level { 0 }
    end
    
end