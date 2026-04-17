# Contributing to claude-starter-kit

## 改善フロー

1. **Issue 起票** — `.github/ISSUE_TEMPLATE/` のテンプレートを使って Issue を作成
2. **ブランチ作成** — `feature/xxx` または `fix/xxx` でブランチを切る
3. **実装** — 該当ファイルを修正・追加
4. **整合性検証** — `bash .claude/scripts/validate-base.sh` を実行して全チェックをパス
5. **PR 作成** — 変更内容・再発防止策を明記
6. **レビュー** — メンテナーがレビューしてマージ

## SemVer ルール

このリポジトリは [Semantic Versioning](https://semver.org/) に従う。

| バージョン | 変更内容 | 例 |
|-----------|---------|-----|
| `PATCH` x.x.**Z** | 既存ファイルの誤字修正・説明補足 | 1.0.1 |
| `MINOR` x.**Y**.0 | 新しいスタックルール・テンプレート断片の追加 | 1.1.0 |
| `MAJOR` **X**.0.0 | テンプレート構造変更・ファイル移動・既存プロジェクトへの影響あり | 2.0.0 |

`MAJOR` 変更は既存プロジェクトの `.claude/` 構成を壊す可能性がある。  
`update-base` スキルを使って既存プロジェクトへの適用手順を提供すること。

## ファイル追加・変更のルール

### `.claude/rules/` を変更するとき

- `common/` — スタック非依存の規約のみ。「Supabase は」「Next.js は」等スタック名を出してはならない
- `stack/` — そのスタック固有のルールのみ。他スタックに影響しない
- `project/` — 空のまま（各プロジェクトが独自に管理する）

### `tpl/` を変更するとき

- 4 テンプレート共通の変更は `tpl/common/` の断片ファイルに書く
- 個別テンプレートに直接書くのは、そのテンプレート固有の内容のみ
- `tpl/common/settings-template.json` と `.claude/settings.json` は同期を保つ（どちらかを変えたら両方変える）

### `docs/requirements/` を変更するとき

- 雛形の構造変更は全 5 ファイルの整合性を確認すること
- トレーサビリティ原則（confidence 定義・source 記法）は `docs/requirements/README.md` に集約する

## 更新手順（リリース）

```bash
# 1. VERSION を更新
echo "X.Y.Z" > VERSION

# 2. CHANGELOG.md に変更内容を追記

# 3. 整合性検証
bash .claude/scripts/validate-base.sh

# 4. コミット
git add -A
git commit -m "chore: vX.Y.Z リリース"

# 5. タグ付け
git tag vX.Y.Z

# 6. プッシュ（メンテナーのみ）
git push origin main --tags
```

## 既存プロジェクトへの反映

ベースを更新した場合、既存プロジェクトへの適用は `.claude/skills/update-base/SKILL.md` の手順に従う。  
**強制的に上書きしてはならない**。各プロジェクトのカスタマイズを尊重すること。
