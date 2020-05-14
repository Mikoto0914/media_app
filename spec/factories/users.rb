FactoryBot.define do
  factory :user do
    name { "test1" }
    password { "password" }
    password_confirmation { "password" }
    email { "test@example.com" }
    image { open("#{Rails.root}/public/admin.png") }
    profile { "管理人：本サービスで登録されたユーザの情報を確認、編集ができる。"}
<<<<<<< HEAD
  end
 
  factory :user1, class: User do
    name { "user1" }
    password { "password" }
    password_confirmation { "password" }
    email { "user1@example.com" }
  end
   
  factory :user2, class: User do
    name { "user2" }
    password { "password" }
    password_confirmation { "password" }
    email { "user2@example.com" }
=======
>>>>>>> develop
  end
end
