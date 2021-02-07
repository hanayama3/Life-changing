require 'rails_helper'

RSpec.describe "Habits", type: :request do
  let(:user) { create(:user) }
  let(:habit) { create(:habit) }
  let(:habit_params) { attributes_for(:habit, user_id: user.id) }
  let(:invalid_habit_params) { attributes_for(:habit, task: "")}

  describe '#new' do
    context "ログイン済み" do
    before { sign_in habit.user }
    before { get new_habit_path }
      it 'リクエストが成功する' do
        expect(response.status).to eq 200
      end
      it 'タイトルが正しく表示されてる' do
        expect(response.body).to include("習慣の登録")
      end
    end
    context 'ログインしてない場合' do
      before { get new_habit_path }
      it 'rootにリダイレクトされる' do
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#create' do #修正 パラメーターが重複してる
    describe 'ログイン済み' do
      before { sign_in habit.user }
      context 'パラメーターが妥当な場合' do
        it 'リクエストが成功する事' do
          post habits_path, params: { habit: habit_params }
          expect(response.status).to eq 302
        end
        it 'createが成功する事' do
          expect do
          post habits_path, params: { habit: habit_params }
          end.to change(Habit, :count).by(1)
        end
        it 'habit.userのshowページへリダイレクトされる' do
          post habits_path, params: { habit: habit_params }
          expect(response).to redirect_to "/users/#{user.id}"
        end
      end
      context 'パラメーターが不正な場合' do
        it 'リクエストが成功する事' do
          post habits_path, params: { habit: invalid_habit_params }
          expect(response.status).to eq 200
        end
        it 'createが失敗する事' do
          expect do
          post habits_path, params: { habit: invalid_habit_params }
          end.to_not change(Habit, :count)
        end
        it 'エラーメッセージが表示される事' do
          post habits_path, params: { habit: invalid_habit_params }
          expect(response.body).to include 'タスクを入力してください'
        end
      end
    end
    describe 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        post habits_path, params: { habit: habit_params }
        expect(response).to redirect_to root_url
      end
    end
  end  
  describe "get #edit" do
    context 'ログイン済み' do
    before { sign_in habit.user }
    before { get edit_habit_path(habit) }
      it "リクエストが成功する" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されてる" do
        expect(response.body).to include("習慣の編集")
      end
    end
    context 'ログインしてない場合' do
      before { get edit_habit_path(habit) }
      it 'rootにリダレクトされる' do
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#update' do #修正 updateされた事になってるのかこれ？
    describe 'ログイン済み' do
      before { sign_in habit.user }
      before { habit_params = {task: '筋トレ', frequency: 3}
      patch "/habits/#{habit.id}", params: { habit: habit_params } }
      context 'パラメーターが妥当な場合' do
        it 'リクエストが成功する事' do
          expect(response.status).to eq 302
        end
        it '正常に更新されてる事' do
          expect(habit.reload.task).to eq '筋トレ'
        end
        it 'リダイレクトされること' do
          expect(response).to redirect_to "/users/#{habit.user.id}"
        end
      end
      context 'パラメーターが不正な場合' do
        before { sign_in habit.user }
        before { habit_params = {task: '', frequency: 3}
        patch "/habits/#{habit.id}", params: { habit: habit_params } }
        it 'エラーメッセージが表示されること' do
          expect(response.body).to include 'タスクを入力してください'
        end
      end
    end
    describe 'ログインしてない場合' do
      before { habit_params = {task: '筋トレ', frequency: 3}
      patch "/habits/#{habit.id}", params: { habit: habit_params } }
      it 'rootにリダイレクトされる' do
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#destory' do #修正 パラメーターが重複してる
    context 'ログイン済み' do
      before { sign_in habit.user }
      it '正常に削除されること' do
        expect do
        delete "/habits/#{habit.id}", params: { habit: habit_params }
        end.to change(Habit, :count).by(-1)
      end
      it 'リダイレクトされる事' do
        delete "/habits/#{habit.id}", params: { habit: habit_params }
        expect(response).to redirect_to "/users/#{habit.user.id}"
      end
    end
    context 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        delete "/habits/#{habit.id}", params: { habit: habit_params }
        is_expected.to redirect_to root_url
      end
    end
  end
end
