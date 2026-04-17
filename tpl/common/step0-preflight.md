# Step 0: プラグイン存在チェック(preflight)

作業開始前に、本ベースが前提とするプラグインがインストールされているか確認する。

## 実行内容

1. `bash .claude/scripts/check-plugins.sh` を実行
2. 警告が出力されたら、以下をユーザーに報告:
   - 不足しているプラグイン
   - インストールしない場合に動作しない機能
   - インストール方法(各プラグインのドキュメントを参照)
3. ユーザーから「続行」の指示があるまで停止

## 必須プラグイン

- **superpowers**: TDD、brainstorm、write-plan、debug
- **everything-claude-code (ECC)**: コードレビュー、セキュリティ、Agent Teams、Instinct学習
- **taskmaster**: タスク分解・追跡
- **context7**: ライブラリ最新Doc取得
- **playwright-skill**: E2Eテスト

## 出力フォーマット

```
プラグインチェックを実行しました。

[結果]
- superpowers: ✅ インストール済み
- everything-claude-code: ✅ インストール済み
- taskmaster: ❌ 未インストール
- context7: ✅ インストール済み
- playwright-skill: ❌ 未インストール

[影響]
- taskmaster未インストール → task-master next コマンドが動作しない
- playwright-skill未インストール → E2Eテストが動作しない

インストール後に続行する場合は「インストール完了」と返答してください。
このまま続行する場合は「続行」と返答してください(一部機能が使えません)。
```

## 停止条件

ユーザーから「続行」または「インストール完了」の返答があるまで、次のStepに進むことを禁止する。
