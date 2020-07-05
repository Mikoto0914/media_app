require "rails_helper"

feature "post", type: :feature do
  
  given(:user)  { create(:user) }
  given(:user1) { create(:user1) }
  
  background  do
    Post.create!(user_id: user1.id, title: "test_title", content: "test_text", publish_flg: true)
  end

  feature "非ログイン状態" do
    scenario "新規投稿ボタンが表示されない" do
      visit root_path
      expect(page).to have_no_content("新規投稿")
    end
    
    scenario "ユーザの記事を見ることができるか" do
      visit root_path
      click_on("test_title")
      expect(page).to have_content("test_text")
    end
    
    scenario "いいねボタンが表示されていないか" do
      visit root_path
      click_on("test_title")
      expect(page).to have_no_button("thumb_up")
    end
    
    scenario "ストックボタンが表示されていないか" do
      visit root_path
      click_on("test_title")
      expect(page).to have_no_button("favorite_border")
    end
    
  end

  feature "ログイン状態" do
    background  do
      visit new_user_session_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_on("ログインする")
    end
  
    scenario "記事を投稿できるか" do
      expect {
        within ".hide-on-med-and-down" do
          click_on("新規投稿")
        end
        click_on("投稿する")
      }.to change{ Post.count }.by(1)
      expect(page).to have_content("無題の記事")
    end
    
    scenario "記事を投稿できるか" do
      within ".hide-on-med-and-down" do
        click_on("新規投稿")
      end
      click_on("投稿する")
      click_on("無題の記事")
      expect {
        click_on("削除")
        click_on("はい")
      }.to change{ Post.count }.by(-1)
    end
    
    scenario "記事にサムネイル画像を設定できるか" do
      within ".hide-on-med-and-down" do
        click_on("新規投稿")
      end
      attach_file("post_thumbnail_image", "#{Rails.root}/public/admin.png")
      click_on("投稿する")
      expect(page).to have_selector("img[src$='admin.png']")
    end
    
    scenario "記事をいいねできるか" do
      visit root_path
      click_on("test_title")
      expect(page).to have_button("thumb_up")
      expect {
          click_on("thumb_up")
      }.to change{ Like.count }.by(1)
    end
    
    scenario "記事のいいねを取り消せるか" do
      visit root_path
      click_on("test_title")
      click_on("thumb_up")
      expect(page).to have_button("done")
      expect {
          click_on("done")
      }.to change{ Like.count }.by(-1)
    end
    
    scenario "記事をストックできるか" do
      visit root_path
      click_on("test_title")
      expect(page).to have_button("favorite_border")
      expect {
          click_on("favorite_border")
      }.to change{ Stock.count }.by(1)
    end
    
    scenario "記事のストックを取り消せるか" do
      visit root_path
      click_on("test_title")
      click_on("favorite_border")
      expect(page).to have_button("favorite")
      expect {
          click_on("favorite")
      }.to change{ Stock.count }.by(-1)
    end
    
    scenario "記事にコメントできるか" do
      visit root_path
      click_on("test_title")
      fill_in "comment_content", with: "test_comment"
      click_on("コメントする")
      expect(page).to have_content("test_comment")
    end
    
    scenario "記事のコメントを削除できるか" do
      visit root_path
      click_on("test_title")
      fill_in "comment_content", with: "test_comment"
      click_on("コメントする")
      click_on("削除")
      expect(page).to have_no_content("test_comment")
    end
  end
end
