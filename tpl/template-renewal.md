# リニューアル案件テンプレート

> 既存システムの情報 + 打ち合わせ議事録を元に
> Claude Codeで CLAUDE.md 一式を生成するための指示書。
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
- 新スタック: 【例: Next.js + Supabase + TypeScript】
- デプロイ先: 【例: Vercel】
- リポジトリ: 【例: github.com/xxx/xxx】

## 既存システムの情報

- 既存スタック: 【例: PHP + MySQL / WordPress / 手作業（システムなし）】
- 既存システムのURL: 【あれば】
- コード引き継ぎ: 【する / しない（作り直し）】
- データ移行: 【必要 / 不要 / 一部必要（何を？）】

## リニューアルの理由

> クライアントが何に困っていて、何を変えたいのかを書く。

【例:
- 現在のシステムが古く、スマホ対応していない
- 管理画面が使いにくく、毎回手作業が発生している
- 顧客情報がExcelで管理されていて検索できない
- 月額コストが高い（現在月5万円 → 下げたい）
】

## 残すもの・変えるもの

> 既存システムから何を残して何を変えるか明確にする。

### 残すもの（変えない）
【例:
- 既存の顧客データ（移行する）
- 現在の業務フロー（受注→制作→納品の流れ）
- ドメイン
】

### 変えるもの
【例:
- 技術スタック（PHP → Next.js + Supabase）
- デザイン（全面リニューアル）
- 管理画面（Excel → Web管理画面）
- ホスティング（レンタルサーバー → Vercel）
】

### 追加するもの
【例:
- 顧客管理機能
- 請求書自動生成
- スマホ対応
】

## 私のディレクション

> ここにあなたの方針・判断・補足を書く。

【例:
- 既存のPHPコードは引き継がない。ゼロから作り直す
- ただしDBのデータは移行する。移行スクリプトが必要
- 認証はSupabase Authを使う
- まずMVPとして管理画面を先に作る。公開サイトはフェーズ2
】

---

## Claude Codeへの指示

以下のリニューアル情報・打ち合わせ議事録・ディレクションを元に、
このプロジェクトの設計ドキュメント一式を生成せよ。

作業開始前に `.claude/skills/this-project/SKILL.md` が存在する場合は必ず読むこと。

### Step 0: 既存コードの確認（コード引き継ぎの場合のみ）

コード引き継ぎが「する」の場合：
1. 既存のコードベースを全て読み、構造を把握せよ
2. 既存のDB構成、API、機能を把握せよ
3. 問題点・技術的負債を列挙せよ

コード引き継ぎが「しない」の場合：このステップはスキップせよ。

### Step 1: 議事録 + リニューアル情報を分析

以下を整理せよ：

1. **現状の問題点** — 既存システムの何が問題か
2. **要件の抽出** — リニューアル後に必要な機能を一覧化
3. **残すもの・変えるもの・追加するものの確認**
4. **データ移行の要件** — 移行が必要なデータ、フォーマット、量
5. **業務フローの変更点** — 現在の業務フローとリニューアル後の違い
6. **データ構造の設計** — 新しいテーブル設計（既存データの受け皿を含む）
7. **画面構成の推測** — 必要な画面の一覧
8. **曖昧な点の列挙** — 判断が必要な点

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

## プロジェクト種別
リニューアル案件（既存: 【旧スタック】 → 新: 【新スタック】）

## スタック
（確定したスタック情報）

## プラグイン構成
- ECC（everything-claude-code）: スキル・エージェント・記憶システム
  - 並列実装はECCのAgent Teamsを使う
  - リサーチ・分析はdeep-researchスキルを使う
  - セキュリティレビューはdifferential-reviewスキルを使う
  - セッション終了時にInstinctとして自動学習される
- Superpowers: TDD・設計・コードレビューの品質管理
  - テスト戦略・コードレビューはSuperpowersに任せる
- Context7: ライブラリ使用時に最新Docを自動取得（use context7）
- Playwright: E2EテストはPlaywright-skillで自動実行

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
- テストが全て通過するまでマージしない

## リニューアル固有のルール
- データ移行スクリプトは scripts/ に配置する
- 既存データとの整合性を常に意識する
- 旧システムのURLからのリダイレクトを考慮する
（該当するもののみ記載）

## 重要ルール
- 作業開始時に必ず .claude/skills/this-project/SKILL.md を読むこと
- 詳細な作業プロトコル・禁止事項・参照ドキュメントは全てSKILL.mdに記載
- ライブラリのAPIや設定を扱う場合は必ずuse context7で最新Docを参照すること

## 学習ログ（プロジェクト固有の知見のみ）
> ECCのInstinctはコーディングパターン全般を自動学習する。
> ここにはこのプロジェクト固有の制約・クライアント固有の判断のみ記録する。
> 10件を超えたらdocs/lessons-learned.mdに整理してリセットすること。
```

#### .claude/skills/this-project/SKILL.md（詳細版・必要時だけ読み込み）

作業開始時・判断が必要な時だけ読み込まれる。詳細ルールを全てここに書く。

```
# 【プロジェクト名】プロジェクトスキル

