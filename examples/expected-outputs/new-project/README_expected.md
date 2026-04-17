# expected-outputs/new-project/ — サンプル意図説明

## このサンプルについて

入力: `examples/sample-minutes/new-project-sample.md`
テンプレート: `tpl/template-new-project.md`
生成フェーズ: Step 3 まで(実装は含まない)

## 想定した設定

- プロジェクト名: サンプル在庫管理システム
- クライアント: 株式会社サンプル商事
- スタック: Next.js + Supabase + Vercel
- 対応 stack ルール: supabase, vercel

## このサンプルで確認できること

1. **01-background.md**: 議事録から背景・目的・スコープを正確に抽出できているか
2. **02-functional.md**: MVP/フェーズ1後半/フェーズ2の優先度分けが適切か
3. **03-open-questions.md**: 「メール通知のSMTP設定」「権限レベルの詳細」等、未確定事項をQ-xxとして登録しているか
4. **04-integrated.md**: 01〜03を統合した確定版が正しく生成されているか
5. **05-architecture.md**: Supabase + Vercel の構成でADRが適切に書かれているか
6. **CLAUDE.md**: 40〜50行の軽量版で、詳細はSKILL.mdに委ねているか
7. **SKILL.md**: プロジェクト固有の禁止事項・業務ルールが網羅されているか

## 評価基準

- Q-xxの件数が3件以上あること(議事録で未確定な事項が必ず存在するため)
- 各要件に source と confidence が付与されていること
- settings.json にJSONの直書きがなく `tpl/common/settings-template.json` 参照になっていること
