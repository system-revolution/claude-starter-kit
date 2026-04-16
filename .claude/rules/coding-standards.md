# コーディング規約

> テスト戦略・コードレビュー・セキュリティレビューはSuperpowersが管理する。
> E2EテストはPlaywright-skillが担当する。
> ここには命名・構造・エラーハンドリング・状態管理・Gitの規約のみ記載する。

## 関数

- 1関数 = 1責務。2つのことをしている関数は分割する
- 関数は30行以内。超えたら分割のサイン
- 引数は3つ以下。4つ以上ならオブジェクトにまとめる
- 戻り値の型を明示する（TypeScriptの場合）
- ネストは3階層まで。深くなったら早期リターンで解消する

```typescript
// ❌ 深いネスト
function process(user) {
  if (user) {
    if (user.isActive) {
      if (user.role === 'admin') {
        // 処理
      }
    }
  }
}

// ✅ 早期リターン
function process(user) {
  if (!user) return
  if (!user.isActive) return
  if (user.role !== 'admin') return
  // 処理
}
```

## 命名

- 変数名・関数名は「何をするか」が読んでわかる名前にする
- 省略禁止: `usr` → `user`、`btn` → `button`、`qty` → `quantity`
- boolean は `is` `has` `can` `should` で始める: `isActive`、`hasPermission`
- 配列は複数形: `users`、`items`、`orders`
- 関数は動詞で始める: `getUser`、`createOrder`、`validateEmail`
- 定数は UPPER_SNAKE_CASE: `MAX_RETRY_COUNT`、`API_BASE_URL`
- コンポーネントは PascalCase: `UserProfile`、`OrderList`

## ファイル構成

- 1ファイル = 1コンポーネント or 1モジュール
- ファイルは200行以内。超えたら分割を検討
- インポートの順序: 外部ライブラリ → 内部モジュール → 型定義 → スタイル
- 循環参照（A→B→A）を作らない

## エラーハンドリング

- try-catchで握りつぶさない。catchしたら必ずログ出力またはユーザーへの通知を行う
- エラーメッセージはユーザーが読んでわかる日本語にする
- API呼び出しは必ずエラーハンドリングする。ネットワークエラー、タイムアウト、4xx、5xxを考慮
- nullやundefinedの可能性がある値は使用前にチェックする

```typescript
// ❌ 握りつぶし
try {
  await saveData()
} catch (e) {
  // 何もしない
}

// ✅ 適切なハンドリング
try {
  await saveData()
} catch (e) {
  console.error('データ保存に失敗:', e)
  toast.error('保存に失敗しました。もう一度お試しください。')
}
```

## 状態管理

- 同じ情報を2箇所に持たない（Single Source of Truth）
- 計算で出せる値をstateに持たない: `total` = `price * quantity` ならstateに`total`は不要
- グローバル状態は最小限にする。コンポーネント内で完結するならローカルstateで十分
- ローディング状態とエラー状態は必ず管理する

## API・データ取得

- APIの呼び出しはコンポーネントから直接行わず、専用の関数やhookに分離する
- ローディング中はスケルトンやスピナーを表示する
- エラー時はリトライボタンを表示する
- 楽観的更新（Optimistic Update）は使わない。サーバーの応答を待ってからUIを更新する

## セキュリティ

- ユーザー入力は必ずバリデーションする（フロントとバック両方）
- SQLインジェクション対策: 文字列結合でクエリを作らない。パラメータ化する
- XSS対策: ユーザー入力をそのままDOMに出力しない。必ずエスケープする
- 認証チェック: 全APIエンドポイントに認証を必須とする
- 認可チェック: 認証済みでも他ユーザーのデータにアクセスできないようにする（SupabaseはRLSで必ず制御）
- 秘密情報（APIキー、トークン）をコードにハードコードしない。環境変数を使う
- .envファイルはgitにコミットしない

## コメント

- 「何をしているか」ではなく「なぜそうしているか」をコメントに書く
- コード自体が説明的であればコメント不要
- TODO/FIXMEには必ず理由と対応時期を書く: `// TODO: 2024-03 API v2移行後に削除`
- コメントアウトしたコードは残さない。gitに履歴がある

## Git

- コミットメッセージは日本語OK。「何を変更したか」を1行で書く
- 1コミット = 1つの変更目的。バグ修正と新機能を同じコミットに混ぜない
- コミット前にビルドが通ることを確認する
