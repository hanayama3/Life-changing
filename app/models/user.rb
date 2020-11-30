class User < ApplicationRecord

 has_many :habits, dependent: :destroy
 has_many :records, dependent: :destroy
 has_many :posts, dependent: :destroy

 has_many :active_relationships, class_name:  "Relationship",
                                foreign_key: "follower_id",
                                  dependent:   :destroy
 has_many :passive_relationships, class_name:  "Relationship",
                                 foreign_key: "followed_id",
                                   dependent:   :destroy
 has_many :following, through: :active_relationships, source: :followed
 has_many :followers, through: :passive_relationships, source: :follower
 
 has_many :active_notifications, class_name: 'Notification',
                                 foreign_key: 'visitor_id',
                                 dependent: :destroy
 has_many :passive_notifications, class_name: 'Notification',
                                  foreign_key: 'visited_id',
                                  dependent: :destroy
  
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
 attachment :image
 
 validates :name, presence: true
 validates :profile, length: {maximum: 80}

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
  
  def self.guest
      find_or_create_by!(name: "ゲスト", email: 'guest@gmail.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
  
 def record(before_level)
  after_level = self.level
  date = Date.current
  if before_level < after_level
    self.records.create(level: after_level,date: date)
  elsif before_level > after_level
    self.records.create(level: after_level,date: date)
    self.followers.each do |f|
      Notification.create(visitor_id: self.id,visited_id: f.id, action: "lose")
  end
end
end

end
