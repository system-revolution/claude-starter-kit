# Claude Code スターターキット

新規プロジェクトの立ち上げから保守まで、全フェーズ対応。

## フォルダ構成

```
プロジェクト/
├── CLAUDE.md                          ← Claude Codeが自動生成
├── tpl/                               ← テンプレート原本（コピーして使う）
│   ├── template-new-project.md        ← 新規案件
│   ├── template-renewal.md            ← リニューアル
│   ├── template-feature-add.md        ← 機能追加・改修
│   └── template-maintenance.md        ← 保守メンテナンス
├── docs/                              ← Claude Codeが自動生成
│   ├── database.md
│   ├── api-endpoints.md
│   ├── features.md
│   └── screens.md
└── .claude/
    ├── settings.json                  ← 権限 + Hooks
    ├── rules/
    │   └── coding-standards.md        ← 全プロジェクト共通
    ├── skills/
    │   └── self-improve/              ← 学習ログ自動判定
    └── agents/                        ← 必要になったら追加
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
Claude Codeに全文を貼る
    ↓
分析結果を確認 → OKなら生成
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
Claude Codeに全文を貼る
    ↓
分析結果を確認 → OKなら生成
    ↓
開発開始
```

### 3. 機能追加・改修（納品後）

```
クライアントから依頼
    ↓
tpl/template-feature-add.md をコピー
    ↓
【】を埋めて、議事録を末尾に貼る
    ↓
Claude Codeに貼る（既にCLAUDE.mdがあるプロジェクトで）
    ↓
影響範囲を確認 → OKなら実装
```

### 4. 保守メンテナンス（納品後）

```
クライアントから報告（バグ、障害など）
    ↓
tpl/template-maintenance.md をコピー
    ↓
【】を埋めて、報告内容を末尾に貼る
    ↓
Claude Codeに貼る
    ↓
原因調査 → 確認 → 修正
```

## テンプレートの使い方

- tpl/ の原本は編集しない
- 使うときにコピーして【】を埋める
- 使い終わったコピーは捨てるか、議事録として別保存
- 議事録が長い場合（5000文字超）は、先にClaude（claude.ai）で要約してから貼る

## スタック

Next.js + Supabase + TypeScript + Vercel で統一。

## 共通ルール

- .claude/rules/coding-standards.md — 全プロジェクト共通のコーディング規約
- .claude/settings.json — 権限 + Hooks（Stopフックで lint/typecheck/test を自動チェック）
- .claude/skills/self-improve/ — CLAUDE.md学習ログの自動判定
