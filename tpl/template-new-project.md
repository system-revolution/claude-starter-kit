# 新規案件テンプレート

> 打ち合わせ議事録を元にClaude Codeで CLAUDE.md 一式を生成するための指示書。
>
> 使い方:
> 1. 【】を埋める
> 2. 打ち合わせ議事録を末尾に貼る
> 3. Claude Codeに全文を貼り付ける

---

## 基本情報

- プロジェクト名: 【】
- クライアント: 【例: 株式会社○○】
- 概要: 【1〜2行で】
- スタック: 【例: Next.js + Supabase + TypeScript】
- デプロイ先: 【例: Vercel】
- リポジトリ: 【例: github.com/xxx/xxx】

## 私のディレクション

> ここにあなたの方針・判断・補足を書く。
> 議事録にない技術的な判断や優先順位はここで指示する。

【例:
- 認証はSupabase Authを使う
- 決済はStripeで
- まずMVPとして顧客管理と案件管理だけ作る。請求機能はフェーズ2
- デザインはshadcn/uiベースでシンプルに
】

---

## Claude Codeへの指示

以下の打ち合わせ議事録と私のディレクションを元に、このプロジェクトの設計ドキュメント一式を生成せよ。
コードはまだ存在しない新規プロジェクトである。

作業開始前に `.claude/skills/this-project/SKILL.md` が存在する場合は必ず読むこと。

### Step 1: 議事録を分析

末尾の打ち合わせ議事録を読み、以下を整理せよ：

1. **要件の抽出** — クライアントが求めている機能を一覧化
2. **業務フローの把握** — ユーザーがどういう順序で操作するか
3. **データ構造の推測** — どんなテーブルが必要か（テーブル名、主要カラム、リレーション）
4. **画面構成の推測** — 必要な画面の一覧
5. **曖昧な点の列挙** — 議事録から読み取れない判断が必要な点

整理結果を私に報告し、以下を出力して停止せよ：

```
---WAITING FOR CONFIRMATION---
上記の内容を確認してください。「OK」の返答があるまでStep 2に進むことを禁止する。
```

### Step 2: 設計ドキュメント生成

確認が取れたら、以下を生成せよ。

#### CLAUDE.md（40〜50行・軽量版）

常時読み込まれる。最小限の情報だけ書くこと。詳細はSKILL.mdに分離する。

```
# CLAUDE.md — 【プロジェクト名】（1行の説明）

## あなたの役割
（このプロジェクトでClaude Codeが担う役割を1〜2文で）

## スタック
（確定したスタック情報）

## プラグイン構成（起動時に自動適用）
- **ECC（everything-claude-code）**: コードレビュー・セキュリティ・Instinct自動学習
  - 並列実装はECCのAgent Teamsを使う（独立機能は同時進行）
  - セキュリティスキャンは /security-scan で実行
- **Superpowers**: TDD・設計・コードレビューの品質管理
  - 複雑な実装前は必ず /superpowers:brainstorm
  - 大規模変更前は /superpowers:write-plan で計画書を作成
  - バグ修正は /superpowers:debug（推測で直さない）
- **Taskmaster**: タスク分解・追跡・セッション間コンテキスト維持
  - 作業前に task-master next で次タスクを確認
- **Context7**: ライブラリ使用時に最新Docを自動取得（use context7）
- **Playwright**: E2EテストはPlaywright-skillで自動実行

## 基本コマンド
npm run dev    — 開発サーバー起動
npm run build  — ビルド
npm run lint   — lint実行
（スタックに応じて調整）

## ディレクトリ構造
（スタックの標準構成を記載）

## ブランチ運用
- feature/xxx, fix/xxx, hotfix/xxx でブランチを切ること
- mainへの直接コミット・マージ禁止（Hookが検知する）

## 重要ルール
- 作業開始時に必ず .claude/skills/this-project/SKILL.md を読むこと
- プロジェクト固有の業務ルール・禁止事項はすべてSKILL.mdに記載
- ライブラリのAPIや設定を扱う場合は必ずuse context7で最新Docを参照すること

## 学習ログ（プロジェクト固有の知見のみ）
> ECCのInstinctはコーディングパターン全般を自動学習する。
> ここにはこのプロジェクト固有の制約・クライアント固有の判断のみ記録する。
> 10件を超えたらdocs/lessons-learned.mdに整理してリセットすること。
```

#### .claude/skills/this-project/SKILL.md（詳細版・必要時だけ読み込み）

作業開始時・判断が必要な時だけ読み込まれる。詳細ルールを全てここに書く。
**★ TDD・コードレビュー・lint・並列実装はプラグインが担当する。ここには書かないこと。**

```
# 【プロジェクト名】プロジェクトスキル

## このプロジェクトについて
- クライアント: 【社名】
- 目的・背景: 【1〜2行】
- 特記事項: 【あれば】

## 作業プロトコル
1. 必ず計画を立ててから実装する。いきなりコードを書かない
2. 複雑な実装前は /superpowers:brainstorm で設計を整理する
3. 1つの変更につき1つの目的。複数の変更を混ぜない
4. 機能追加は必ず feature/xxx ブランチを作成してから作業を開始する
5. ライブラリのAPIを使う場合は必ず use context7 で最新Docを確認してから書く
6. 既存のテストを勝手に削除しない。仕様変更に伴う更新は可
7. 新しいパターンを勝手に導入しない
8. わからないことがあれば推測せず確認する
9. 変更禁止ファイルには絶対に触らない
10. 大きい修正を始める前は必ず git commit -m "WIP: 作業開始前" を実行する
11. テストが全て通過したらユーザーに報告し、マージ指示を待つ

## 絶対にやってはいけないこと
（設計・議事録から判断してプロジェクト固有の禁止事項を列挙する）
- 【例: 料金テーブルを変更する】
- 【例: 本番DBを直接操作する】

## 業務ルール・制約
（このクライアント固有のビジネスルール）
- 【例: ステータスは○○の4種類のみ。追加禁止】
- 【例: ○○の金額は変更禁止】

## 外部API・連携サービス
（使用する外部APIがある場合のみ記載）
- 【例: ○○API — 認証: APIキー（環境変数: XXX_API_KEY）、レートリミット: 100req/min】

## 参照ドキュメント
- DB設計: docs/database.md
- APIエンドポイント: docs/api-endpoints.md
- 機能仕様: docs/features.md
- 画面構成: docs/screens.md
```

