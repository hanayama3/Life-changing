require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }
  
  describe 'バリデーション' do
    it 'contentが空の場合保存できない' do
      post.content = ""
      expect(post).to_not be_valid
  end
    it 'contentが120文字以上だと保存できない' do
      post.content = "a" * 121
      expect(post).to_not be_valid
    end
  end
end
