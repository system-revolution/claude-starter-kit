# CLAUDE.md — 【プロジェクト名】（1行の説明）

> このファイルはテンプレートから Claude Code が生成します。
> tpl/ フォルダのテンプレートを使って初期化してください。
>
> - 新規案件 → tpl/template-new-project.md
> - リニューアル → tpl/template-renewal.md
> - 機能追加・改修 → tpl/template-feature-add.md
> - 保守メンテナンス → tpl/template-maintenance.md

## あなたの役割

（このプロジェクトで Claude Code が担う役割を 1〜2 文で）

## スタック

（確定したスタック情報）

## プラグイン構成（起動時に自動適用）

- **ECC（everything-claude-code）**: コードレビュー・セキュリティ・Instinct 自動学習
  - 並列実装は ECC の Agent Teams を使う（独立機能は同時進行）
  - セキュリティスキャンは `/security-scan` で実行
- **Superpowers**: TDD・設計・コードレビューの品質管理
  - 複雑な実装前は必ず `/superpowers:brainstorm`
  - 大規模変更前は `/superpowers:write-plan` で計画書を作成
  - バグ修正は `/superpowers:debug`（推測で直さない）
- **Taskmaster**: タスク分解・追跡・セッション間コンテキスト維持
  - 作業前に `task-master next` で次タスクを確認
- **Context7**: ライブラリ使用時に最新 Doc を自動取得（use context7）
- **Playwright**: E2E テストは Playwright スキルで自動実行

## 基本コマンド

```bash
npm run dev    — 開発サーバー起動
npm run build  — ビルド
npm run lint   — lint 実行
```

## ディレクトリ構造

（スタックの標準構成を記載）

## ブランチ運用

- `feature/xxx` `fix/xxx` `hotfix/xxx` でブランチを切ること
- main への直接コミット・マージ禁止（Hook が検知する）

## 重要ルール

- 作業開始時に必ず `.claude/skills/this-project/SKILL.md` を読むこと
- プロジェクト固有の業務ルール・禁止事項はすべて SKILL.md に記載
- ライブラリの API や設定を扱う場合は必ず use context7 で最新 Doc を参照すること

## 学習ログ（プロジェクト固有の知見のみ）

> ECC の Instinct はコーディングパターン全般を自動学習する。
> ここにはこのプロジェクト固有の制約・クライアント固有の判断のみ記録する。
> 10 件を超えたら docs/lessons-learned.md に整理してリセットすること。
