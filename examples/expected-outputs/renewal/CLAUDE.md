# CLAUDE.md — サンプルリニューアル（WordPress → Next.js）

株式会社リニューアル例のWordPressサイトをNext.js + Supabase へリニューアル。
2,000記事・5GB画像を移行しながら、SEO（URL構造）を維持する。

## スタック

```
フロントエンド : Next.js 15 (App Router) + TypeScript strict + Tailwind CSS v4 + shadcn/ui
バックエンド   : Supabase（DB・Auth・Storage）
デプロイ       : Vercel
移行元         : WordPress + MySQL
```

## 基本コマンド

```bash
pnpm dev          # 開発サーバー起動
pnpm typecheck    # 型チェック
pnpm build        # 本番ビルド
pnpm migrate:wp   # WordPress データ移行スクリプト
pnpm db:generate  # マイグレーション生成
```

## 重要ルール

- **URL 構造を変えない**（SEO 維持のため — Vercel rewrites で対応）
- 既存の WordPress コードは引き継がない（ゼロから作り直し）
- 移行スクリプトは `scripts/migrate/` に格納する
- 詳細な業務ルールは `.claude/skills/this-project/SKILL.md` を参照
- データ移行に関する Q は全て解消してから移行フェーズに着手する

## スケジュール

- 開発期間: 4ヶ月（〜2026-08）
- データ移行仕様確定: 2026-04-17 次回打ち合わせ
- リリース目標: 2026-08

## 学習ログ

<!-- 学習エントリーはここに追記する。10件超えたら docs/lessons-learned.md に移動 -->
