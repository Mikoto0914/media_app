# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  [
    {
      name: 'admin',
      email: 'admin@example.com',
      image: open("#{Rails.root}/public/admin.png"),
      profile: '管理人：本サービスで登録されたユーザの情報を確認、編集ができる。',
      password: 'password', 
      admin: true
    },
    {
      name: 'normal', 
      email: 'normal@example.com', 
      profile: 'ユーザ：登録することで記事投稿機能、いいね機能、記事ストック機能などが利用できる。',
      password: 'password' 
    }
  ]
)
Post.create!(
  user_id: 1,
  publish_flg: true,
  thumbnail_image: open("#{Rails.root}/public/blog_sample_2.jpg"),
  title: '本サービスについて',
  content: 
'本サービスは、基本的なブログサービスの機能を実装したポートフォリオです。

<a href="https://github.com/MikotoSuganuma/media_app" target="_blank">Github</a>

#### 使用技術
<hr>
- ・Ruby version: 2.7.0 (x86_64-linux)  
- ・Rails version: 5.2.4.1  
- ・Docker 
- ・AWS(EC2,VPC,Route 53,Certificate Manager)

#### アプリ機能
<hr>
#####記事関連
- ・記事一覧表示機能  
- ・記事詳細表示機能 
- ・記事投稿機能 
- ・記事編集機能
- ・記事検索機能
- ・プレビュー機能
- ・下書き機能
- ・記事ストック機能

#####ユーザ関連
- ・管理ユーザ機能
- ・ユーザ登録機能
- ・ユーザ編集機能
- ・ログイン・ログアウト機能'
)