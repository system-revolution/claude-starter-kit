# 共通: 注意事項

全テンプレートで適用される共通の注意事項。

## ドキュメント管理

- CLAUDE.md に仕様の詳細を書かない(全て docs/ に分離)
- CLAUDE.md には毎回読む必要がある判断ルールだけ書く
- 議事録から読み取れない部分は推測せず、`docs/requirements/03-open-questions.md` に Q-xx として記録

## ベースファイルの扱い

- 既存の `.claude/rules/common/coding-standards.md` は上書きしない
- `.claude/rules/stack/` は案件で使うスタックのみを参照(不要ファイルの削除はオプション)
- `.claude/rules/project/` は案件固有ルールの置き場

## settings.json

- settings.json は `tpl/common/settings-template.json` を単一ソースとする
- テンプレート内にJSON本体を貼り付けてはならない
- lintコマンド等、スタック固有の部分のみ案件側で調整

## ブランチ運用

- main には直接コミットしない
- 必ず feature/xxx, fix/xxx, hotfix/xxx, upgrade/xxx のいずれかのブランチを切る
- ユーザー確認なしに main にマージしない

## 確認ゲート

- 各Stepの確認(「OK」の返答)なしに次Stepに進まない
- 確認前に進んだ場合は即座に停止し、ユーザーに報告する

## プラグイン

- lint・typecheck・test の自動チェックは ECC のフックが行う
- Stopフックのチェックリストに lint/typecheck/test の重複記述をしない
- プラグイン未インストールの場合は Step 0 で警告し、ユーザー判断を仰ぐ

## 未確定事項

- 仮値で進める場合、影響する全ファイルに `# TODO: Q-xx 確定後に更新` コメントを必ず入れる
- `docs/requirements/03-open-questions.md` に Q-xx を登録する
- Q-xxが解決したら、影響ファイルを全て更新し、Resolved表に移動

## トレーサビリティ

- 要件記述には可能な限り source (出典) と confidence を付与する
- 「確定」ステータスへの昇格は顧客合意が必須(SE判断のみで昇格してはならない)
