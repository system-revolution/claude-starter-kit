# 05 アーキテクチャ設計

source: renewal-sample.md
generated: Step 3

---

## ADR-001: Vercel Rewrites による URL 構造保持

**ステータス**: accepted
**決定日**: 2026-04-10

### 決定

WordPress の既存 URL 構造を Vercel の rewrites/redirects で完全に再現する。

### 理由

- SEO 維持のため URL 変更は最小化する（高橋様の要件）
- Vercel の `vercel.json` rewrite ルールで Next.js の動的ルーティングに転送できる
- WordPress の `/?p=123` 形式は 301 リダイレクトで `/posts/[slug]` へ転送する

---

## ADR-002: Supabase Storage による画像移行

**ステータス**: proposed（Q-01 解消待ち）
**決定日**: 未定

### コンテキスト

WordPress の画像（5GB）の移行先として Supabase Storage vs Cloudflare Images vs S3 を検討。

### 仮決定

Supabase Storage（Pro プランで 100GB）を採用する方向。

### 理由

- 追加インフラ不要（Supabase に統合）
- 月額予算（1万円程度）に概ね適合
- CDN 配信が Supabase Pro に含まれる

---

## ADR-003: Supabase の pg_bigm による日本語全文検索

**ステータス**: proposed（Q-05 解消待ち）
**決定日**: 未定

### コンテキスト

日本語全文検索を PostgreSQL 内蔵機能で実現するか、Algolia 等の外部サービスを使うかを検討。

### 仮決定

PostgreSQL の `pg_bigm` 拡張を採用する（Supabase で有効化可能）。

### 理由

- 2,000記事規模では Algolia の月額コスト（$50〜）は過剰
- pg_bigm は日本語 n-gram インデックスで十分な精度
- 外部依存を増やさずにコストを抑えられる

---

## システム移行フロー

```
[Phase 1] 開発環境構築
  └── Next.js + Supabase のセットアップ
  └── WordPress と並行稼働

[Phase 2] データ移行（Q-01 解消後に詳細化）
  └── WordPress MySQL → Supabase PostgreSQL
  └── 画像 → Supabase Storage
  └── 移行スクリプト: scripts/migrate/

[Phase 3] 切り替え
  └── DNS 切り替え（ゼロダウンタイム or 計画停止）
  └── Vercel rewrite 設定で URL 保持
  └── 旧 WordPress はリードオンリーで2週間維持
```
