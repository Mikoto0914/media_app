require 'rails_helper'

feature 'post', type: :feature do
  
  given(:user) { create(:user) }

  feature '非ログイン状態' do
    scenario '新規投稿ボタンが表示されない' do
      visit root_path
      expect(page).to have_no_content('新規投稿')
    end
  end

  feature 'ログイン状態' do
    background  do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on("ログインする")
    end
  
    scenario '記事を投稿できるか' do
      visit root_path
      expect(page).to have_content('新規投稿')
      expect {
        click_on("新規投稿")
        click_on("投稿する")
      }.to change{ Post.count }.by(1)
    end
    
    scenario '投稿した記事を削除できるか' do
      visit root_path
      click_on("新規投稿")
      click_on("投稿する")
      click_link '無題の記事'
      expect {
        click_on("削除")
        click_on("はい")
      }.to change{ Post.count }.by(-1)
    end
    
  end
  
end
