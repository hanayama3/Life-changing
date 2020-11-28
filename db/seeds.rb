User.create!(
name:  "花山",
email: "hanayamabmw@icloud.com",
password: "hanayama",
profile: "花山薫です",
level: 100
)

Post.create!(
content: "プログラミング楽しい",
user_id: 1,
private: true
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
email = Faker::Internet.email
password = "password"
name = Faker::Name.name
level = rand(1..30)
User.create!(
email: email,
password: password,
name: name,
level: level
)
end

10.times do |n|
 content = Faker::Lorem.sentence(word_count: 5)
 user_id = rand(1..9)
 Post.create!(
 content: content,
 user_id: user_id
)
end

10.times do |n|
task = ["勉強", "筋トレ", "瞑想", "断食", "ヨガ", "散歩","早寝早起き","片付け","日記","ランニング"]
frequency = rand(1..7)
complete = rand(1..3)
end_time = Time.current.since(1.days)
user_id = n + 1
Habit.create!(
task: task.sample,
frequency: frequency,
complete: complete,
end_time: end_time,
user_id: user_id
)
end

users = User.all
user  = users.first
following = users[2..8]
followers = users[3..6]

following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }