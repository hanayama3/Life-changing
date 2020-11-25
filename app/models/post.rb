class Post < ApplicationRecord
 include Desc
 
 belongs_to :user
 validates :content, length: {maximum: 80}
end