#### docs/database.md

- 全テーブルのCREATE TABLE文（Supabaseの場合はSQL）
- Enum型の定義
- リレーション図（テキストで）
- RLS（Row Level Security）の方針
- インデックスの方針

#### docs/api-endpoints.md

- Supabaseの場合: 主要なRPCやEdge Functionsの設計
- REST APIの場合: エンドポイント一覧（メソッド、パス、認証、概要）

#### docs/features.md

- 機能一覧（優先度付き: MVP / フェーズ2 / 将来）
- 各機能の概要説明
- ステータス遷移がある場合はその定義

#### docs/screens.md（新規案件のみ）

- 画面一覧
- 各画面の目的と主要な操作
- 画面遷移の流れ

### Step 3: ルールとスキル生成

#### .claude/skills/this-project/SKILL.md

上記で生成したSKILL.mdをこのパスに配置すること。
作業開始時に自動で読み込まれる。

#### .claude/rules/

既に存在する `coding-standards.md` はそのまま残す。
追加で、スタックに応じたルールを生成：

- Supabaseを使う場合 → `supabase.md`（マイグレーション手順、RLS、型生成）
- Vercelにデプロイする場合 → `deploy.md`（デプロイ手順、環境変数）
- その他スタック固有のルール

#### .claude/settings.json

以下の構造で生成。lintコマンドはスタックに合わせる：

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(npx *)",
      "Bash(git *)",
      "Read(*)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Bash(curl *)",
      "Bash(wget *)",
      "Bash(rm -rf /)"
    ]
  },
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "git diff --name-only HEAD 2>/dev/null | grep -E '^\\.env' && echo '🚨 WARNING: .envファイルが変更されています！中断してください。' || true"
          },
          {
            "type": "command",
            "command": "COUNT=$(awk '/^## 学習ログ/{found=1} found && /^- /{count++} END{print count+0}' CLAUDE.md 2>/dev/null); if [ \"$COUNT\" -ge 10 ]; then echo \"📚 学習ログが${COUNT}件に達しました。docs/lessons-learned.mdへ整理してCLAUDE.mdの学習ログをリセットしてください。\"; fi"
          },
          {
            "type": "command",
            "command": "CHANGES=$(git diff --name-only HEAD 2>/dev/null | wc -l | tr -d ' '); STAGED=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' '); if [ \"$CHANGES\" -gt 0 ] || [ \"$STAGED\" -gt 0 ]; then printf '\\n📋 作業完了チェックリスト:\\n1. 禁止ファイルに触っていないか？\\n2. DB変更がある場合マイグレーションは作成したか？\\n3. lint && typecheck && test を通過したか？\\n4. 機能変更なら /superpowers:differential-review を実行し0件になるまで修正せよ\\n5. 0件になったら「確認をお願いします。マージ指示をお待ちしています」と報告せよ\\n6. プロジェクト固有のミスがあればCLAUDE.md学習ログに追記せよ\\n'; fi"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash(git commit*)",
        "hooks": [
          {
            "type": "command",
            "command": "git branch --show-current 2>/dev/null | grep -E '^(feature|fix|hotfix)/' || echo '🚨 WARNING: mainブランチへの直接コミットです！feature/fix/hotfixブランチを作成してください。'"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "npm run lint:fix --quiet 2>/dev/null || true"
          }
        ]
      }
    ]
  }
}
```

### Step 4: 実装

設計ドキュメントの確認が取れたら実装を開始せよ。

- 独立した機能が複数ある場合は、ECCのAgent Teamsを使って並列で実装すること（共通ファイルを触る機能は直列で進めること）
- ライブラリのAPIを使う箇所では必ず use context7 を付けること
- 1機能実装 → git commit → 次の機能の順で進める
- テストが全て通過するまでマージしない

### Step 5: 報告

生成が完了したら以下を報告せよ：
1. 作成したファイルの一覧
2. CLAUDE.mdの行数
3. docs/の各ファイルの概要
4. Step 1で列挙した「曖昧な点」の再確認
5. 開発を始める前に決めるべきこと

---

## 注意事項

- CLAUDE.mdに仕様の詳細を書かない。全てdocs/に分離すること
- CLAUDE.mdには毎回読む必要がある判断ルールだけ書くこと
- 議事録から読み取れない部分は推測せず、曖昧な点として列挙すること
- 既存の .claude/rules/coding-standards.md は上書きしないこと
- settings.jsonのhooksは新フォーマット（matcher文字列 + hooks配列）を使うこと
- Step 1の確認（「OK」の返答）なしにStep 2に進まないこと。確認前に進んだ場合は即座に停止すること
- lint・typecheck・testのチェックはECCのフックが自動で行うため、Stopフックのpromptに重複して書かない

---

## 打ち合わせ議事録

> 以下に議事録を貼り付けてください。

【ここに議事録を貼る】
