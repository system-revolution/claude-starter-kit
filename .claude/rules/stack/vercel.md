# Vercel ルール

## デプロイフロー

1. `feature/xxx` ブランチを push → Vercel がプレビューデプロイを自動作成
2. プレビュー URL で動作確認
3. PR を作成 → レビュー
4. main にマージ → 本番デプロイ自動実行

```bash
# 環境変数の追加（CLI）
vercel env add MY_SECRET_KEY production

# ローカルで環境変数を pull
vercel env pull .env.local
```

## 環境変数

- 環境変数は Vercel ダッシュボードまたは `vercel env` コマンドで管理する
- `.env` ファイルをリポジトリにコミットすることを禁止する
- `NEXT_PUBLIC_` プレフィックスをつけた変数はクライアントサイドに露出する（秘密情報に使用禁止）

| 環境 | 用途 |
|------|------|
| Production | 本番環境（main ブランチ） |
| Preview | ブランチデプロイ・PR プレビュー |
| Development | `vercel env pull` でローカルに取得 |

## Edge Runtime

- Vercel Functions のデフォルトは Node.js（Fluid Compute）を使う
- Edge Runtime が必要な場合は明示的に `export const runtime = 'edge'` を宣言する
- Edge Runtime では Node.js のすべての API が使えないことに注意する（特に `fs`、`child_process`）

## 禁止事項

- `vercel --prod` で直接本番デプロイすることを禁止する（必ず PR 経由）
- 環境変数をコードにハードコードすることを禁止する
- `NEXT_PUBLIC_` の変数に秘密情報（API キー等）を入れることを禁止する
- ビルドに失敗している状態で本番マージすることを禁止する
