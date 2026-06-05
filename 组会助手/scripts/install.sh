#!/bin/bash
# 组会助手 Multi-Skill 一键安装脚本
# 用法: bash install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="$PROJECT_DIR/skills"

echo "=== 研究生组会汇报助手 — Skill 安装 ==="
echo ""

# Hermes skills 目标目录
HERMES_SKILLS="$HOME/.hermes/skills/research"
mkdir -p "$HERMES_SKILLS"

# 要安装的 skill 列表（按依赖顺序）
SKILLS=(
  "seminar-literature"
  "seminar-experiment"
  "seminar-questions"
  "seminar-outline"
  "seminar-ppt"
  "grad-seminar-report"
)

installed=0
skipped=0

for skill in "${SKILLS[@]}"; do
  src="$SKILLS_DIR/$skill"
  dest="$HERMES_SKILLS/$skill"

  if [ ! -d "$src" ]; then
    echo "⚠️  源目录不存在: $src (跳过)"
    ((skipped++))
    continue
  fi

  if [ -d "$dest" ]; then
    echo "🔄 更新: $skill"
    rm -rf "$dest"
  else
    echo "📦 安装: $skill"
  fi

  cp -r "$src" "$dest"
  ((installed++))
done

echo ""
echo "=== 安装完成 ==="
echo "✅ 安装/更新: $installed"
echo "⏭️  跳过: $skipped"
echo ""
echo "验证: hermes skills list | grep seminar"
