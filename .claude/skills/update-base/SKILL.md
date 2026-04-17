---
name: update-base
description: 既存プロジェクトに claude-starter-kit の新バージョンを適用する手順。ベース更新時に使う。
---

# update-base スキル

既存プロジェクトに対して claude-starter-kit の新バージョンを安全に適用する手順。

## 前提条件

- 現在のプロジェクトが git で管理されていること
- `update/base-vX.Y.Z` ブランチを切ってから作業すること

```bash
git checkout -b update/base-v2.0.0
```

## ファイルの分類

### 上書き対象（ベースが管理する）

以下のファイルは**新バージョンで上書きする**:

- `.claude/scripts/` — 全スクリプト
- `.claude/rules/common/` — 共通規約
- `.claude/rules/stack/` — スタックルール
- `.claude/skills/self-improve/SKILL.md`
- `.claude/skills/update-base/SKILL.md`
- `.claude/skills/this-project/README.md`
- `tpl/common/` — 共通テンプレート断片
- `tpl/template-*.md` — 全テンプレート

### マージ対象（慎重に差分確認）

以下のファイルは**プロジェクト固有の内容があるため、差分を確認してマージする**:

- `CLAUDE.md` — 学習ログ・プロジェクト固有設定を保持
- `.claude/settings.json` — プロジェクト固有のフック・パーミッションを保持
- `README.md` — プロジェクト固有の説明を保持

### 触らない（プロジェクトが管理する）

以下のファイルは**ベース更新で変更しない**:

- `.claude/skills/this-project/SKILL.md`
- `.claude/rules/project/`（全ファイル）
- `docs/requirements/`（生成済みの要件定義書）
- `docs/lessons-learned.md`（学習ログ）

## 適用手順

### Step 1: 現状確認

```bash
# 現在のバージョン確認
cat VERSION

# 変更されているファイルを確認
git status
```

### Step 2: 上書き対象を更新

新バージョンの claude-starter-kit から以下をコピー:

```bash
# （claude-starter-kit を別ディレクトリに clone してある前提）
BASE_DIR=~/repos/claude-starter-kit

# スクリプト上書き
cp -r "$BASE_DIR/.claude/scripts/" .claude/scripts/
chmod +x .claude/scripts/*.sh

# 共通ルール上書き
cp -r "$BASE_DIR/.claude/rules/common/" .claude/rules/common/
cp -r "$BASE_DIR/.claude/rules/stack/" .claude/rules/stack/

# スキル上書き
cp "$BASE_DIR/.claude/skills/self-improve/SKILL.md" .claude/skills/self-improve/SKILL.md
cp "$BASE_DIR/.claude/skills/update-base/SKILL.md" .claude/skills/update-base/SKILL.md
cp "$BASE_DIR/.claude/skills/this-project/README.md" .claude/skills/this-project/README.md

# テンプレート上書き
cp -r "$BASE_DIR/tpl/common/" tpl/common/
cp "$BASE_DIR/tpl/template-new-project.md" tpl/template-new-project.md
cp "$BASE_DIR/tpl/template-renewal.md" tpl/template-renewal.md
cp "$BASE_DIR/tpl/template-feature-add.md" tpl/template-feature-add.md
cp "$BASE_DIR/tpl/template-maintenance.md" tpl/template-maintenance.md
```

### Step 3: マージ対象を差分確認

```bash
# CLAUDE.md の差分確認
diff CLAUDE.md "$BASE_DIR/CLAUDE.md"

# settings.json の差分確認
diff .claude/settings.json "$BASE_DIR/.claude/settings.json"
```

CLAUDE.md のマージ方針:
- ベースの構造・セクション名に合わせる
- 学習ログセクションの内容は必ず保持する
- プロジェクト固有のスタック・コマンド・ルールは保持する

settings.json のマージ方針:
- ベースの `deny` リストを取り込む（セキュリティ強化）
- プロジェクト固有の `allow` 設定は保持する
- フック構造が変わっている場合はベース側に合わせる

### Step 4: VERSION 更新

```bash
cat "$BASE_DIR/VERSION" > VERSION
```

### Step 5: 整合性検証

```bash
bash .claude/scripts/validate-base.sh
```

全チェックをパスすることを確認する。

### Step 6: コミット

```bash
git add -A
git commit -m "chore: claude-starter-kit を v$(cat VERSION) に更新"
```

### Step 7: PR 作成・マージ

```bash
gh pr create --title "chore: claude-starter-kit v$(cat VERSION) 適用" \
  --body "## 変更内容\n- claude-starter-kit を v$(cat VERSION) に更新\n\n## 確認事項\n- [ ] validate-base.sh が全チェックをパス\n- [ ] プロジェクト固有の設定が保持されている\n- [ ] 学習ログが消えていない"
```

### Step 8: 完了報告

以下を報告する:
1. 適用したバージョン
2. 上書きしたファイル一覧
3. マージで変更したファイルとその内容
4. 触らなかったファイル（プロジェクト管理分）
5. 次にすべきこと（新機能の使い方等）
