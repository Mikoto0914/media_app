FactoryBot.define do
  factory :post do
    title { "test_title" }
    content { "test text" }
    user_id { 1 }
    publish_flg { true }
  end
end
