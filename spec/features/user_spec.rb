require "rails_helper"

feature "user", type: :feature do

  feature "ユーザー登録前" do
    scenario "新規登録できるか" do
      visit root_path
      expect {
        within ".grid-6" do
          click_on("新規登録")
        end
        fill_in "user_name", with: "test0"
        fill_in "user_email", with: "test0@example.com"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
        click_on("登録する")
      }.to change{ User.count }.by(1)
    end
    
    scenario "ログインできないか" do
      visit root_path
      within ".grid-6" do
        click_on("ログイン")
      end
      fill_in "user_email", with: "test0@example.com"
      fill_in "user_password", with: "password"
      click_on("ログインする")
      expect(page).to have_no_content "ログアウト"
    end
  end
    
  feature "ユーザー登録後" do
    given(:user) { create(:user) }
    
    background  do
      visit new_user_session_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_on("ログインする")
    end
    
    scenario "ログインできるか" do
      expect(page).to have_content("ログアウト")
    end
    
    scenario "マイページへ遷移できるか" do
      visit root_path
      click_on("arrow_drop_down")
      within ".dropdown-content" do
        click_on("マイページ")
      end
      expect(current_path).to eq "/users/#{user.id}"
    end
    
    scenario "名前を変更できるか" do
      visit root_path
      click_on("arrow_drop_down")
      within ".dropdown-content" do
        click_on("アカウント設定")
      end
      click_on("プロフィール編集")
      fill_in "user_name", with: "newname"
      click_on("変更する")
      visit users_profile_edit_path
      expect(page).to have_content("newname")
    end
      
    scenario "アイコンを変更できるか" do
      visit "/users/edit"
      click_on("プロフィール編集")
      attach_file("user_image", "#{Rails.root}/public/admin.png")
      click_on("変更する")
      visit users_profile_edit_path
      expect(page).to have_selector("img[src$='admin.png']")
    end
    
    scenario "プロフィールを変更できるか" do
      visit "/users/edit"
      click_on("プロフィール編集")
      fill_in "user_profile", with: "profile-test"
      click_on("変更する")
      visit users_profile_edit_path
      expect(page).to have_content("profile-test")
    end
    
    scenario "パスワードを変更できるか" do
      visit "/users/edit"
      fill_in "user_password", with: "123456"
      fill_in "user_current_password", with: "password"
      click_on("パスワードを変更する")
      expect(current_path).to eq root_path
    end
  
    scenario "アカウント削除できるか" do
      visit "/users/edit"
      expect {
        click_on("削除する")
        click_on("はい")
      }.to change{ User.count }.by(-1)
    end
  end
  
  feature "ユーザー共通操作" do
    given(:user1) { create(:user1) }
    
    scenario "他ユーザーのマイページへ遷移できるか" do
      visit "/users/#{user1.id}"
      expect(page).to have_content(user1.name)
    end
  end
end
