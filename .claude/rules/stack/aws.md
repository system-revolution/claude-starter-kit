# AWS ルール

## IAM

- 最小権限の原則を守る。必要なリソースにのみアクセス権を付与する
- IAM ユーザーのアクセスキーをコードやリポジトリに含めることを禁止する
- ロールベースのアクセス制御（IAM Role）を使う。長期アクセスキーは避ける
- MFA を有効化する（本番アカウントは必須）

## Secrets 管理

- 秘密情報は AWS Secrets Manager または Parameter Store（SecureString）で管理する
- Lambda の環境変数に直接シークレットを入れることを禁止する（Secrets Manager 参照に統一）

```python
import boto3
import json

def get_secret(secret_name):
    client = boto3.client('secretsmanager')
    response = client.get_secret_value(SecretId=secret_name)
    return json.loads(response['SecretString'])
```

## S3

- バケットのパブリックアクセスは原則ブロックする（公開が必要な場合は CloudFront 経由）
- バケットポリシーで最小権限を設定する
- 保存データは SSE-S3 または SSE-KMS で暗号化する
- バージョニングを有効化する（重要データのバケット）

## RDS / Aurora

- 本番 DB への直接アクセス（パスワード接続）は禁止する。IAM 認証を使う
- Multi-AZ を有効化する（本番環境は必須）
- 自動バックアップを有効化する（最低7日）
- セキュリティグループは VPC 内からのアクセスのみ許可する

## Lambda

- タイムアウトは処理内容に応じて適切に設定する（デフォルト3秒は短すぎる場合が多い）
- メモリサイズはコスト最適化のため実測値ベースで設定する
- Lambda で重い処理（10分以上・大容量ファイル操作）を実装しようとしたら要再検討（ECS Fargate を使う）
- VPC Lambda は Cold Start が長くなることを考慮する

## ECS Fargate

- 長時間・重い処理は Lambda ではなく ECS Fargate で実装する
- タスク定義のリビジョンは git で管理する（Terraform / CDK を使う）
- ログは CloudWatch Logs に送る

## CloudFront / WAF

- 外部公開するエンドポイントは CloudFront + WAF を必ず前段に置く
- WAF には AWS マネージドルール（AWSManagedRulesCommonRuleSet）を適用する

## CloudWatch

- Lambda・ECS・RDS のメトリクスアラームを設定する
- ログ保持期間を明示的に設定する（デフォルトの「無期限」はコスト増の原因）

## コスト管理

- Budget アラートを設定する（月額予算の 80% で通知）
- 不要なリソースは必ず削除する（開発環境の放置禁止）
- 使用しない Elastic IP は解放する（割り当て済みで未使用は課金対象）

## 禁止事項

- IAM ユーザーのアクセスキーをコードにハードコードすることを禁止する
- S3 バケットをパブリックアクセスで公開することを禁止する（CloudFront 経由に統一）
- RDS を VPC 外に公開することを禁止する
- Lambda で重い処理（10分超・大容量ファイル）を実装することを禁止する（ECS Fargate を使う）
- `AdministratorAccess` ポリシーを Lambda・ECS タスクロールに付与することを禁止する
