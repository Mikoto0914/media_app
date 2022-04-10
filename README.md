#  Qiita風ブログサービス

![top_page](https://user-images.githubusercontent.com/57606507/87867878-4072d400-c9cc-11ea-8e34-67f511c75822.png)

## App URL　~~https://media-application.com~~ 

記事を作成・閲覧・管理する機能を提供するWebサービスです。普通のブログサービスと同様の機能が実装されています。
ユーザ登録の有無で利用できる機能が異なります。利用できる機能は以下のようになります。

ユーザ登録(無)：記事一覧表示、記事詳細表示、記事検索、タグ検索  
ユーザ登録(有)：すべての機能をご利用できます。

## 使用技術
- Ruby version: 2.5.8 (x86_64-linux)
- Rails version: 5.2.4.1
- Docker
- AWS(EC2,VPC,Route 53,Certificate Manager)

<p align="center">
<img src="https://user-images.githubusercontent.com/57606507/78248075-ecc8a180-7526-11ea-985e-d74e30799ae2.png" height="80px;" />
<img src="https://user-images.githubusercontent.com/57606507/78248084-f0f4bf00-7526-11ea-8fa9-e79ffa6ce020.png" height="100px;" />
<img src="https://user-images.githubusercontent.com/57606507/78248089-f3571900-7526-11ea-8fb3-5fd30f0f1df3.png" height="100px;" />
</p>

## アプリ機能

### 記事関連
- 一覧表示機能
- 詳細表示機能
- 投稿機能
- 編集機能
- サムネイル画像設定機能
- リアルタイムプレビュー機能
- 下書き機能
- ストック機能
- いいね機能
- コメント機能
- タグ機能
- ページネーション機能
- ソート機能（最新順、人気順）
- キーワード検索機能（タイトル、本文、タグ）

### ユーザ関連
- 管理ユーザ機能
- ユーザ登録機能
- ログイン・ログアウト機能
- ユーザ編集機能（名前、アイコン画像、プロフィール、パスワード）

## 機能サンプル画像

### 1. 記事一覧機能
![記事一覧](https://user-images.githubusercontent.com/57606507/87867905-76b05380-c9cc-11ea-8010-032a50498bf7.png)

### 2. 記事詳細表示機能
![記事詳細表示](https://user-images.githubusercontent.com/57606507/87867913-7b750780-c9cc-11ea-83ce-bad1db403105.png)

### 3. 記事検索機能
![記事検索](https://user-images.githubusercontent.com/57606507/87867911-7adc7100-c9cc-11ea-95a3-7fb2d8cae608.png)

### 4. 記事編集機能
![記事編集](https://user-images.githubusercontent.com/57606507/87867915-7c0d9e00-c9cc-11ea-9a49-4b4172678026.png)

### 5. 各ユーザ記事一覧機能
![ユーザ記事一覧](https://user-images.githubusercontent.com/57606507/87867912-7adc7100-c9cc-11ea-974e-0f3d8ebace04.png)

### 6. 記事下書き機能
![記事下書き一覧](https://user-images.githubusercontent.com/57606507/87867909-7a43da80-c9cc-11ea-905d-dbe401985413.png)

### 7. 記事ストック機能
![記事ストック](https://user-images.githubusercontent.com/57606507/87867904-7617bd00-c9cc-11ea-916e-4089b8c5bbb4.png)

### 8. プロフィール編集機能
![プロフィール編集](https://user-images.githubusercontent.com/57606507/87867910-7a43da80-c9cc-11ea-9b76-172aa25cd3ec.png)

### 9. アカウント設定機能
![アカウント設定](https://user-images.githubusercontent.com/57606507/87867919-7fa12500-c9cc-11ea-8c8f-60066339bbca.png)

### 10. コメント機能
![コメント機能](https://user-images.githubusercontent.com/57606507/86514425-f5de4d00-be4c-11ea-8087-1b82e1a79db5.png)

## 構築方法
1. コンテナをビルド&立ち上げ
```
docker compose build
docker compose up
```
2. DB作成&反映
```
docker compose exec app rails db:create
docker compose exec app rails db:migrate
docker compose exec app rails db:seed

```

## ライセンス
MIT