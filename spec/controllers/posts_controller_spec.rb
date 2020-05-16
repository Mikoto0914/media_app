require "rails_helper"

RSpec.describe PostsController, type: :controller do

  describe "GET #index" do
    it "正常なレスポンスか" do
      get :index
      expect(response).to be_successful
    end

    it "200レスポンスが返ってくるか" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it ":indexテンプレートをレンダリングしているか" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before do
      user = create(:user)
      @post = create(:post, user: user)
    end

    it "正常なレスポンスか" do
      get :show, params: { id: @post }
      expect(response).to be_successful
    end

    it "200レスポンスが返ってくるか" do
      get :show, params: { id: @post }
      expect(response).to have_http_status(:success)
    end

    it ":indexテンプレートをレンダリングしているか" do
      get :show, params: { id: @post }
      expect(response).to render_template :show
    end

    it "@postが期待される値を持つ" do
      get :show, params: { id: @post }
      expect(assigns(:post)).to eq @post
    end
  end
end
