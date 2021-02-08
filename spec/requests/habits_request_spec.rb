require 'rails_helper'

RSpec.describe "Habits", type: :request do
  let(:user) { create(:user) }
  let(:habit) { create(:habit) }
  let(:habit_params) { attributes_for(:habit, user_id: user.id) }
  let(:invalid_habit_params) { attributes_for(:habit, task: "")}

  describe '#new' do
    subject { get new_habit_path }
    context "ログイン済み" do
    before { sign_in habit.user }
      it 'リクエストが成功する' do
        expect(subject).to eq 200
      end
      it 'タイトルが正しく表示されてる' do
        subject
        expect(response.body).to include "習慣の登録"
      end
    end
    context 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        subject
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#create' do
    describe 'ログイン済み' do
      before { sign_in habit.user }
      context 'パラメーターが妥当な場合' do
      subject { post habits_path, params: { habit: habit_params } }
        it 'リクエストが成功する事' do
          expect(subject).to eq 302
        end
        it 'createが成功する事' do
          expect{subject}.to change(Habit, :count).by(1)
        end
        it 'userのshowページへリダイレクトされる' do
          subject
          expect(response).to redirect_to "/users/#{user.id}"
        end
      end
      context 'パラメーターが不正な場合' do
        subject { post habits_path, params: { habit: invalid_habit_params } }
        it 'リクエストが成功する事' do
          expect(subject).to eq 200
        end
        it 'createが失敗する事' do
          expect{subject}.to_not change(Habit, :count)
        end
        it 'エラーメッセージが表示される事' do
          subject
          expect(response.body).to include 'タスクを入力してください'
        end
      end
    end
    describe 'ログインしてない場合' do
      subject { post habits_path, params: { habit: habit_params } }
      it 'rootにリダイレクトされる' do
        subject
        expect(response).to redirect_to root_url
      end
    end
  end  
  describe "get #edit" do
    context 'ログイン済み' do
    before { sign_in habit.user }
    subject { get edit_habit_path(habit) }
      it "リクエストが成功する" do
        expect(subject).to eq 200
      end
      it "タイトルが正しく表示されてる" do
        subject
        expect(response.body).to include("習慣の編集")
      end
    end
    context 'ログインしてない場合' do
      subject { get edit_habit_path(habit) }
      it 'rootにリダレクトされる' do
        subject
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#update' do #修正 updateできてない
    describe 'ログイン済み' do
      before { sign_in habit.user }
      context 'パラメーターが妥当な場合' do
      subject { habit_params = {task: '筋トレ', frequency: 3}
      patch "/habits/#{habit.id}", params: { habit: habit_params } }
        it '正常に更新されてる事' do
          subject
          expect(habit.reload.task).to eq '筋トレ'
        end
        it 'リダイレクトされること' do
          subject
          expect(response).to redirect_to "/users/#{habit.user.id}"
        end
      end
      context 'パラメーターが不正な場合' do
        subject { habit_params = {task: '', frequency: 3}
        patch "/habits/#{habit.id}", params: { habit: habit_params } }
        it 'エラーメッセージが表示されること' do
          subject
          expect(response.body).to include 'タスクを入力してください'
        end
      end
    end
    describe 'ログインしてない場合' do
      subject { habit_params = {task: '筋トレ', frequency: 3}
      patch "/habits/#{habit.id}", params: { habit: habit_params } }
      it 'rootにリダイレクトされる' do
        subject
        is_expected.to redirect_to root_url
      end
    end
  end
  describe '#destory' do
  subject { delete "/habits/#{habit.id}", params: { habit: habit_params } }
    context 'ログイン済み' do
      before { sign_in habit.user }
      it '正常に削除されること' do
        expect{subject}.to change(Habit, :count).by(-1)
      end
      it 'リダイレクトされる事' do
        subject
        expect(response).to redirect_to "/users/#{habit.user.id}"
      end
    end
    context 'ログインしてない場合' do
      it 'rootにリダイレクトされる' do
        subject
        is_expected.to redirect_to root_url
      end
    end
  end
end
