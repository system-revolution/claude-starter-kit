# SKILL.md — サンプルリニューアル（WordPress → Next.js）

---

## 禁止事項

- **URL 構造を変えない**（SEO が壊れる）— `vercel.json` の rewrite/redirect を必ず設定する
- 既存 WordPress のコードをコピーしない（ゼロから作り直し）
- 移行スクリプトを本番 DB に直接実行しない（必ずステージング環境で検証後）
- 画像の URL（パス）を変えない（`/wp-content/uploads/` のパスは rewrite で対応）

## データ移行ルール

- 移行スクリプトは `scripts/migrate/` に格納する
- スクリプトはべき等（何度実行しても同じ結果）に書く
- 移行前に必ずドライランモードで件数・エラーを確認する
- 記事データの移行は Q-01 解消後に開始する

## WordPress 固有の注意点

- WordPress のカテゴリ階層（親/子カテゴリ）は Supabase の自己参照テーブルで表現する
- `post_meta` の移行は必要なフィールドのみ選択的に移行する（全量は不要）
- Contact Form 7 のデータは Q-03 解消後に移行方針を確定する
