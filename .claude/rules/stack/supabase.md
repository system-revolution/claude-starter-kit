# Supabase ルール

## RLS（Row Level Security）

- **全テーブルに RLS を必ず有効化する**。例外なし
- RLS なしでテーブルを作成することを禁止する
- ポリシーは `auth.uid()` を使って認証ユーザーのみアクセス可能にする

```sql
-- ✅ 正しい RLS ポリシー例
ALTER TABLE public.projects ENABLE ROW LEVEL SECURITY;

CREATE POLICY "ユーザー自身のデータのみ参照可能"
  ON public.projects
  FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "ユーザー自身のデータのみ更新可能"
  ON public.projects
  FOR UPDATE
  USING (auth.uid() = user_id);
```

## マイグレーション

- スキーマ変更は必ず `supabase migration new <名前>` でマイグレーションファイルを作成する
- 直接 SQL Editor でスキーマを変更することを禁止する（ローカルと本番の差異が生まれる）
- マイグレーション実行前に `supabase db diff` で差分を確認する
- マイグレーションファイルは git で管理する

```bash
# マイグレーション作成
supabase migration new add_projects_table

# ローカル適用
supabase db push

# 差分確認
supabase db diff
```

## 型生成

- DB スキーマ変更後は必ず型を再生成する
- 生成された型ファイルを手動編集することを禁止する

```bash
supabase gen types typescript --local > packages/types/database.types.ts
```

## 認証

- 認証は Supabase Auth を使う（独自認証システムの実装禁止）
- JWT の検証はサーバーサイドで行う（クライアントサイドのみでの検証禁止）
- セッション管理はサーバーサイドクライアント（`createServerClient`）を使う
- ブラウザクライアント（`createBrowserClient`）をサーバーコンポーネントで使うことを禁止する

```typescript
// ✅ サーバーサイド
import { createServerClient } from '@supabase/ssr'

// ✅ クライアントサイド
import { createBrowserClient } from '@supabase/ssr'
```

## 環境変数

| 変数名 | 用途 |
|--------|------|
| `NEXT_PUBLIC_SUPABASE_URL` | Supabase プロジェクト URL（公開可） |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | 匿名キー（公開可、RLS で保護） |
| `SUPABASE_SERVICE_ROLE_KEY` | サービスロールキー（**絶対に公開しない**） |

## 禁止事項

- `SUPABASE_SERVICE_ROLE_KEY` をフロントエンドから使用することを禁止する
- RLS を無効化した状態でテーブルを本番環境に公開することを禁止する
- マイグレーションファイルを SQL Editor で直接変更することを禁止する
- 生成された型ファイルを手動編集することを禁止する
- `dangerouslyAllowBrowser: true` を本番コードで使用することを禁止する
