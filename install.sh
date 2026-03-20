#!/usr/bin/env bash
# 道法符籙 ── Daoist Talismans Installer
# Installs the Claude Code agent prompt generator skill.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="${HOME}/.claude/skills/daoist-agent"
LANG="zh"

usage() {
  cat <<'EOF'
道法符籙 ── Installer

Usage: bash install.sh [OPTIONS]

Options:
  --lang <zh|en>    Choose language (default: zh)
                      zh = 中文
                      en = English
  --help            Show this help message

Examples:
  bash install.sh            # 中文（預設）
  bash install.sh --lang en  # English
EOF
  exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --lang)
      LANG="$2"
      shift 2
      ;;
    --help|-h)
      usage
      ;;
    *)
      echo "Unknown option: $1"
      usage
      ;;
  esac
done

# Validate language
if [[ "$LANG" != "zh" && "$LANG" != "en" ]]; then
  echo "Error: unsupported language '$LANG'. Use 'zh' or 'en'."
  exit 1
fi

SRC_DIR="${SCRIPT_DIR}/${LANG}"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "Error: language directory '$SRC_DIR' not found."
  exit 1
fi

# Language labels
if [[ "$LANG" == "zh" ]]; then
  LABEL="中文"
  MSG_INSTALLING="正在安裝道法符籙（中文版）..."
  MSG_CREATED="建立目錄"
  MSG_COPIED="已複製"
  MSG_DONE="安裝完成！"
  MSG_USAGE="使用方式：在 Claude Code 中直接描述你的 agent 需求。"
else
  LABEL="English"
  MSG_INSTALLING="Installing Daoist Talismans (English)..."
  MSG_CREATED="Created directory"
  MSG_COPIED="Copied"
  MSG_DONE="Installation complete!"
  MSG_USAGE="Usage: describe your agent requirements directly in Claude Code."
fi

echo ""
echo "  ═══════════════════════════════════"
echo "     道法符籙 ── Daoist Talismans"
echo "     Language: ${LABEL}"
echo "  ═══════════════════════════════════"
echo ""
echo "$MSG_INSTALLING"
echo ""

# Create skill directory
mkdir -p "$SKILL_DIR"
echo "  $MSG_CREATED: $SKILL_DIR"

# Copy skill files
for f in "$SRC_DIR"/*.md; do
  filename="$(basename "$f")"
  cp "$f" "$SKILL_DIR/$filename"
  echo "  $MSG_COPIED: $filename"
done

echo ""
echo "  ✓ $MSG_DONE"
echo "  $MSG_USAGE"
echo ""
