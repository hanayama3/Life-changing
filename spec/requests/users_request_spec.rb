require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #index' do
    # let(:user) { create(:user) }
    # let(:other_user) { create(:other_user) }
    
    xit 'リクエストが成功すること' do
       get :index
       expect(response).to be_success
    end
  end
end
