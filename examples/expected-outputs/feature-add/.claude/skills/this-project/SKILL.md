# SKILL.md — CSV エクスポート + フィルター改修

---

## 禁止事項

- **既存のテーブル構成を変えない**（鈴木部長の指示 — マイグレーション禁止）
- フロントエンドから直接 DB を参照した CSV 生成は禁止（Route Handler 経由必須）
- フィルター UI のデザインを既存パターンから大きく変えない

## 実装ルール

- CSV エクスポートは `/api/products/export` Route Handler で生成する
- レスポンスヘッダー: `Content-Type: text/csv; charset=utf-8`, `Content-Disposition: attachment; filename=products_YYYYMMDD.csv`
- フィルターの状態は URL パラメータで管理する（Q-02 解消後に確定）

## テスト要件

- CSV エクスポートのテスト: 0件・1件・1,000件のケースを検証する
- フィルター: 以上/以下/両方なし の3パターンを検証する
