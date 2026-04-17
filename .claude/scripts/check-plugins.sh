#!/usr/bin/env bash
# check-plugins.sh — 必須プラグインの存在チェック
# SessionStart フックから呼ばれる。警告を出すだけで終了コードは常に 0。

PLUGINS_DIRS=(
  "$HOME/.claude/plugins"
  "$HOME/.config/claude/plugins"
)

REQUIRED_PLUGINS=(
  "superpowers"
  "everything-claude-code"
  "taskmaster"
  "context7"
  "playwright-skill"
)

check_plugin() {
  local name="$1"
  for dir in "${PLUGINS_DIRS[@]}"; do
    if [ -d "$dir/$name" ] || [ -f "$dir/$name" ]; then
      return 0
    fi
  done
  return 1
}

missing=()
for plugin in "${REQUIRED_PLUGINS[@]}"; do
  if ! check_plugin "$plugin"; then
    missing+=("$plugin")
  fi
done

if [ ${#missing[@]} -eq 0 ]; then
  # 全プラグインOK — 静かに終了
  exit 0
fi

echo ""
echo "⚠️  未インストールのプラグインがあります:"
for p in "${missing[@]}"; do
  echo "   - $p"
done
echo ""
echo "   一部機能が動作しない場合があります。"
echo "   各プラグインのドキュメントを参照してインストールしてください。"
echo ""

exit 0
