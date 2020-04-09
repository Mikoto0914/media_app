FactoryBot.define do
  factory :user do
    name { "test1" }
    password { "password" }
    password_confirmation { "password" }
    email { "test@example.com" }
  end
end
