# .claude/rules/stack/ — スタック固有ルール

このディレクトリには、特定の技術スタックを使用するプロジェクトにのみ適用するルールを配置する。

## ファイル一覧

| ファイル | 適用条件 |
|---------|---------|
| `supabase.md` | Supabase（DB・Auth・Storage）を使用するプロジェクト |
| `vercel.md` | Vercel にデプロイするプロジェクト |
| `aws.md` | AWS（Lambda, S3, RDS, ECS 等）を使用するプロジェクト |
| `firebase.md` | Firebase（Firestore, Auth, Functions 等）を使用するプロジェクト |

## プロジェクトへの適用方法

テンプレート生成時（Step 3）に CLAUDE.md または SKILL.md から参照する:

```markdown
## 適用ルール

- `.claude/rules/common/coding-standards.md`（共通）
- `.claude/rules/stack/supabase.md`（Supabase 使用のため）
- `.claude/rules/stack/vercel.md`（Vercel デプロイのため）
```

## 新しいスタックを追加するとき

1. `新スタック名.md` を作成
2. 必須セクション: 「禁止事項」を含める
3. `CONTRIBUTING.md` の手順に従って PR を出す
