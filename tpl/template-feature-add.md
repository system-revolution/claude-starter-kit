# 機能追加・改修テンプレート

> 既存CLAUDE.mdがあるプロジェクトに機能追加・改修を行う。

## 基本情報

- プロジェクト名: 【既存のプロジェクト名】
- 種別: 【機能追加 / 改修 / 両方】
- 概要: 【1〜2行】

## 私のディレクション

【方針・判断・補足】

---

## Claude Codeへの指示

### 前提

作業開始前に以下を読む:
- `.claude/skills/this-project/SKILL.md`(必須)
- `CLAUDE.md`
- `.claude/rules/common/coding-standards.md`
- SKILL.md で指定された `.claude/rules/stack/*.md`
- `.claude/rules/project/*`
- `docs/requirements/*`(既存要件の把握)
- `docs/database.md`, `docs/api-endpoints.md`, `docs/features.md`, `docs/screens.md`

### Step 0: プラグイン存在チェック

`tpl/common/step0-preflight.md`。完了後 `tpl/common/step-confirmation.md` で停止。

### Step 1: 現状把握と影響分析

1. CLAUDE.md・SKILL.md・docs/* を読みプロジェクト全体像を把握
2. 打ち合わせ議事録(または本テンプレート末尾)を読み要件整理
3. 新しいライブラリを使う場合は `use context7` で最新Docを確認
4. 以下を報告:
   - **変更の影響範囲**(どのファイル・テーブル・画面)
   - **新規作成が必要なもの**(テーブル、コンポーネント、API)
   - **既存コードの変更箇所**(概要)
   - **リスク**(既存機能を壊す可能性)
   - **未確定事項**(docs/requirements/03-open-questions.md に Q-xx として登録)

**大きな変更判定**: 以下の場合は Step 2 に進む前にユーザー確認:
- 影響ファイルが10以上
- 既存仕様変更・破壊的変更を伴う
- 新規テーブルの追加

完了後 `tpl/common/step-confirmation.md` で停止。

### Step 2: 実装

確認が取れたら:
```bash
git checkout -b feature/【機能名】
git commit -m "WIP: 実装開始前のセーフポイント" --allow-empty
```

実装ルール:
- 独立した機能は ECC Agent Teams で並列(共通ファイルを触る機能は直列)
- 並列実装前にインターフェースを確定
- 既存のコードパターン・命名規則に合わせる
- CLAUDE.md / SKILL.md の作業プロトコルに従う
- ライブラリ使用時は `use context7`
- DB変更はマイグレーションファイル必須
- 1機能実装 → git commit → 次の機能

### Step 3: ドキュメント更新

以下を確認し、変更があれば更新、なければ「更新不要」と明示:
- docs/database.md
- docs/api-endpoints.md
- docs/features.md
- docs/screens.md(画面追加・変更がある場合)
- docs/requirements/02-functional.md(要件追加の場合)
- docs/requirements/03-open-questions.md(Q-xx解決の場合)
- CLAUDE.md(禁止事項・ルール追加の場合)

### Step 4: セキュリティチェック

`tpl/common/step-security-check.md`。

### Step 5: 報告

`tpl/common/step-report.md` のフォーマット。

---

## 注意事項

`tpl/common/precautions.md` を参照。

機能追加固有の注意:
- 既存 CLAUDE.md / rules / settings.json は基本的に変更しない
- 新ルールが必要な場合のみ `.claude/rules/project/` に追加
- 「ついでにリファクタリング」禁止
- 影響範囲が大きい場合は分割して段階的に実装

---

## 打ち合わせ議事録

【ここに議事録を貼る、または docs/meetings/YYYY-MM-DD.md を参照】
