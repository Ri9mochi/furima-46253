require 'rails_helper'

RSpec.describe 'トップページ表示', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログアウト状態の場合' do
    it 'トップページに「新規登録」「ログイン」ボタンが表示される' do
      visit root_path
      expect(page).to have_link('新規登録', href: new_user_registration_path)
      expect(page).to have_link('ログイン', href: new_user_session_path)
    end

    it '「新規登録」ボタンをクリックすると新規登録ページに遷移する' do
      visit root_path
      click_link '新規登録'
      expect(current_path).to eq new_user_registration_path
    end

    it '「ログイン」ボタンをクリックするとログインページに遷移する' do
      visit root_path
      click_link 'ログイン'
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'ログイン状態の場合' do
    before do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
    end

    it 'トップページにユーザーのニックネームと「ログアウト」ボタンが表示される' do
      expect(page).to have_content(@user.nickname)
      expect(page).to have_link('ログアウト', href: destroy_user_session_path)
    end

    it '「ログアウト」ボタンをクリックするとログアウトできる' do
      click_link 'ログアウト'
      expect(current_path).to eq root_path
      expect(page).to have_link('ログイン', href: new_user_session_path)
    end
  end
end
