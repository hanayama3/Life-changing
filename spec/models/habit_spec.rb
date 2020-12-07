require 'rails_helper'

RSpec.describe Habit, type: :model do
  let(:user) { create(:user) }
  let(:habit) { create(:habit) }

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
    it 'userはhabitモデルを6つ以上持てない' do
        6.times do |n|
         user.habits.create(task: "ランニング#{n}", frequency: 3)
        end
        expect(build(:habit, task: "筋トレ", user: user).save).to be_falsey
    end
    it "frequencyがnilの場合は保存できない" do
        habit.frequency = nil
        expect(habit).to_not be_valid
    end
  end
end
