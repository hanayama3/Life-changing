User.create!(
name:  "hanayama",
email: "hanayamabmw@icloud.com",
password: "hanayama",
profile: "Rails余裕",
level: 10
)

Post.create!(
content: "転職できる気しかしない",
private: true,
user_id: 1
)

10.times do |n|
date = Date.current.ago(10.days)
Record.create!(
level: rand(10),
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
complete = 0
start_time = Time.current
end_time = Time.current.since(1.days)
Habit.create!(
task: task.sample,
frequency: frequency,
user_id: user_id,
complete: complete,
end_time: end_time
)
end

users = User.all
user  = users.first
following = users[2..8]
followers = users[3..6]

following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }