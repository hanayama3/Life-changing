User.create!(
name:  "hanayama",
email: "hanayamabmw@icloud.com",
password: "hanayama",
profile: "Rails余裕",
level: 100
)

10.times do |n|
name = Faker::Name.name
email = Faker::Internet.email
password = "password"
level = rand(100)
User.create!(
email: email,
password: password,
name: name,
level: level
)
end