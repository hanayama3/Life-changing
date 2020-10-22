class User < ApplicationRecord
  
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
 attachment :image
 
 validates :name, presence: true
 
 has_many :habits, dependent: :destroy
end
