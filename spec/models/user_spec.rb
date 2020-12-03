require 'rails_helper'

RSpec.describe User, type: :model do
let(:user) { create(:user) }
let(:other_user) { create(:user, email: "tanaka@gmail.com",name: "田中")}

describe '関連テーブル削除テスト' do
 it 'userを削除するとuserのpostが削除される' do
     user.posts.create(content: "RSpec")
     expect{ user.destroy }.to change{ Post.count }.by(-1) 
 end
 it 'userを削除するとuserのhabitが削除される' do
     user.habits.create(task: "筋トレ", frequency: 3)
     expect{ user.destroy }.to change{ Habit.count }.by(-1)
 end
 it 'userを削除するとuserのrecordが削除される' do
     user.records.create(level: 10, date: Date.current)
     expect{ user.destroy }.to change{ Record.count }.by(-1)
 end
#  it 'userを削除するとuserと関連するrelationshipが削除される' do
#      user.active_relationships.create(followed_id: other_user)
#      expect{ user.destroy }.to change{ Relationship.count }.by(-1)
#  end
end
end
