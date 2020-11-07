User.create!(
name:  "hanayama",
email: "hanayamabmw@icloud.com",
password: "hanayama",
profile: "Rails余裕",
level: 10
)

10.times do |n|
date = Time.current.ago(10.days)
Record.create!(
level: n,
date: date.since(n.days),
user_id: 1
)
end

10.times do |n|
name = Faker::Name.name
email = Faker::Internet.email
password = "password"
level = 0
User.create!(
email: email,
password: password,
name: name,
level: level
)
end

10.times do |n|
task = ["勉強", "筋トレ", "瞑想", "断食", "ヨガ", "散歩","早寝早起き","片付け","日記","ランニング"]
frequency = rand(1..7)
user_id = n+1
Habit.create!(
task: task.sample,
frequency: frequency,
user_id: user_id
)
end

users = User.all
user  = users.first
# user_idが2~8までを格納
following = users[2..8]
# user_idが3から6までを格納
followers = users[3..6]

following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }