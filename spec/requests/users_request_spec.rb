require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, name: "")}
  
  describe 'GET #index' do

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

describe 'POST #create' do
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
    it 'エラーが表示されること' do
      post user_registration_path, params: { user: invalid_user_params }
      expect(response.body).to include '名前を入力してください'
    end
  end
end
  
  describe 'GET #edit' do
    subject { get edit_user_registration_path }
    context 'ログイン済み' do
      before { sign_in user }
      it 'リクエストが成功すること' do
        is_expected.to eq 200
      end
    end
    context 'ゲストの場合' do
      it 'リダイレクトされること' do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end
  
  describe 'GET #show' do
    context 'ログイン済みでユーザーが存在する' do
      before { sign_in user }
      before { get "/users/#{user.id}" }
      
      it 'リクエストが成功する事' do
        expect(response.status).to eq 200
      end
      it 'ログイン済みでユーザーが存在しない場合' do
        user.destroy
        expect{ get "/users/#{user.id}" }.to raise_error ActiveRecord::RecordNotFound
      end
    end
    context 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        get "/users/#{user.id}"
        is_expected.to redirect_to root_url
      end
    end
  end

  describe '#following/#followers' do

    context 'ログインしてる場合' do
      before { sign_in user }
      before { user.follow(other_user) }
      before { other_user.follow(user) }

      it 'リクエストが成功する(following)' do
        get "/users/#{user.id}/following"
        expect(response.status).to eq 200
      end
      it 'フォローしてるユーザーが表示される' do
        get "/users/#{user.id}/following"
        expect(response.body).to include(other_user.name)
      end
      it 'リクエストが成功する(followers)' do
        get "/users/#{user.id}/followers"
        expect(response.status).to eq 200
      end
      it 'フォローしてくれてるユーザーが表示される' do
        get "/users/#{user.id}/followers"
        expect(response.body).to include(other_user.name)
      end
    end
    context 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        get "/users/#{user.id}/following"
        is_expected.to redirect_to root_url
      end
    end
  end
  
  end
