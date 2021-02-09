require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let(:user) { create(:user) }

  describe '#index' do
    subject { get "/"}
    context 'ログイン済み' do
      before {sign_in user}
      it 'リクエストが成功する事' do
        expect(subject). to eq 200
      end
      it 'ユーザー名が表示されていること' do
        subject
        expect(response.body).to include "加藤"
      end
    end
    context "ログインしてない場合" do
      it "孫正義の名言が表示されている事" do
        subject
        expect(response.body).to include "Decide which mountain to climb"
      end
    end
  end
end
