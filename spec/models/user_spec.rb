require "rails_helper"

RSpec.describe User, type: :model do
    
  before do 
    @user = build(:user)
  end

  describe "バリデーション" do
    it "name,email,passwordどちらも値が設定されていれば有効" do
      expect(@user.valid?).to eq(true)
    end

    it "nameが空なら無効" do
      @user.name = ""
      expect(@user.valid?).to eq(false)
    end
  end
  
  describe "文字数制限" do
    it "nameのlengthが16文字より多いとエラーになる" do
      @user.name = "#{"あいうえお" * 4}"
      @user.valid?
      expect(@user.errors[:name]).to include("は16文字以下に設定して下さい。")
    end
    
    it "profileのlengthが255文字より多いとエラーになる" do
      @user.profile = "#{"あいうえお" * 52}"
      @user.valid?
      expect(@user.errors[:profile]).to include("は255文字以下に設定して下さい。")
    end
  end
  
end
