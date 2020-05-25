# Sweet-Share

自分の好きなスイーツについて共有できるサービスです。
気になった記事についてはストックしたり、
いいね、コメント機能等で会員との交流も可能です。
転職活動用のポートフォリオとして作成致しました。

## リンク

[https://sweet-share.com/](https://sweet-share.com/)

テストユーザーログイン：
ホーム画面右上の「ログイン」をクリックし、
「テストユーザーとしてログイン」ボタンをクリックしてください。

## 使用技術
**サーバーサイド：**
- Ruby 2.6.3, Rails 5.1.7
- MySQL 5.7

**使用Gem：**
- carrierwave
- kaminari
- ransack
- omniauth-twitter
- rubocop
- rspec-rails
- factory\_bot\_rails
- react-rails
- webpacker
- jquery-rails

**フロントエンド：**
- SASS
- JQuery
- React 16.10.2 (Hooks)

**インフラストラクチャー**
- AWS
  - EC2
  - RDS for MySQL
  - Route53
  - ALB
  - ACM
  - S3
  - CloudFront
  - Nginx, unicorn

- Docker, Docker-compose


## 機能一覧：
- ユーザー登録、ログイン機能
- テストユーザーログイン機能
- Twitterアカウントからのログイン機能
- 記事CRUD機能
- 記事へのコメント機能
- 記事へのいいね、ストック機能(React Hooks)
- フォロー機能(React Hooks)
  - フォロー、フォロワー一覧表示
  - フォローユーザー投稿記事一覧表示
- 画像投稿機能(carrierwave)
- ページネーション機能(kaminari)
- 商品名による記事検索機能(ransack)
- 投稿日時、いいね多い順による記事表示順切替機能(React Hooks)
- カテゴリー別記事表示機能
- いいね通知機能
- ホーム画面でのスクロール時の記事表示順切替ボタン、カテゴリー、商品検索欄の位置固定機能(JQuery)

## テスト：
- Rspec
  - 単体テスト(モデル)
  - 統合テスト(systemspec)
