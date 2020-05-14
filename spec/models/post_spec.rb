require "rails_helper"

RSpec.describe Post, type: :model do
  
  before do
    @user = build(:user)
    @post = build(:post)
  end

  describe "バリデーション" do
    it "title,contentどちらも値が設定されていれば有効" do
      user = @user
      article = user.posts.build(
        title: "test_title",
        content: "test text",
        )
      expect(article).to be_valid
    end

    it "titleが空なら無効" do
      @post.title = ""
      expect(@post.valid?).to eq(false)
    end

    it "contentが空なら無効" do
      @post.content = ""
      expect(@post.valid?).to eq(false)
    end
  end

  describe "文字数制限" do
    it "titleのlengthが50文字より多いとエラーになる" do
      @post.title = "#{"あいうえお" * 11}"
      @post.valid?
      expect(@post.errors[:title]).to include("は50文字以下に設定して下さい。")
    end

    it "contentのlengthが5000文字以上だとエラーになる" do
      @post.content ="#{"あいうえお" * 1001}"
      @post.valid?
      expect(@post.errors[:content]).to include("は5000文字以下に設定して下さい。")
    end
  end

end
