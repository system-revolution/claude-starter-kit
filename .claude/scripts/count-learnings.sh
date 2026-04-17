#!/usr/bin/env bash
# count-learnings.sh — CLAUDE.md の学習ログ件数をカウント
# Stop フックから呼ばれる。10件以上なら整理を促す。

CLAUDE_MD="${1:-CLAUDE.md}"

if [ ! -f "$CLAUDE_MD" ]; then
  exit 0
fi

# 学習ログセクション内の "## 学習:" エントリを数える
# "## 学習ログ" セクション開始後、次の "## " ヘッディングが来たら終了
COUNT=$(awk '
  /^## 学習ログ/ { in_section=1; next }
  in_section && /^## [^学]/ { exit }
  in_section && /^## 学習:/ { count++ }
  END { print count+0 }
' "$CLAUDE_MD")

if [ "$COUNT" -ge 10 ]; then
  echo "📚 学習ログが${COUNT}件に達しました。docs/lessons-learned.md へ整理して CLAUDE.md の学習ログをリセットしてください。"
fi

exit 0
