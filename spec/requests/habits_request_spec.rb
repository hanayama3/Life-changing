require 'rails_helper'

RSpec.describe "Habits", type: :request do
  let(:user) { create(:user) }
  let(:habit) { create(:habit) }
  let(:habit_params) { attributes_for(:habit, user_id: user.id) }
  let(:invalid_habit_params) { attributes_for(:habit, task: "")}

  describe 'ログイン済み' do
  before { sign_in habit.user }
    context "get #new" do
    before { get new_habit_path }
      it 'リクエストが成功する' do
        expect(response.status).to eq 200
      end
      it 'タイトルが正しく表示されてる' do
        expect(response.body).to include("習慣の登録")
      end
    end
    context 'POST #create' do
      it 'リクエストが成功すること' do
        post habits_path, params: { habit: habit_params }
        expect(response.status).to eq 302
      end
      it 'createが成功する事' do
        expect do
        post habits_path, params: { habit: habit_params }
        end.to change(Habit, :count).by(1)
      end
      xit 'habit.userのshoeページへリダイレクトされる' do
        post habits_path, params: { habit: habit_params }
        expect(response).to redirect_to user_path(habit.user)
      end
    end
    context "get #edit" do
    before { get edit_habit_path(habit) }
      it "リクエストが成功する" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されてる" do
        expect(response.body).to include("習慣の編集")
      end
      it "" do
      end
    end
  end
  describe 'ログインしてない場合' do
    context "習慣登録ページへ推移されない"do
    before { get new_habit_path }
      it 'rootにリダイレクトされる' do
        is_expected.to redirect_to root_url
      end
    end
    context "習慣編集ページへ推移されない" do
    before { get edit_habit_path(habit) }
      it "rootにリダイレクトされる" do
        is_expected.to redirect_to root_url
      end
    end
  end
end
