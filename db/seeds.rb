User.create!(
name:  "ぎん",
email: "hanayamabmw@icloud.com",
password: "hanayama",
level: 30
)

%w(筋トレ ランニング 朝に野菜ジュース).each do |task|
Habit.create!(
task: task,
frequency: 7,
complete: rand(1..3),
end_time: Time.current.since(7.days),
user_id: 1
)
end


Post.create!(
content: "プログラミング楽しい",
user_id: 1,
private_content: false
)

10.times do |n|
date = Date.current.ago(10.days)
if n == 9
level = 30
else
level = n + rand(4)
end
Record.create!(
level: level,
date: date.since(n.days),
user_id: 1
)
end

10.times do |n|
email = Faker::Internet.email
password = "password"
name = Faker::Name.name
level = rand(1..15)
User.create!(
email: email,
password: password,
name: name,
level: level
)
end

10.times do |u|
date = Date.current.ago(10.days)
user_id = 2 + u
10.times do |n|
Record.create!(
level: n + rand(3),
date: date.since(n.days),
user_id: user_id
)
end
end

10.times do |n|
task = ["勉強", "瞑想", "断食", "ヨガ", "散歩","早寝早起き","片付け","日記","親孝行"]
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