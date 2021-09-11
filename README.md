# 課題プロダクト

## お題: MUSIC SNS!!

iTunseAPI を使った投稿型 SNS サービス

## 出題形式

難易度を basic / standard / advanced の 3 つの段階に分けて出題します

### basic

- https://lfs5-kadai.herokuapp.com/
- iTunseAPI を使ってユーザーに紐づいた投稿ができる（1:n, 外部 API）
- 最低限クリアしてほしいレベルです。期日中に絶対終わらせてきてください。

### standard

- （URL 工事中）
- いいね機能（n:n）
- スクールメンターとして多対多は理解してほしいので、期日までに終わらなくても、研修が終わるまでには絶対に終わらせてほしいレベル感
- ただ、ショッピングで多対多を学ぶのはかなり難しいので、この課題のいいね機能を使って多対多を理解しよう

### advanced

- https://lfs6-model-test.herokuapp.com/
- フォロー機能（n:n）
- Twitter 認証（できる人のみ）

# 設計

## UI 設計（ページ,コンポーネント設計）

- `layout.erb`
  - [x] ナビゲーションバー
    - [x] ログイン状態に合わせた表示
    - [x] プロフィール画像の表示
  - [x] yield を使った表示
- `index.erb`
  - [x] 全ての投稿の一覧表示
  - [x] 投稿のなかにアーティスト名やユーザー名，コメントを表示
  - [x] ユーザーのログインフォーム
  - [x] 新規登録リンク
  - [ ] Twitter 認証に置き換え
- `sign_up.erb`
  - [x] ユーザーの新規登録のフォーム
- `search.erb`
  - [x] 音楽検索フォーム
  - [x] 検索結果一覧の表示
    - [x] 検索結果に合わせた表示
  - [x] コメントフォーム
  - [x] 投稿の新規作成ボタンが作れているか
    - [x] input:type ＝ hidden
- `home.erb`
  - [x] ユーザーに紐づいた投稿の一覧表示
  - [x] 投稿の削除リンク
  - [x] 投稿の編集リンク
- `edit.erb`
  - [x] 投稿の編集フォーム
    - [x] placeholder に編集前の内容を表示

## 実装の参考に

### 準備

- 必要な gem は Gemfile に記述してあります
- 最低限の HTML, CSS は準備してあります
- 必要に応じて seed データを用意してください
- [x] rake コマンドが使えるようになっているか
  - [x] Rakefile の作成
  - [x] models.rb の作成
- [ ] マイグレーションファイルを設計の通り作れているか
  - [x] standardまで
  - [ ] advanced
- [x] 投稿用のモデルおよびデータベースのテーブルが作れているか
- [x] ユーザー用のモデルおよびデータベースのテーブルが作れているか
- [x] 投稿モデルとユーザーモデルの連携が出来ているか

### デザイン

- [ ] ナビゲーションバー
  - [x] プロフィール画像の border-radius を指定できているか（丸くする）
  - [x] img タグを適切に使えているか
- [x] `index.erb`にファーストビューを作れているか
  - [x] background-size: cover;
  - [x] background-repeat: no-repeat;
- [x] flexbox を使って中央揃えができているか
  - [x] flex-direction: column;
  - [x] justify-content: center;
- [x] webfont を使って font-family を設定できているか
