require 'rails_helper'

RSpec.describe Habit, type: :model do
  let(:user) { habit.user }
  let(:habit)  { create(:habit) }
#   let(:habit2)  { create(:habit, :habit2) }
  
  describe 'バリデーション' do
    it 'taskが空の場合は保存できない' do
      habit.task = ""
      expect(habit).to_not be_valid
    end
    it 'taskが12文字以上の場合保存できない' do
      habit.task = "a" * 13
      expect(habit).to_not be_valid
    end
    xit 'userは同じtaskを保存できない' do
      expect(habit.save!).to be_truthy
      expect(habit2.save).to be_falsey 
    end
    xit 'userはhabitモデルを6つ以上持てない' do
      
    end
    it "frequencyが空の場合は保存できない" do
      habit.frequency = nil
      expect(habit).to_not be_valid
    end
  end
end
