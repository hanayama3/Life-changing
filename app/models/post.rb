class Post < ApplicationRecord
 include Desc
 
 belongs_to :user
#  validates :content, {length: {minimum: 6}}
end
