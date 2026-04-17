# examples/

ベースの動作確認用サンプル集。
4テンプレートそれぞれに対して、**入力例(議事録)** と **期待される出力** を用意する。

## ファイル構成

```
examples/
├── README.md                          ← 本ファイル
├── sample-minutes/                    ← 入力例(議事録サンプル)
│   ├── new-project-sample.md
│   ├── renewal-sample.md
│   ├── feature-add-sample.md
│   └── maintenance-sample.md
└── expected-outputs/                  ← 期待される出力
    ├── new-project/
    │   ├── CLAUDE.md
    │   ├── README_expected.md
    │   ├── docs/
    │   │   ├── requirements/
    │   │   │   ├── 01-background.md
    │   │   │   ├── 02-functional.md
    │   │   │   ├── 03-open-questions.md
    │   │   │   ├── 04-integrated.md
    │   │   │   └── 05-architecture.md
    │   │   ├── database.md
    │   │   └── ...
    │   └── .claude/
    │       └── skills/
    │           └── this-project/
    │               └── SKILL.md
    ├── renewal/
    ├── feature-add/
    └── maintenance/
```

## 用途

### 1. ベース動作確認(スモークテスト)

ベースを更新したら、各サンプル議事録を対応テンプレートに入力し、
期待される出力と概ね一致するかを確認する。

### 2. Claude Code への手本

Claude Code が「どのような出力が期待されているか」を学ぶ参考資料として機能。

### 3. 新規メンバーへのオンボーディング

チーム新規メンバーが「テンプレートを使うと何が生成されるか」を理解する教材。

## 更新方針

- ベースのテンプレート変更時は、対応する expected-outputs も更新する
- サンプル議事録は架空のシンプルな案件を想定(現実の案件を流用しない)
- 期待出力はベースの変更に追従する

## 注意

- 期待出力は**理想的な出力例**であり、Claude Codeが100%同じ出力をするとは限らない
- 大きな乖離がある場合はベースの指示を見直す
