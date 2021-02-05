require 'rails_helper'

RSpec.describe Record, type: :model do
  let(:record) { create(:record) }

  describe 'バリデーション' do
    it "levelがnilの場合保存できない" do
      record.level = nil
      expect(record).to_not be_valid
    end
    it 'dateがnilの場合保存できない' do
      record.date = nil
      expect(record).to_not be_valid
    end  
  end
end
