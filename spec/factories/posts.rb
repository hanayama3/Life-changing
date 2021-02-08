FactoryBot.define do
  factory :post do
     content {"Ruby楽しい"}
     user
  end
  factory :private_post, class: Post do
    content {"非公開投稿だよ"}
    private_content { true }
    user
  end
end