## 作業プロトコル
1. 必ず計画を立ててから実装する。いきなりコードを書かない
2. 実装前にSuperpowersの/brainstormingで要件を整理する
3. 1つの変更につき1つの目的。複数の変更を混ぜない
4. 機能追加は必ず feature/xxx ブランチを作成してから作業を開始する
5. TDDで進める。Superpowersのred-green-refactorサイクルに従う
6. ライブラリのAPIを使う場合は必ず use context7 で最新Docを確認してから書く
7. コード変更後は必ず lint + typecheck + test を実行する
8. 既存のテストを勝手に削除しない。仕様変更に伴う更新は可
9. 新しいパターンを勝手に導入しない
10. わからないことがあれば推測せず確認する
11. 変更禁止ファイルには絶対に触らない
12. 大きい修正を始める前は必ず git commit -m "WIP: 作業開始前" を実行する
13. 1時間以上かかりそうな作業は途中でも定期的にWIPコミットを打つ
14. テストが全て通過したらユーザーに報告し、マージ指示を待つ

## 絶対にやってはいけないこと
（設計から判断して列挙）
- mainに直接コミットする
- ユーザーの確認なしにmainへマージする
- テストが通っていない状態でマージする
- use context7なしにライブラリの最新APIを推測で書く
- データ移行スクリプトをドライランなしに本番データに実行する

## 並列実装の方針
- 独立した機能が複数ある場合はECCのAgent Teamsで並列実装する
- 共通ファイル（DB設計、認証、移行スクリプトなど）を触る機能は直列で進める
- 並列実装の開始前に必ずインターフェースを確定させる

## 参照ドキュメント
- 作業開始時に必ず全て読むこと
- DB変更時: docs/database.md
- API変更時: docs/api-endpoints.md
- 機能仕様: docs/features.md
- 画面構成: docs/screens.md
- データ移行: docs/migration.md（移行がある場合のみ）
```

#### docs/database.md

- 全テーブルのCREATE TABLE文
- Enum型の定義
- リレーション図（テキストで）
- RLS（Row Level Security）の方針
- インデックスの方針
- **旧テーブルとの対応表**（データ移行がある場合）

#### docs/api-endpoints.md

- 主要なRPCやEdge Functionsの設計
- または REST APIの設計

#### docs/features.md

- 機能一覧（優先度付き: MVP / フェーズ2 / 将来）
- 各機能の概要説明
- ステータス遷移がある場合はその定義
- **旧システムとの機能対比表**

#### docs/screens.md

- 画面一覧
- 各画面の目的と主要な操作
- 画面遷移の流れ

#### docs/migration.md（データ移行がある場合のみ）

- 移行対象のデータ一覧
- 旧テーブル → 新テーブルのマッピング
- データクレンジングのルール（型変換、NULL処理など）
- 移行手順（スクリプト実行順序）
- ドライラン手順と検証方法
- 移行後の整合性チェック方法

### Step 3: ルールとスキル生成

#### .claude/skills/this-project/SKILL.md

上記で生成したSKILL.mdをこのパスに配置すること。
作業開始時に自動で読み込まれる。

#### .claude/rules/

既に存在する `coding-standards.md` はそのまま残す。
追加で、スタックに応じたルールを生成：

- Supabaseを使う場合 → `supabase.md`（マイグレーション手順、RLS、型生成）
- Vercelにデプロイする場合 → `deploy.md`（デプロイ手順、環境変数）
- データ移行がある場合 → `migration-rules.md`（移行スクリプトの書き方・ドライラン必須ルール）
- コード引き継ぎの場合 → `legacy-code.md`（既存コードの扱い方ルール）

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
            "command": "CHANGES=$(git diff --name-only HEAD 2>/dev/null | wc -l | tr -d ' '); STAGED=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' '); if [ \"$CHANGES\" -gt 0 ] || [ \"$STAGED\" -gt 0 ]; then printf '\\n📋 作業完了チェックリスト:\\n1. 禁止ファイルに触っていないか？\\n2. DB変更がある場合マイグレーションは作成したか？\\n3. データ移行スクリプトを変更した場合、ドライラン手順はdocs/migration.mdに記載されているか？\\n4. lint && typecheck && test を通過したか？\\n5. 機能変更なら /superpowers:differential-review を実行し0件になるまで修正せよ\\n6. 0件になったら「確認をお願いします。マージ指示をお待ちしています」と報告せよ\\n7. プロジェクト固有のミスがあればCLAUDE.md学習ログに追記せよ\\n'; fi"
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
- TDDで進める。Superpowersのred-green-refactorサイクルに従う
- ライブラリのAPIを使う箇所では必ず `use context7` を付けること
- 1機能実装 → lint + typecheck + test → git commit → 次の機能の順で進める
- データ移行スクリプトは必ずドライランで検証してから本番データに実行すること
- テストが全て通過するまでマージしない

### Step 5: 報告

生成が完了したら以下を報告せよ：

1. 作成したファイルの一覧
2. CLAUDE.mdの行数
3. docs/の各ファイルの概要
4. **データ移行のリスクと注意点**（移行がある場合）
5. Step 1で列挙した「曖昧な点」の再確認
6. 開発を始める前に決めるべきこと

---

## 注意事項

- CLAUDE.mdに仕様の詳細を書かない。全てdocs/に分離すること
- CLAUDE.mdには毎回読む必要がある判断ルールだけ書くこと
- 議事録から読み取れない部分は推測せず、曖昧な点として列挙すること
- 既存の .claude/rules/coding-standards.md は上書きしないこと
- settings.jsonのhooksは新フォーマット（matcher文字列 + hooks配列）を使うこと
- Step 1の確認（「OK」の返答）なしにStep 2に進まないこと。確認前に進んだ場合は即座に停止すること
- データ移行がある場合、移行スクリプトは必ずドライラン機能を持たせること
- lint・typecheck・testのチェックはECCのフックが自動で行うため、Stopフックのpromptに重複して書かない

---

## 打ち合わせ議事録

> 以下に議事録を貼り付けてください。

【ここに議事録を貼る】
