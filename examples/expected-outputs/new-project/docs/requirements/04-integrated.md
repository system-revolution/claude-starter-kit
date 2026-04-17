# 04 統合要件定義（確定版）

source: 01-background.md + 02-functional.md + 03-open-questions.md
generated: Step 2（Q 解消後に更新）

> **NOTE**: Q-01〜Q-05 が未解消のため、関連機能は `tentative` のまま。
> Q 解消後にこのファイルを更新すること。

---

## プロジェクト基本情報

| 項目 | 内容 |
|------|------|
| プロジェクト名 | サンプル在庫管理システム |
| クライアント | 株式会社サンプル商事 |
| リリース目標 | 2026-07（3ヶ月後） |
| スタック | Next.js 15 + Supabase + Vercel |

---

## MVP スコープ（確定）

以下の機能を Phase 1 MVP として開発する。

| ID | 機能 | 状態 |
|----|------|------|
| F-01 | 認証・権限管理 | confirmed |
| F-02 | 商品マスター管理 | confirmed |
| F-03 | 拠点別在庫管理 | confirmed |
| F-04 | 入庫・出庫管理 | confirmed |
| F-05 | 在庫アラート（メール通知） | tentative（Q-01, Q-03 待ち） |
| F-06 | CSV エクスポート・インポート | tentative（Q-04 待ち） |

---

## 非機能要件

### パフォーマンス

- 商品一覧（500件）: 初期表示 2秒以内
- 入出庫登録: レスポンス 1秒以内
- 在庫数更新: Supabase Realtime で 5秒以内に反映

### セキュリティ

- 全エンドポイントに Supabase Auth による認証を必須とする
- 全テーブルに RLS を適用し、ロール別のアクセス制御を実施
- 在庫金額（単価×数量）は `admin` ロールのみ閲覧可（Q-02 解消後に詳細設計）

### 可用性

- 目標稼働率: 99%（年 1〜2 回のメンテナンスダウンは許容）
- Vercel + Supabase のマネージドサービスで対応

---

## データモデル概要

```
products          # 商品マスター
locations         # 拠点マスター（本社・倉庫A・倉庫B）
inventory         # 在庫数（products × locations）
stock_movements   # 入出庫履歴
users             # Supabase Auth ユーザー（拡張）
alert_settings    # アラート設定（Q-01, Q-03 解消後に詳細化）
```

---

## 画面一覧

| 画面 | URL | ロール |
|------|-----|--------|
| ログイン | /login | 全員 |
| ダッシュボード | / | 全員 |
| 商品一覧 | /products | 全員 |
| 商品詳細・編集 | /products/[id] | 全員（admin のみ編集） |
| 拠点別在庫一覧 | /inventory | 全員 |
| 入出庫登録 | /movements/new | staff, admin |
| 入出庫履歴 | /movements | 全員 |
| CSV インポート | /import | admin |
| 設定 | /settings | admin |

---

## 未解消 Q の影響

| Q-No | 影響する設計 |
|------|-------------|
| Q-01 | F-05 詳細設計・Edge Functions 実装 |
| Q-02 | RLS ポリシー設計・DB スキーマ |
| Q-03 | alert_settings テーブル設計 |
| Q-04 | F-06 インポートロジック |
| Q-05 | Phase 2 ロードマップ |
