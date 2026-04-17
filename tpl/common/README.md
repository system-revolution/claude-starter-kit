# tpl/common/ 共通テンプレート断片

4テンプレート(新規/リニューアル/機能追加/保守)で共通する部分を切り出したもの。
テンプレート内から参照することでDRY違反を回避する。

## ファイル一覧

- `step0-preflight.md`: プラグイン存在チェックの定型
- `step-confirmation.md`: WAITING FOR CONFIRMATION の定型
- `step-security-check.md`: セキュリティチェックの定型
- `step-report.md`: 報告の定型
- `precautions.md`: 注意事項の定型
- `settings-template.json`: settings.json の単一ソース

## 使い方

テンプレート側からこのディレクトリのファイルを参照する。
Claude Codeはテンプレートを読みながら、参照されたファイルも読み込んで指示を理解する。

例: `tpl/template-new-project.md` 内
```
### Step 0: プラグイン存在チェック

`tpl/common/step0-preflight.md` の手順を実行せよ。
```
