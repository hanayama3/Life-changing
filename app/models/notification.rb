class Notification < ApplicationRecord
include Desc

belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id'
belongs_to :visited, class_name: 'User', foreign_key: 'visited_id'
end

