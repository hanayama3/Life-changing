require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }

  describe "#index" do
    subject { get "/notifications" }
    describe 'ログイン済み' do
      before { sign_in user }
      context '通知がない場合' do
        it 'リクエストが成功する事' do
          expect(subject).to eq 200
        end
        it 'タイトルが正しく表示されている' do
          subject
          expect(response.body).to include "通知はありません"
        end
      end
      context '通知がある場合' do
        before { user.passive_notifications.create(visitor_id: other_user.id, action: "lose") }
        it 'リクエストが成功する事' do
          expect(subject).to eq 200
        end 
        it '通知が正しく表示されている' do
          subject
          expect(response.body).to include "習慣を実行できませんでした。"
        end
      end
    end
    describe 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        subject
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#destory' do
    # subject { delete "/notifications/#{user.id}", params: { notification: visitor_id: other_user.id, action: "lose" } }
    context 'ユーザーが通知を削除した場合' do
      before before { user.passive_notifications.create(visitor_id: other_user.id, action: "lose") }
      xit '正常に削除される' do
        # binding.pry
        expect{subject}.to change(Notification, :count).by(-1)
      end
    end
  end
end
