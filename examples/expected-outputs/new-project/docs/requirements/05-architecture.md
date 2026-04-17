# 05 アーキテクチャ設計

source: 01-background.md + 02-functional.md
generated: Step 3

---

## システム構成図

```
[ブラウザ / スマホ]
      │
      │ HTTPS
      ▼
[Vercel Edge Network]
  ┌─────────────────┐
  │ Next.js 15      │
  │ App Router      │
  │ (SSR + RSC)     │
  └────────┬────────┘
           │ Supabase Client
           ▼
[Supabase]
  ├── PostgreSQL（RLS有効）
  ├── Auth（JWT）
  ├── Realtime（在庫数変更）
  ├── Storage（CSV ファイル）
  └── Edge Functions（メール通知）
           │
           ▼
[Resend] メール送信（Q-01 解消後に確定）
```

---

## ADR-001: Next.js App Router + Supabase 直接接続

**ステータス**: accepted
**決定日**: 2026-04-10

### コンテキスト

バックエンド API サーバーを別途立てるか、Supabase を直接使うかを検討した。

### 決定

Next.js App Router の Server Actions / Route Handlers から Supabase を直接接続する構成を採用する。Hono 等の別途バックエンドは設けない。

### 理由

- 5 名規模のシステムにバックエンドサーバーを別途運用するコストは不要
- Supabase の RLS でアクセス制御が完結する
- Edge Functions で軽量な非同期処理（メール通知等）が対応可能
- 月額 3 万円以内の予算制約に適合

### トレードオフ

- 将来的に複雑なビジネスロジックが増えた場合は Edge Functions または別途 API サーバーに移行する
- freee 等の外部 API 連携が必要になった場合は Route Handlers を追加する

---

## ADR-002: Supabase Realtime による在庫数同期

**ステータス**: accepted
**決定日**: 2026-04-10

### コンテキスト

複数拠点での在庫リアルタイム同期を実現するための手段を検討した。

### 決定

Supabase Realtime（PostgreSQL の変更通知）を使用し、在庫数テーブルの変更をブラウザにプッシュする。

### 理由

- ポーリングより即時性が高い
- Supabase に内包されており追加コスト・インフラ不要
- 5 名規模の同時接続数では Realtime の制限に引っかからない

---

## ADR-003: Vercel デプロイ構成

**ステータス**: accepted
**決定日**: 2026-04-10

### コンテキスト

デプロイ先として Vercel Pro と AWS (EC2/ECS) を比較した。

### 決定

Vercel Hobby → Pro プランを使用する。

### 理由

- Next.js との統合が最も優れており設定コストが最小
- 月額予算（3 万円以内）に適合（Vercel Pro: $20/月 + Supabase Pro: $25/月）
- CI/CD がデフォルトで構成される
- Edge Network による静的資産の高速配信

---

## ADR-004: 認証方式（Supabase Auth）

**ステータス**: accepted
**決定日**: 2026-04-10

### 決定

Supabase Auth のメール + パスワード認証を採用する。SSO / OAuth は不要。

### 理由

- 社内 5 名のみの利用で SSO は過剰
- Supabase Auth は RLS と統合されており JWT クレームでロール制御が可能
- 初期費用・月額コストへの影響なし

---

## 技術スタック確定表

| レイヤー | 技術 | バージョン | 備考 |
|----------|------|-----------|------|
| フロントエンド | Next.js | 15 (App Router) | |
| UI | shadcn/ui + Tailwind CSS | v4 | |
| 言語 | TypeScript | 5.x strict | |
| DB | PostgreSQL | Supabase 管理 | |
| ORM | Drizzle ORM | latest | |
| 認証 | Supabase Auth | | |
| リアルタイム | Supabase Realtime | | |
| ストレージ | Supabase Storage | | CSV 一時保管 |
| メール | Resend | | Q-01 解消後に確定 |
| デプロイ | Vercel Pro | | |
