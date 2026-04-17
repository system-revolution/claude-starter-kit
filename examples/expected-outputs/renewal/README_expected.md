# expected-outputs/renewal/ — サンプル意図説明

## このサンプルについて

入力: `examples/sample-minutes/renewal-sample.md`
テンプレート: `tpl/template-renewal.md`
生成フェーズ: Step 3 まで（実装は含まない）

## 想定した設定

- プロジェクト名: サンプルリニューアル（WordPress → Next.js）
- クライアント: 株式会社リニューアル例
- 既存システム: WordPress + MySQL（10年運用・2,000記事・月間PV 50,000）
- 新スタック: Next.js + Supabase + Vercel
- 対応 stack ルール: supabase, vercel

## このサンプルで確認できること

1. **01-background.md**: 既存システムの問題点と移行方針が正確に抽出されているか
2. **02-functional.md**: 移行対象（記事・画像）と新規追加機能（全文検索・関連記事）が区別されているか
3. **03-open-questions.md**: データ移行仕様（記事・画像・URL構造）に関するQが登録されているか
4. **04-integrated.md**: 既存機能の引き継ぎと新機能の追加が統合されているか
5. **05-architecture.md**: WordPress から Supabase への移行 ADR が適切か
6. **CLAUDE.md**: リニューアル特有の制約（SEO維持・URL構造保持）が記載されているか
7. **SKILL.md**: データ移行スクリプトのルール・移行禁止事項が記載されているか

## 評価基準

- 移行対象データ（2,000記事・5GB画像）の扱いが明記されていること
- URL構造保持（SEO）のための Vercel rewrite 設定が ADR に含まれていること
- データ移行フェーズ（開発と並行 or 切り替え直前）が Q として登録されていること
- WordPress の既存機能（Contact Form 7 等）の移行可否がQ として確認されていること
