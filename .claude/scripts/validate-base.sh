#!/usr/bin/env bash
# validate-base.sh — claude-starter-kit ベース整合性検証
# 6項目をチェックし、問題があれば報告する。

set -euo pipefail

PASS=0
FAIL=0
WARNINGS=()

ok()   { echo "  ✅ $1"; PASS=$((PASS+1)); }
fail() { echo "  ❌ $1"; FAIL=$((FAIL+1)); WARNINGS+=("$1"); }

echo ""
echo "🔍 claude-starter-kit ベース整合性検証"
echo "========================================"

# -----------------------------------------------
# チェック1: 必須ファイルの存在確認
# -----------------------------------------------
echo ""
echo "📁 チェック1: 必須ファイルの存在"

REQUIRED_FILES=(
  "VERSION"
  "CHANGELOG.md"
  "CONTRIBUTING.md"
  "CLAUDE.md"
  "README.md"
  ".claude/settings.json"
  ".claude/rules/README.md"
  ".claude/rules/common/coding-standards.md"
  ".claude/rules/stack/README.md"
  ".claude/rules/stack/supabase.md"
  ".claude/rules/stack/vercel.md"
  ".claude/rules/stack/aws.md"
  ".claude/rules/stack/firebase.md"
  ".claude/rules/project/.gitkeep"
  ".claude/scripts/check-plugins.sh"
  ".claude/scripts/count-learnings.sh"
  ".claude/scripts/validate-base.sh"
  ".claude/skills/this-project/.gitkeep"
  ".claude/skills/self-improve/SKILL.md"
  ".claude/skills/update-base/SKILL.md"
  "docs/lessons-learned.md"
  "docs/requirements/README.md"
  "docs/requirements/01-background.md"
  "docs/requirements/02-functional.md"
  "docs/requirements/03-open-questions.md"
  "docs/requirements/04-integrated.md"
  "docs/requirements/05-architecture.md"
  "tpl/common/README.md"
  "tpl/common/step0-preflight.md"
  "tpl/common/step-confirmation.md"
  "tpl/common/step-security-check.md"
  "tpl/common/step-report.md"
  "tpl/common/precautions.md"
  "tpl/common/settings-template.json"
  "tpl/template-new-project.md"
  "tpl/template-renewal.md"
  "tpl/template-feature-add.md"
  "tpl/template-maintenance.md"
)

for f in "${REQUIRED_FILES[@]}"; do
  if [ -e "$f" ]; then
    ok "$f"
  else
    fail "欠損: $f"
  fi
done

# -----------------------------------------------
# チェック2: スクリプトの実行権限
# -----------------------------------------------
echo ""
echo "🔐 チェック2: スクリプトの実行権限"

SCRIPTS=(
  ".claude/scripts/check-plugins.sh"
  ".claude/scripts/count-learnings.sh"
  ".claude/scripts/validate-base.sh"
)

for s in "${SCRIPTS[@]}"; do
  if [ -x "$s" ]; then
    ok "$s は実行可能"
  else
    fail "$s に実行権限がない (chmod +x $s を実行してください)"
  fi
done

# -----------------------------------------------
# チェック3: settings.json の参照整合性
# -----------------------------------------------
echo ""
echo "🔗 チェック3: settings.json の参照整合性"

if [ -f ".claude/settings.json" ] && [ -f "tpl/common/settings-template.json" ]; then
  # SessionStart フックに check-plugins.sh の参照があるか
  if grep -q "check-plugins.sh" .claude/settings.json; then
    ok "settings.json に check-plugins.sh の参照あり"
  else
    fail "settings.json に check-plugins.sh の参照がない"
  fi
  # count-learnings.sh の参照があるか
  if grep -q "count-learnings.sh" .claude/settings.json; then
    ok "settings.json に count-learnings.sh の参照あり"
  else
    fail "settings.json に count-learnings.sh の参照がない"
  fi
else
  fail "settings.json または settings-template.json が存在しない"
fi

# -----------------------------------------------
# チェック4: JSON 構文チェック
# -----------------------------------------------
echo ""
echo "📋 チェック4: JSON 構文チェック"

JSON_FILES=(
  ".claude/settings.json"
  "tpl/common/settings-template.json"
)

for f in "${JSON_FILES[@]}"; do
  if [ -f "$f" ]; then
    if python3 -c "import json,sys; json.load(open('$f'))" 2>/dev/null; then
      ok "$f の JSON 構文は正常"
    elif node -e "JSON.parse(require('fs').readFileSync('$f','utf8'))" 2>/dev/null; then
      ok "$f の JSON 構文は正常"
    else
      fail "$f の JSON 構文エラー"
    fi
  fi
done

# -----------------------------------------------
# チェック5: DRY 違反チェック（common/ の内容が個別テンプレートに重複していないか）
# -----------------------------------------------
echo ""
echo "🔄 チェック5: DRY 違反チェック"

# step-confirmation.md の定型句が各テンプレートに直接書かれていないか
CONFIRMATION_MARKER="WAITING FOR CONFIRMATION"
DRY_FAIL=0

for tpl in tpl/template-new-project.md tpl/template-renewal.md tpl/template-feature-add.md tpl/template-maintenance.md; do
  if [ -f "$tpl" ]; then
    count=$(grep -c "$CONFIRMATION_MARKER" "$tpl" 2>/dev/null || true)
    if [ "$count" -gt 1 ]; then
      fail "$tpl に '$CONFIRMATION_MARKER' が $count 箇所（common/ 参照に統一してください）"
      DRY_FAIL=1
    fi
  fi
done

if [ "$DRY_FAIL" -eq 0 ]; then
  ok "WAITING FOR CONFIRMATION の重複なし"
fi

# -----------------------------------------------
# チェック6: スタックルールの必須セクション
# -----------------------------------------------
echo ""
echo "📚 チェック6: スタックルールの必須セクション"

check_section() {
  local file="$1"
  local section="$2"
  if grep -q "$section" "$file" 2>/dev/null; then
    ok "$file に '$section' セクションあり"
  else
    fail "$file に '$section' セクションがない"
  fi
}

check_section ".claude/rules/stack/supabase.md" "RLS"
check_section ".claude/rules/stack/supabase.md" "禁止"
check_section ".claude/rules/stack/vercel.md" "禁止"
check_section ".claude/rules/stack/aws.md" "禁止"
check_section ".claude/rules/stack/firebase.md" "禁止"

# -----------------------------------------------
# 結果サマリー
# -----------------------------------------------
echo ""
echo "========================================"
echo "📊 結果: ✅ ${PASS}件 パス  /  ❌ ${FAIL}件 失敗"
echo ""

if [ ${#WARNINGS[@]} -gt 0 ]; then
  echo "失敗項目:"
  for w in "${WARNINGS[@]}"; do
    echo "  - $w"
  done
  echo ""
  exit 1
else
  echo "🎉 全チェックをパスしました。"
  echo ""
  exit 0
fi
