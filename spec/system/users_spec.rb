require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  it "ログインしていない状態でトップページにアクセスした場合、サインページに遷移する" do
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
  end
  it "ログインに成功し、トップページに遷移する" do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # サインページに移動する
    visit new_user_session_path
    # ログインしていない場合、サインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
    # すでに保存されいているユーザーのemailとpasswordを入力する
    fill_in "user_email",	with: @user.email
    fill_in "user_password", with: @user.password
    # ログインボタンをクリックする
    click_on ("Log in")
    # トップページに遷移していることを確認する
    expect(current_path).to eq(root_path)
  end

  it "ログインに失敗し、再びサインページに戻ってくる" do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインページに遷移している事を確認する
    expect(current_path).to eq(new_user_session_path)
    # 誤ったユーザー情報を入力する
    fill_in "user_email",	with: "sample"
    fill_in "user_password", with: "sample"
    # ログインボタンをクリックする
    click_on("Log in")
    # サインページに戻ってきていることを確認する
    expect(current_path).to eq(new_user_session_path)
  end
end
