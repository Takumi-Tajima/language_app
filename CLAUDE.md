# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

語学学習アプリケーションのRails 8.0.2プロジェクト。HamlビューとDevise認証を使用。

## 開発コマンド

### サーバー起動
```bash
bin/dev  # Procfile.devを使用してRailsサーバー、JavaScript、CSSビルドを同時起動
```

### データベース
```bash
rails db:create    # データベース作成
rails db:migrate   # マイグレーション実行
rails db:seed      # シードデータ投入
```

### テスト実行
```bash
bundle exec rspec          # 全テスト実行
bundle exec rspec spec/models/  # モデルテストのみ
bundle exec rspec spec/models/administrator_spec.rb  # 特定ファイルのテスト
```

### Lint/コード品質チェック
```bash
bundle exec rubocop         # Rubyコードのlint
bundle exec rubocop -a      # 自動修正可能な問題を修正
bundle exec haml-lint app/views/  # Hamlファイルのlint
```

### アセットビルド
```bash
yarn build         # JavaScriptビルド
yarn build:css     # CSSビルド（Bootstrap含む）
```

## アーキテクチャ概要

### 認証システム
- Deviseを使用した管理者認証（Administratorモデル）
- 管理者用のレイアウトとセッション管理

### ビュー層
- Hamlテンプレートエンジン使用
- Bootstrap 5によるスタイリング
- Turbo/Stimulusによるフロントエンド処理

### データベース
- PostgreSQL使用
- development: language_app_development
- test: language_app_test

### 重要な開発規約
- コントローラーアクションは標準の7つ（index, show, new, create, edit, update, destroy）のみ
- ビジネスロジックはモデルに配置
- 空文字列はデータベースに保存しない設計

### Gem依存関係
- simple_form: フォームビルダー
- bullet: N+1クエリ検出（開発環境）
- factory_bot_rails: テストデータ生成
- sgcop: SonicGardenのコーディング規約