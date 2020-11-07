class Record < ApplicationRecord
validates :level,presence: true
validates :date, presence: true

belongs_to :user
end
