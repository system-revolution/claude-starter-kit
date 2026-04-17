# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.0.0] — 2026-04-17

### Breaking Changes

- `CLAUDE.md` を軽量テンプレートに刷新。プラグイン構成・ブランチ運用を明記
- `.claude/rules/` を 3 階層に再編（`common/` / `stack/` / `project/`）
- `tpl/` テンプレートを 5 ステップ構成（Step 0〜5）に統一
- `tpl/common/` に DRY 断片を切り出し（4 テンプレート共通部分）
- `settings.json` フック構造を新フォーマットに変更（`matcher` + `hooks` 配列）
- `docs/requirements/` に 5 フェーズ要件定義フローを新設
- `.claude/scripts/` に整合性検証スクリプトを新設
- `.claude/agents/` ディレクトリを削除

### Added

- `VERSION` ファイル追加（SemVer 管理）
- `CHANGELOG.md` 追加
- `CONTRIBUTING.md` 追加（改善フロー・SemVer ルール・更新手順）
- `.claude/rules/common/coding-standards.md` — スタック非依存の規約
- `.claude/rules/stack/supabase.md` — Supabase 専用ルール
- `.claude/rules/stack/vercel.md` — Vercel 専用ルール
- `.claude/rules/stack/aws.md` — AWS 専用ルール
- `.claude/rules/stack/firebase.md` — Firebase 専用ルール
- `.claude/scripts/check-plugins.sh` — プラグイン存在チェック
- `.claude/scripts/count-learnings.sh` — 学習ログカウント
- `.claude/scripts/validate-base.sh` — ベース整合性検証
- `.claude/skills/update-base/SKILL.md` — 既存プロジェクトへのベース適用手順
- `docs/requirements/01-background.md` 〜 `05-architecture.md` — 要件定義 5 フェーズ雛形
- `docs/lessons-learned.md` — ルール昇格候補テンプレート
- `tpl/common/step0-preflight.md` — プラグインチェック定型
- `tpl/common/step-confirmation.md` — 確認ゲート定型
- `tpl/common/step-security-check.md` — セキュリティチェック定型
- `tpl/common/step-report.md` — 報告定型
- `tpl/common/precautions.md` — 注意事項定型
- `tpl/common/settings-template.json` — settings.json 単一ソース
- `examples/` — サンプル議事録と期待出力

### Changed

- `README.md` — v2.0.0 対応、ファイル構成・利用方法を更新
- `CLAUDE.md` — 40〜50 行軽量版に刷新
- `.claude/settings.json` — セキュリティ強化・フック新フォーマット
- `.claude/skills/self-improve/SKILL.md` — Stop フック自動呼び出しを削除、ベース昇格セクション追加
- `tpl/template-new-project.md` — Step 0〜5 構成、docs/requirements/ 生成フロー追加
- `tpl/template-renewal.md` — 既存コード調査・データ移行手順追加
- `tpl/template-feature-add.md` — 影響分析・大規模変更ゲート追加
- `tpl/template-maintenance.md` — 緊急度テーブル・種別別手順追加

### Removed

- `.claude/agents/` ディレクトリ
- `.claude/rules/coding-standards.md`（→ `common/` に移動）

---

## [1.0.0] — 2026-03-01

### Added

- 初版リリース
- `tpl/template-new-project.md` — 新規案件テンプレート
- `tpl/template-renewal.md` — リニューアルテンプレート
- `tpl/template-feature-add.md` — 機能追加テンプレート
- `tpl/template-maintenance.md` — 保守メンテナンステンプレート
- `.claude/rules/coding-standards.md` — コーディング規約
- `.claude/skills/self-improve/SKILL.md` — 自己改善スキル
- `.claude/settings.json` — パーミッション・フック設定
- `docs/` — ドキュメント生成ガイド
- `CLAUDE.md` — プロジェクト初期化用プレースホルダー
