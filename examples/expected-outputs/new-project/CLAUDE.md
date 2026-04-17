# CLAUDE.md — サンプル在庫管理システム

サンプル商事向け在庫管理システム。Excel 管理からの脱却と複数拠点のリアルタイム在庫同期を実現する。

## スタック

```
フロントエンド : Next.js 15 (App Router) + TypeScript strict + Tailwind CSS v4 + shadcn/ui
バックエンド   : Supabase（DB・Auth・Storage・Edge Functions）
デプロイ       : Vercel
```

## 基本コマンド

```bash
pnpm dev          # 開発サーバー起動
pnpm typecheck    # 型チェック
pnpm test         # テスト実行
pnpm build        # 本番ビルド
pnpm db:generate  # マイグレーション生成
pnpm db:migrate   # マイグレーション実行
```

## ディレクトリ構造

```
apps/web/        # Next.js (App Router)
packages/db/     # Drizzle ORM スキーマ
docs/            # 設計ドキュメント
```

## 重要ルール

- 詳細な業務ルール・API 仕様は `.claude/skills/this-project/SKILL.md` を参照
- ライブラリ使用時は `use context7` で最新 Doc を取得する
- 全テーブルに RLS を必ず適用する（Supabase ルール）
- コンテキスト 50% で `/compact` を実行する

## 未解決事項（open-questions）

- Q-01 ～ Q-05 は `docs/requirements/03-open-questions.md` を参照
- 実装前に全 Q を解消すること

## 学習ログ

<!-- 学習エントリーはここに追記する。10件超えたら docs/lessons-learned.md に移動 -->
