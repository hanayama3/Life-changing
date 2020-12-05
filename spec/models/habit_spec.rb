require 'rails_helper'

RSpec.describe Habit, type: :model do
  let(:user){ create(:user) }
  let(:otehr_user) { create(:otehr_user) }
  let(:habit)  { create(:habit) }
  # given!(:habits) { 6.time.collect { |n| create(:habit, task: "ランニング#{n}")}}


  describe 'バリデーション' do
    it 'taskが空の場合は保存できない' do
        habit.task = ""
        expect(habit).to_not be_valid
    end
    it 'taskが12文字以上の場合保存できない' do
        habit.task = "a" * 13
        expect(habit).to_not be_valid
    end
    it 'userは同じtaskカラムを持つhabitモデルを保存できない' do
        expect(build(:habit, task: "ランニング", user: user).save).to be_truthy
        expect(build(:habit, task: "ランニング", user: user).save).to be_falsey
    end
    xit 'userはhabitモデルを6つ以上持てない' do
       
    end
    it "frequencyがnilの場合は保存できない" do
        habit.frequency = nil
        expect(habit).to_not be_valid
    end
  end
end
