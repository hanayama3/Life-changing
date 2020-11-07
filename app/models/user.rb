class User < ApplicationRecord
 
 has_many :habits, dependent: :destroy
 
 has_many :active_relationships, class_name:  "Relationship",
                                foreign_key: "follower_id",
                                  dependent:   :destroy
 has_many :passive_relationships, class_name:  "Relationship",
                                foreign_key: "followed_id",
                                  dependent:   :destroy
 has_many :following, through: :active_relationships, source: :followed
 has_many :followers, through: :passive_relationships, source: :follower
  
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
 attachment :image
 
 validates :name, presence: true
 
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
 
  def level_up(user)
    @time = Time.current.strftime("%m/%d")
    @level = user.level += 1
    user.save!
    @data = Hash.new
    @data.store(@time,@level)
    binding.pry
  end
  
end
