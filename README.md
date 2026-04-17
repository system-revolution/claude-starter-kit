# claude-starter-kit v2.0.0

新規プロジェクトの立ち上げから保守まで、全フェーズ対応の Claude Code ハーネステンプレート。

## ファイル構成

```
claude-starter-kit/
├── VERSION                              ← SemVer バージョン
├── CHANGELOG.md                         ← 変更履歴
├── CONTRIBUTING.md                      ← 改善フロー・SemVer ルール
├── CLAUDE.md                            ← プロジェクト用プレースホルダー
│
├── tpl/                                 ← テンプレート原本（コピーして使う）
│   ├── common/                          ← 4テンプレート共通の断片
│   │   ├── step0-preflight.md           ← プラグインチェック定型
│   │   ├── step-confirmation.md         ← 確認ゲート定型
│   │   ├── step-security-check.md       ← セキュリティチェック定型
│   │   ├── step-report.md               ← 報告定型
│   │   ├── precautions.md               ← 注意事項定型
│   │   └── settings-template.json       ← settings.json 単一ソース
│   ├── template-new-project.md          ← 新規案件
│   ├── template-renewal.md              ← リニューアル
│   ├── template-feature-add.md          ← 機能追加・改修
│   └── template-maintenance.md          ← 保守メンテナンス
│
├── docs/                                ← ドキュメント
│   ├── lessons-learned.md               ← ルール昇格候補テンプレート
│   ├── requirements/                    ← 要件定義 5フェーズ雛形
│   │   ├── 01-background.md
│   │   ├── 02-functional.md
│   │   ├── 03-open-questions.md
│   │   ├── 04-integrated.md
│   │   └── 05-architecture.md
│   └── meetings/                        ← 議事録置き場
│
├── examples/                            ← サンプル議事録と期待出力
│   ├── sample-minutes/
│   └── expected-outputs/
│
└── .claude/
    ├── settings.json                    ← 権限 + Hooks
    ├── rules/
    │   ├── README.md                    ← 3階層の説明
    │   ├── common/
    │   │   └── coding-standards.md      ← スタック非依存の共通規約
    │   ├── stack/
    │   │   ├── supabase.md
    │   │   ├── vercel.md
    │   │   ├── aws.md
    │   │   └── firebase.md
    │   └── project/                     ← 各プロジェクトが独自に管理
    ├── scripts/
    │   ├── check-plugins.sh             ← プラグイン存在チェック
    │   ├── count-learnings.sh           ← 学習ログカウント
    │   └── validate-base.sh             ← ベース整合性検証
    └── skills/
        ├── this-project/                ← プロジェクト固有スキル置き場
        ├── self-improve/                ← 学習ログ自動判定
        └── update-base/                 ← 既存プロジェクトへの適用手順
```

## 使い方

### 1. 新規案件

```
打ち合わせ → 議事録
    ↓
tpl/template-new-project.md をコピー
    ↓
【】を埋めて、議事録を末尾に貼る
    ↓
Claude Code に全文を貼る
    ↓
Step 0: プラグインチェック → 続行
Step 1: 議事録分析 → 確認 → OK
Step 2: 要件定義フロー（docs/requirements/ 生成）
Step 3: 設計ドキュメント生成 → 確認 → OK
Step 4: ルール・スキル・settings.json 生成
Step 5: 実装
    ↓
開発開始
```

### 2. リニューアル

```
打ち合わせ → 議事録 + 既存システム情報
    ↓
tpl/template-renewal.md をコピー
    ↓
【】を埋めて、議事録を末尾に貼る
    ↓
Claude Code に全文を貼る（Step 0.5 で既存コード調査）
```

### 3. 機能追加・改修（納品後）

```
クライアントから依頼
    ↓
tpl/template-feature-add.md をコピー
    ↓
【】を埋めて、議事録を末尾に貼る
    ↓
Claude Code に貼る（既に CLAUDE.md があるプロジェクトで）
→ 影響分析 → 10ファイル超なら大規模変更ゲート
```

### 4. 保守メンテナンス（納品後）

```
クライアントから報告（バグ・障害など）
    ↓
tpl/template-maintenance.md をコピー
    ↓
緊急度と種別を選択、報告内容を末尾に貼る
    ↓
Claude Code に貼る → 原因調査 → 確認 → 修正
```

## ルール構成

- `common/coding-standards.md` — スタック非依存の規約（全プロジェクト共通）
- `stack/supabase.md` — Supabase を使うプロジェクトに適用
- `stack/vercel.md` — Vercel にデプロイするプロジェクトに適用
- `stack/aws.md` — AWS を使うプロジェクトに適用
- `stack/firebase.md` — Firebase を使うプロジェクトに適用
- `project/` — 各プロジェクトが独自ルールを追加する場所

## 整合性検証

```bash
bash .claude/scripts/validate-base.sh
```

## バージョン管理・改善

`CONTRIBUTING.md` を参照。
