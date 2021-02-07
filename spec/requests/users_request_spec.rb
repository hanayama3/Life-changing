require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, name: "")}
  
  describe '#index' do
    context 'ログイン済み' do
    before { sign_in user }
    before { get '/users'}
      it 'リクエストが成功する事' do
        expect(response.status).to eq 200
      end
      it 'ユーザー名が表示されてる事' do
        expect(response.body).to include(user.name)
      end
    end
    context 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        get '/users'
        is_expected.to redirect_to root_url
      end
    end
  end
  describe "#show" do
    context "ログイン済みで自分の詳細ページにアクセスした場合" do
      before { sign_in user}
      before { user.habits.create(task: "筋トレ", frequency: 3) }
      before { get "/users/#{user.id}" }
      it 'リクエストが成功する事' do
        expect(response.status).to eq 200
      end
      it 'ユーザー名が表示されてる事' do
        expect(response.body).to include(user.name)
      end
      it 'ユーザーの習慣が表示されてる事' do
        task = user.habits.map(&:task)
        expect(response.body).to include(task.first)
      end
      it '変更リンクがある事' do
        expect(response.body).to include("変更")
      end
    end    
    context 'ログイン済みで他人の詳細ページにアクセスした場合' do
      before { get "/users/#{other_user.id}" }
      it '変更リンクがない事' do
        expect(response.body).to_not include("変更")
      end
      it 'ユーザーが存在しない場合' do
        user.destroy
        expect{ get "/users/#{user.id}" }.to raise_error ActiveRecord::RecordNotFound
      end
    end  
    context 'ログインしてない場合' do
    before { get "/users/#{user.id}" }
      it 'rootにリダイレクトされる' do
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#new' do
    before { get new_user_registration_path }
    it 'リクエストが成功する事' do
      expect(response.status).to eq 200
    end
    it 'タイトルが正しく表示されてる事' do
      expect(response.body).to include 'ユーザー登録'
    end
  end
 describe '#create' do
  context 'パラメータが妥当な場合' do
    it 'リクエストが成功すること' do
      post user_registration_path, params: { user: user_params }
      expect(response.status).to eq 302
    end
    it 'createが成功する事' do
      expect do
      post user_registration_path, params: { user: user_params }
      end.to change(User, :count).by(1)
    end
    it 'リダイレクトされること' do
      post user_registration_path, params: { user: user_params }
      expect(response).to redirect_to root_url
    end
  end
  context 'パラメーターが不正な場合' do
    it 'リクエストが成功すること' do
      post user_registration_path, params: { user: invalid_user_params }
      expect(response.status).to eq 200
    end
    it 'createが失敗すること' do
      expect do
        post user_registration_path, params: { user: invalid_user_params }
        end.to_not change(User, :count)
    end
    it 'エラーメッセージが表示されること' do
      post user_registration_path, params: { user: invalid_user_params }
      expect(response.body).to include '名前を入力してください'
    end
  end
end
  describe '#edit' do
    context 'ログイン済み' do
      before { sign_in user }
      before { get edit_user_registration_path }
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
    end
    context 'ログインしてないユーザーの場合' do
      before { get edit_user_registration_path }
      it 'リダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  describe '#update' do #修正 パラメーターを送り更新されてるかテストしたい
    before { sign_in user }
    context 'パラメーターが妥当な場合' do      
      xit '正常に更新される' do
        user.name = "拓也"
        expect(user.save).to be_truthy
      end
    end
    context 'パラメーターが不正な場合' do  
      xit '更新されない' do
        user.name = ""
        expect(user.save).to be_falsey
      end
    end
  end
  describe '#following/#followers' do
    describe 'ログイン済み' do
      before { sign_in user }        
      context '#following' do
        before { user.follow(other_user) }
        it 'リクエストが成功する(following)' do
          get "/users/#{user.id}/following"
          expect(response.status).to eq 200
        end
        it 'フォローしてるユーザーが表示される' do
          get "/users/#{user.id}/following"
          expect(response.body).to include(other_user.name)
        end
      end
      context '#followers' do
        before { other_user.follow(user) }
        it 'リクエストが成功する(followers)' do
          get "/users/#{user.id}/followers"
          expect(response.status).to eq 200
        end
        it 'フォローされてるユーザーが表示される' do
          get "/users/#{user.id}/followers"
          expect(response.body).to include(other_user.name)
        end
      end
    end   
    describe 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        get "/users/#{user.id}/following"
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#mission' do
    describe 'ログイン済み' do
      before { sign_in user }
      context 'ユーザーが習慣を登録してる場合' do
        before { user.habits.create!(task: "筋トレ", frequency: 3) }
        before { get "/users/#{user.id}/mission" }
        it 'リクエストが成功する' do
          expect(response.status).to eq 200
        end
        it 'タイトルが正しく表示されてる' do
          expect(response.body).to include '記録'
        end
        it 'ユーザーの習慣が表示されてる' do
          task = user.habits.map(&:task)
          expect(response.body).to include(task.first)
        end
      end
      context 'ユーザーが習慣を登録してない場合' do
        before { get "/users/#{user.id}/mission" }
        it 'リクエストが成功する' do
          expect(response.status).to eq 200
        end
        it 'タイトルが正しく表示されてる' do
          expect(response.body).to include '現在登録されている習慣はありません'
        end
      end
    end
    describe 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        get "/users/#{user.id}/mission"
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#complete' do #修正 パラメーターを送り更新されてるかテスト
    before { sign_in user }
    context 'パラメーターが妥当な場合' do
      xit 'ユーザーの詳細ページにリダイレクトされる' do
      end
    end
  end
end
