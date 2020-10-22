User.create!(
name:  "hanayama",
email: "hanayamabmw@icloud.com",
password: "hanayama",
profile: "Rails余裕",
level: 300
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

Habit.create!(
task: "ランニング",
frequency: 3,
user_id: 1
)
