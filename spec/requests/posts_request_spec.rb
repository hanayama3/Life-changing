require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:new_post) { create(:post) }
  let(:post_params) { attributes_for(:post, user_id: user.id) }
  let(:private_post_params) { attributes_for(:private_post, user_id: user.id) }
  let(:invalid_post_params) { attributes_for(:post, content: "")}

  describe '#index' do
    subject { get posts_path }
    describe 'ログイン済み' do
      before { sign_in new_post.user }
      it 'リクエストが成功する' do
        expect(subject).to eq 200
      end
      it 'タイトルが正しく表示されてる' do
        subject
        expect(response.body).to include "みんなの投稿"
      end
      it '投稿が正しく表示されてる' do
        subject
        expect(response.body).to include "Ruby楽しい"
      end
    end
    describe 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        subject
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#new' do
    subject { get new_post_path }
    describe 'ログイン済み' do
      before { sign_in new_post.user }
      it 'リクエストが成功する事' do
        expect(subject).to eq 200
      end
      it 'タイトルが正しく表示されてる' do
        subject
        expect(response.body).to include '投稿画面'
      end
    end
    describe 'ログインしてない場合' do
      subject { get new_post_path }
      it 'rootにリダイレクトされる' do
        subject
        expect(response).to redirect_to root_url
      end
    end
  end
  describe '#create' do
    describe 'ログイン済み' do
      before { sign_in new_post.user }
      context 'パラメーターが妥当な場合' do
      subject { post posts_path, params: { post: post_params } }
        it 'リクエストが成功する事' do    
          expect(subject).to eq 302
        end
        it 'createが成功する事' do
          expect{subject}.to change(Post, :count).by(1)
        end
        it '投稿一覧リダイレクトされる' do
          subject
          expect(response).to redirect_to posts_path
        end
      end
      context 'パラメーターが不正な場合' do
        subject { post posts_path, params: { post: invalid_post_params } }
        it 'リクエストが成功する事' do
          expect(subject).to eq 200
        end
        it 'createが失敗する事' do
          expect{subject}.to_not change(Post, :count)
        end
        it 'エラーメッセージが表示される事' do
          subject
          expect(response.body).to include '投稿文を入力してください'
        end
      end
    end
    describe 'ログインしてない場合' do
      subject { post posts_path, params: { post: post_params } }
      it 'rootにリダイレクトされる' do
        subject
        expect(response).to redirect_to root_url
      end
    end
  end
  describe '#destory' do
    subject { delete "/posts/#{new_post.id}", params: { post: post_params } }
    context 'ログイン済み' do
      before { sign_in new_post.user }
      it '正常に削除される事' do
        expect{subject}.to change(Post, :count).by(-1)
      end
      it 'リダイレクトされる事' do
        subject
        expect(response).to redirect_to posts_path
      end
    end
    context 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        subject
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#follow_users' do #修正
    subject { get "/posts/#{new_post.user.id}/follow_users" }
    context 'ログイン済み' do
    before { sign_in new_post.user }
      it 'リクエストが成功する事' do
        expect(subject).to eq 200
      end
      it 'タイトルが正しく表示されてる事' do
        subject
        expect(response.body).to include "フォロー中のユーザー"
      end
    end
    context 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        subject
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#private_content' do
    subject { get "/posts/#{new_post.user.id}/private_content" }
    describe 'ログイン済み' do
      before { sign_in new_post.user }
      context '非公開投稿がない場合' do
        it 'リクエストが成功する' do
          expect(subject).to eq 200
        end
        it 'タイトルが正しく表示されている' do
          subject
          expect(response.body).to include "非公開の投稿はありません"
        end 
      end
      context '非公開投稿がある場合' do
        before { new_post.user.posts.create(private_post_params) }
        it '非公開投稿が表示されている' do
          subject
          expect(response.body).to include '非公開投稿だよ'
        end
      end
      context '他人の非公開投稿を見ようとした場合' do #200が返ってきてる
        subject { get "/posts/#{other_user.id}/private_content" }
        it 'rootにリダイレクトされる' do
          expect(subject).to redirect_to root_url
        end
      end
    end
    describe 'ログインしてない' do
      it 'rootにリダレクトされる' do
        subject
        is_expected.to redirect_to root_url
      end
    end
  end
end