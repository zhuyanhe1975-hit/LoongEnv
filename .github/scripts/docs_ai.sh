#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$repo_root"

generated_at="$(date -u +"%Y-%m-%d %H:%M UTC")"
mkdir -p docs

{
  echo "# 开发日志"
  echo
  echo "- 由 \`DOCS_AI\` 自动生成"
  echo "- 更新时间：${generated_at}"
  echo
  echo "## 最近仓库活动"
  echo
  git log --date=short --pretty=format:'- %ad | %h | %s' -n 20
  echo
} > docs/dev-log.md
