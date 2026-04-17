# Firebase ルール

## Firestore セキュリティルール

- **全コレクションにセキュリティルールを必ず設定する**。例外なし
- `allow read, write: if true;` を本番環境で使うことを禁止する
- `request.auth != null` を全ルールの前提条件にする

```javascript
// ✅ 正しいセキュリティルール例
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /projects/{projectId} {
      allow read: if request.auth != null
                  && request.auth.uid in resource.data.memberIds;
      allow write: if request.auth != null
                   && request.auth.uid == resource.data.ownerId;
    }
  }
}
```

## Firebase Auth

- 独自認証システムの実装は禁止する（Firebase Auth を使う）
- カスタムクレームはサーバーサイド（Admin SDK）でのみ設定する
- ID トークンの検証は必ずサーバーサイドで行う

```typescript
// ✅ サーバーサイドでのトークン検証
import { getAuth } from 'firebase-admin/auth'

const decodedToken = await getAuth().verifyIdToken(idToken)
const uid = decodedToken.uid
```

## Cloud Functions（第 2 世代）

- 第 1 世代（`functions.https.onCall`）ではなく第 2 世代（`onCall` from `firebase-functions/v2`）を使う
- リージョンは `asia-northeast1`（東京）を指定する
- タイムアウトと最大インスタンス数を明示的に設定する
- 秘密情報は Secret Manager（`defineSecret`）で管理する

```typescript
// ✅ 第 2 世代の書き方
import { onCall } from 'firebase-functions/v2/https'
import { defineSecret } from 'firebase-functions/params'

const apiKey = defineSecret('API_KEY')

export const myFunction = onCall(
  { region: 'asia-northeast1', secrets: [apiKey], timeoutSeconds: 60 },
  async (request) => {
    // 処理
  }
)
```

## Firebase Storage

- Storage のセキュリティルールを必ず設定する
- ファイルパスにユーザー UID を含めてアクセス制御する

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## 環境変数・設定

- Firebase 設定（`firebaseConfig`）は公開 OK（API キーはクライアント識別用途のため）
- Admin SDK のサービスアカウントキーは絶対に公開しない（環境変数で管理）
- `process.env.FIREBASE_SERVICE_ACCOUNT` で JSON を取得する

## 禁止事項

- `allow read, write: if true;` を本番環境で使うことを禁止する
- Admin SDK のサービスアカウントキーをコードにハードコードすることを禁止する
- セキュリティルールなしで Firestore / Storage を本番公開することを禁止する
- Firebase Auth をバイパスした独自認証の実装を禁止する
- Cloud Functions の第 1 世代（`firebase-functions/v1`）を新規実装で使うことを禁止する
