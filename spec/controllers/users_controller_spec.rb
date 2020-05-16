require "rails_helper"

RSpec.describe UsersController, type: :controller do

  before do
    @user = create(:user)
  end

  describe "GET #show" do

    it "正常なレスポンスか" do
      get :show, params: { id: @user }
      expect(response).to be_successful
    end

    it "200レスポンスが返ってくるか" do
      get :show, params: { id: @user }
      expect(response).to have_http_status(:success)
    end

    it 'showテンプレートで表示されること' do
      get :show, params: { id: @user }
      expect(response).to render_template :show
    end

    it '@userが取得できていること' do
      get :show, params: { id: @user }
      expect(assigns :user).to eq @user
    end
  end
end
