require "rails_helper"

feature "post", type: :feature do
  given(:user) { create(:user) }
  
  background  do
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_on("ログインする")
    click_on("新規投稿")
    click_on("投稿する")
    click_on("arrow_drop_down")
    click_on("ログアウト")
  end

  feature "ログイン前" do
    scenario "新規投稿ボタンが表示されない" do
      visit root_path
      expect(page).to have_no_content("新規投稿")
    end
    
    scenario "他ユーザーの記事が見れるか" do
      visit root_path
      click_link("無題の記事")
      expect(page).to have_content("ここに本文を入力してください")
    end
    
    scenario "他ユーザーの記事を詳細表示した際、いいねボタンが表示されない" do
      visit root_path
      click_link ("無題の記事")
      expect(page).to have_no_button("thumb_up")
    end
    
    scenario "他ユーザーの記事を詳細表示した際、お気に入りボタンが表示されない" do
      visit root_path
      click_link ("無題の記事")
      expect(page).to have_no_button("favorite")
    end
  end
    
  feature "ログイン後" do
    given(:user1) { create(:user1) }
    
    background  do
      visit new_user_session_path
      fill_in "user_email", with: user1.email
      fill_in "user_password", with: user1.password
      click_on("ログインする")
    end
  
    scenario "新しい記事を投稿できるか" do
      visit root_path
      expect(page).to have_content("新規投稿")
      expect {
        click_on("新規投稿")
        click_on("投稿する")
      }.to change{ Post.count }.by(1)
    end
    
    scenario "非公開の記事が下書一覧に表示されるか" do
      visit root_path
      click_on("新規投稿")
      click_on("arrow_drop_down")
      click_on("下書き一覧")
      expect(page).to have_link("無題の記事")
    end
    
    scenario "投稿した記事を削除できるか" do
      visit root_path
      click_on("新規投稿")
      click_on("投稿する")
      click_link "無題の記事"
      expect {
        click_on("削除")
        click_on("はい")
      }.to change{ Post.count }.by(-1)
    end
    
    scenario "他ユーザーの記事にいいねできるか" do
      visit root_path
      click_link("無題の記事")
      expect {
        click_on("thumb_up")
      }.to change{ Like.count }.by(1)
    end
    
    scenario "いいねした記事がユーザーランキングに表示されるか" do
      visit root_path
      click_link("無題の記事")
      click_on("thumb_up")
      visit root_path
      expect(page).to have_link(user.name)
    end
    
    scenario "他ユーザーの記事をストックできるか" do
      visit root_path
      click_link("無題の記事")
      expect {
        click_on("favorite")
      }.to change{ Stock.count }.by(1)
    end
    
    scenario "ストックした記事がお気に入り一覧に表示されるか" do
      visit root_path
      click_link("無題の記事")
      click_on("favorite")
      visit users_favorite_path
      expect(page).to have_link("無題の記事")
    end
  end
  
  feature "ユーザー共通操作" do
    scenario "記事検索ができるか" do
      visit root_path
      fill_in "search", with: "無題"
      click_on("検索")
      expect(page).to have_content("無題の記事")
    end
  end
end
