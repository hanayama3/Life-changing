require 'rails_helper'

RSpec.describe "Posts", type: :request do
let(:post) { create(:post) }

describe 'ログイン済み' do
  before { sign_in post.user }
  
  context "投稿一覧ページが正しく表示される" do
  before { get posts_path }
      
  it 'リクエストが成功する' do
    expect(response.status).to eq 200
  end
  it 'タイトルが正しく表示されてる' do
    expect(response.body).to include("みんなの投稿")
  end
  end
end
describe 'ログインしてない場合' do
  context "投稿一覧ページへ推移されない" do
     before { get posts_path }
  
  it 'rootにリダイレクトされる' do
    is_expected.to redirect_to root_url
  end
 end
end

end
