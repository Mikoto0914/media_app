FactoryBot.define do
  factory :user do
    name { "test1" }
    password { "password" }
    password_confirmation { "password" }
    email { "test@example.com" }
    image { open("#{Rails.root}/public/admin.png") }
    profile { "管理人：本サービスで登録されたユーザの情報を確認、編集ができる。"}
  end
end
