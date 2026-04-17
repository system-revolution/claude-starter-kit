# docs/requirements/ — 要件定義 5 フェーズ

## フロー

```
議事録 (docs/meetings/)
    ↓
01-background.md    ← 背景・目的・スコープ・制約
    ↓
02-functional.md    ← 機能要件・非機能要件（優先度付き）
    ↓
03-open-questions.md ← 未確定事項（Q-xx 形式）
    ↓
04-integrated.md    ← 統合・確定版（アーキテクチャへの引き継ぎ）
    ↓
05-architecture.md  ← 技術選定・ADR・アーキテクチャビュー
```

## トレーサビリティ原則

### source 記法

各要件・設計判断に出典を記録する:

```
- **source**: docs/meetings/YYYY-MM-DD.md L12-15
```

### confidence レベル

| レベル | 定義 | 例 |
|-------|------|-----|
| `confirmed` | 顧客合意済み | 議事録に明記・顧客署名あり |
| `tentative` | 顧客に確認中・仮置き | 「たぶんこうだろう」 |
| `inferred` | 議事録から推論 | 明示されていないが文脈から判断 |
| `se-proposed` | SE が提案・未合意 | SE 側の技術的提案 |
| `assumed` | 根拠なし・要確認 | 決まっていないが進める |

**原則**: `tentative` 以下は 03-open-questions.md に Q-xx として記録し、  
確認・合意が取れたら `confirmed` に昇格する。  
`confirmed` への昇格は**顧客合意が必要**。SE 判断だけで昇格してはならない。

## 各ファイルの役割

| ファイル | 主な記載内容 | 生成タイミング |
|---------|-----------|-------------|
| 01-background.md | 背景・目的・成功基準・スコープ・ステークホルダー・制約 | テンプレート Step 2 |
| 02-functional.md | 機能一覧（優先度付き）・非機能要件 | テンプレート Step 2 |
| 03-open-questions.md | Q-xx 未確定事項・ブロッキング度 | テンプレート Step 2 以降随時 |
| 04-integrated.md | 確定要件統合・矛盾解決・アーキテクチャへの前提 | テンプレート Step 2 最終 |
| 05-architecture.md | 技術選定・ADR・4ビュー・コスト見積もり | テンプレート Step 3 |

## 注意事項

- 各ファイルは Claude Code がテンプレート処理時に生成する
- 手動で編集する場合も source / confidence の記法を守ること
- Q-xx が解決したら 03-open-questions.md の Resolved 表に移動し、影響ファイルを全て更新すること
