# docs/

プロジェクトの設計ドキュメントを管理するディレクトリ。

## ディレクトリ構造

```
docs/
├── requirements/          ← 要件定義 5フェーズ（Claude Code が生成）
│   ├── README.md          ← フロー図・トレーサビリティ原則
│   ├── 01-background.md   ← 背景・目的・スコープ
│   ├── 02-functional.md   ← 機能要件・非機能要件
│   ├── 03-open-questions.md ← 未確定事項（Q-xx）
│   ├── 04-integrated.md   ← 統合要件（確定版）
│   └── 05-architecture.md ← アーキテクチャ設計
├── meetings/              ← 議事録置き場（Markdown 形式）
│   └── YYYY-MM-DD.md      ← 日付ファイル名で管理
├── database.md            ← DB 設計（Claude Code が生成）
├── api-endpoints.md       ← API 一覧（Claude Code が生成）
├── features.md            ← 機能仕様（Claude Code が生成）
├── screens.md             ← 画面設計（Claude Code が生成）
└── lessons-learned.md     ← 学習ログ整理・ルール昇格候補
```

## 生成タイミング

| ファイル | 生成タイミング |
|---------|-------------|
| `requirements/01〜05` | テンプレートの Step 2（要件定義フロー） |
| `database.md` | テンプレートの Step 3（設計ドキュメント生成） |
| `api-endpoints.md` | テンプレートの Step 3 |
| `features.md` | テンプレートの Step 3 |
| `screens.md` | テンプレートの Step 3（新規案件のみ） |

## lessons-learned.md について

CLAUDE.md の学習ログが 10 件を超えたら、このファイルに整理する。
ルール化できそうなものは `.claude/rules/project/` に昇格する。
