require 'rails_helper'

RSpec.describe User, type: :model do
let(:user) { create(:user) }
let(:other_user) { create(:user, email: "tanaka@gmail.com",name: "田中")}

describe '関連テーブル削除テスト' do
 it 'userを削除するとuserのpostテーブルも削除される' do
     user.posts.create(content: "RSpec")
     expect{ user.destroy }.to change{ Post.count }.by(-1) 
 end
 it 'userを削除するとuserのhabitテーブルも削除される' do
     user.habits.create(task: "筋トレ", frequency: 3)
     expect{ user.destroy }.to change{ Habit.count }.by(-1)
 end
 it 'userを削除するとuserのrecordテーブルも削除される' do
     user.records.create(level: 10, date: Date.current)
     expect{ user.destroy }.to change{ Record.count }.by(-1)
 end
 it 'userを削除するとuserと関連するrelationshipテーブルも削除される' do
     user.active_relationships.create(followed_id: other_user.id)
     expect{ user.destroy }.to change{ Relationship.count }.by(-1)
 end
 it 'userを削除するとuserと関連するnotificationテーブルも削除される' do
     user.active_notifications.create(visited_id: other_user.id)
     expect{ user.destroy }.to change{ Notification.count }.by(-1)
 end
 end
 
describe 'バリデーション' do
  it 'userのprofileが80字以上の場合' do
      user.profile = "a" * 81
      expect(user).to_not be_valid
  end
  it 'userのnameが空の場合' do
      user.name = ""
      expect(user).to_not be_valid
  end
end
 
describe '#record' do
  context 'userのlevelが上がった場合' do
  it 'recordモデルが生成される' do
      expect{user.record(1)}.to change{ Record.count }.by(1)
  end
  end
  context 'userのlevelが下がった場合でfollowerがいない場合' do
  it 'recordモデルが生成される' do
      expect{user.record(-1)}.to change{ Record.count }.by(1)
  end
  end
  # context 'userのlevelが下がった時でfollowerがいる場合' do
  # it 'recordモデルとnotificationモデルが生成される' do
  #     #Relationshipテーブルは作成できてる
  #     Relationship.create(follower_id: other_user.id, followed_id: user.id)
  #     # binding.pry
  #     expect{user.record(-1)}.to change{ Record.count }.by(1).and change{ Notification.count }.by(1)
  # end
  # end
  
end

end
