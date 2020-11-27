class Post < ApplicationRecord
 include Desc
 
 belongs_to :user
 validates :content, presence: true, length: {maximum: 120}
end