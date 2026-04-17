# 新規案件テンプレート

> 打ち合わせ議事録を元にClaude Codeで CLAUDE.md 一式を生成するための指示書。
>
> 使い方:
> 1. 【】を埋める
> 2. 打ち合わせ議事録を `docs/meetings/YYYY-MM-DD.md` に保存
> 3. Claude Codeに全文を貼り付ける

---

## 基本情報

- プロジェクト名: 【】
- クライアント: 【例: 株式会社○○】
- 概要: 【1〜2行で】

## 使用スタック宣言

> このセクションが**必須**。Claude Codeはここを見て適切な stack/*.md を読み込む。

- フロントエンド: 【例: Next.js / React / Vue.js / なし】
- バックエンド: 【例: FastAPI / Express / Supabase / Firebase Cloud Functions / なし】
- DB: 【例: Supabase (PostgreSQL) / RDS / Firestore / MongoDB】
- 認証: 【例: Supabase Auth / Cognito / Firebase Auth / 自前JWT】
- ストレージ: 【例: Supabase Storage / S3 / Cloud Storage】
- デプロイ先: 【例: Vercel / AWS ECS / Firebase Hosting】
- その他: 【例: Stripe決済, SendGridメール等】

**対応する stack ルール**:
- 使う: 【supabase, vercel のみ / aws, vercel / firebase / etc.】
- 使わない: 【残りは無視】

## 私のディレクション

> ここにあなたの方針・判断・補足を書く。
> 議事録にない技術的な判断や優先順位はここで指示する。

【例:
- 認証は Supabase Auth を使う
- 決済は Stripe で
- まずMVPとして顧客管理と案件管理だけ作る。請求機能はフェーズ2
- デザインは shadcn/ui ベースでシンプルに
】

---

## Claude Codeへの指示

以下の打ち合わせ議事録と私のディレクションを元に、このプロジェクトの設計ドキュメント一式を生成せよ。
コードはまだ存在しない新規プロジェクトである。

### 前提

作業開始前に以下を読むこと:
- `README.md`(ベース全体の使い方)
- `tpl/common/precautions.md`(共通注意事項)
- `docs/requirements/README.md`(フロー方針)
- 「使用スタック宣言」で指定された `.claude/rules/stack/*.md`

### Step 0: プラグイン存在チェック

`tpl/common/step0-preflight.md` の手順を実行せよ。

実行後、`tpl/common/step-confirmation.md` の定型で停止する。

### Step 1: 議事録分析と要件整理

末尾の議事録(または `docs/meetings/` 配下)を読み、以下の成果物を生成せよ。

#### 1-1. `docs/requirements/01-background.md` を生成

雛形は `docs/requirements/01-background.md` の構造に従う。
以下を埋める:
- 背景(現状、課題、トリガー)
- 目的(主目的、副目的)
- 成功基準(測定可能な形で)
- スコープ(やること/やらないこと)
- ステークホルダー
- 制約条件
- トレーサビリティ(各記述の出典)

#### 1-2. `docs/requirements/02-functional.md` を生成

雛形の構造に従う。以下を埋める:
- 機能要件(優先度別: MVP / フェーズ1後半 / フェーズ2)
- 各機能の受け入れ基準
- 非機能要件(パフォーマンス・セキュリティ・可用性・スケーラビリティ・運用)
- 依存関係マトリクス
- 各要件に source と confidence を付与

#### 1-3. `docs/requirements/03-open-questions.md` を生成

議事録・背景・機能要件の各段階で不明な点を Q-xx として登録。
- ブロッキング度
- 仮置きの値
- 確認先(顧客 / 社内 / 技術調査)
- 影響範囲

**重要**: 議事録で「要検討」「方向性」とされたものは、勝手に「確定」として扱わない。Q-xxに記録する。

#### 1-4. 画面構成・データ構造の推測

- 画面一覧(→ 後の Step 2 で docs/screens.md に反映)
- テーブル設計の推測(→ 後の Step 2 で docs/database.md に反映)

#### 1-5. 報告

以下を明示してユーザーに確認:
- 抽出した要件のサマリー
- 検出したQ-xxの件数と概要
- 推測した画面数とテーブル数
- 曖昧な点のリスト

報告後、`tpl/common/step-confirmation.md` の定型で停止する。

### Step 2: 要件統合と設計ドキュメント生成

確認が取れたら、以下を生成せよ。

#### 2-1. `docs/requirements/04-integrated.md` を生成

01〜03を統合した確定版要件書。未確定事項は仮値で進める。

#### 2-2. `docs/requirements/05-architecture.md` を生成

技術スタックの選定、ADR、各ビュー(論理/物理/データフロー/セキュリティ)、非機能要件の実現方針、コスト見積もり、テスト戦略。

**重要**: 使用スタック宣言で指定されたスタックに対応する `.claude/rules/stack/*.md` を必ず参照する。

#### 2-3. `docs/database.md` を生成

- 全テーブルのCREATE TABLE文
- Enum型の定義
- リレーション図(テキスト)
- 認可方針(スタックに応じて: Supabase RLS / AWS IAM等)
- インデックス方針

#### 2-4. `docs/api-endpoints.md` を生成

- エンドポイント一覧(メソッド、パス、認証、概要)
- リクエスト/レスポンス例
- エラーコード一覧

#### 2-5. `docs/features.md` を生成

- 機能一覧(優先度別)
- 各機能の概要
- ステータス遷移(あれば)

#### 2-6. `docs/screens.md` を生成

- 画面一覧
- 各画面の目的と主要操作
- 画面遷移図

#### 2-7. 報告

以下を明示:
- 生成したファイル一覧
- 未確定事項(Q-xx)の残件
- Step 3 に進む前に顧客確認が必要な項目

報告後、`tpl/common/step-confirmation.md` の定型で停止する。

### Step 3: ルール・スキル・設定生成

確認が取れたら、以下を生成せよ。

#### 3-1. `CLAUDE.md`(ルート、40〜50行・軽量版) を生成

以下の構造で生成する(このテンプレート内にはJSON等の本体は貼らない、生成の指針のみ):

- プロジェクト名と1行説明
- あなたの役割(1〜2文)
- 使用スタック
- プラグイン構成(5つ: ECC/Superpowers/Taskmaster/Context7/Playwright)
- 基本コマンド(スタックに応じて調整)
- ディレクトリ構造
- ブランチ運用
- 重要ルール
- 学習ログセクション(空でスタート)

#### 3-2. `.claude/skills/this-project/SKILL.md` を生成

詳細ルールを全てここに書く(TDD・コードレビュー・lint・並列実装はプラグイン担当なので書かない):

- プロジェクト情報
- 使用スタック(stack/ 配下のどれを参照するかを明示)
- 作業プロトコル
- 絶対にやってはいけないこと(プロジェクト固有の禁止事項)
- 業務ルール・制約
- 外部API・連携サービス
- 参照ドキュメント

#### 3-3. `.claude/rules/project/` の配下ルール

プロジェクト固有のルール(変更禁止ファイル、料金テーブル変更禁止等)を `.claude/rules/project/` に配置。

#### 3-4. `.claude/settings.json` を生成

`tpl/common/settings-template.json` をコピーし、以下のみ案件に応じて調整:
- lintコマンド(PostToolUse フック内)
- 基本コマンドに関連するパス

本体構造(Deny、Stopフック、SessionStartフック等)は改変禁止。

#### 3-5. 報告

生成したファイル一覧を明示。`tpl/common/step-confirmation.md` の定型で停止。

### Step 4: 実装

確認が取れたら実装を開始せよ。

- ブランチ作成: `git checkout -b feature/initial-implementation`
- セーフポイント: `git commit -m "WIP: 実装開始前のセーフポイント" --allow-empty`
- 独立した機能が複数ある場合は、ECCのAgent Teamsを使って並列実装
- 共通ファイルを触る機能は直列で進める
- ライブラリのAPIを使う箇所では必ず `use context7`
- 1機能実装 → git commit → 次の機能
- テスト通過まで main マージしない

実装中の確認:
- 影響ファイルが10以上になりそうなら一度停止してユーザー確認
- 仕様変更・破壊的変更を伴うなら一度停止

### Step 5: セキュリティチェック

`tpl/common/step-security-check.md` の手順を実行。

### Step 6: 報告

`tpl/common/step-report.md` のフォーマットで報告。

---

## 注意事項

`tpl/common/precautions.md` を参照せよ。すべてこのテンプレートに適用される。

---

## 打ち合わせ議事録

> 以下に議事録を貼り付けるか、`docs/meetings/YYYY-MM-DD.md` のパスを指定する。

【ここに議事録を貼る、または docs/meetings/YYYY-MM-DD.md を参照】
