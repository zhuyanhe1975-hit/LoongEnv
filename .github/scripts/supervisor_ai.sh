#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$repo_root"

: "${OWNER:?OWNER is required}"
: "${REPOS:?REPOS is required}"
generated_at="$(date -u +"%Y-%m-%d %H:%M UTC")"
api_root="https://api.github.com/repos"
mkdir -p docs

{
  echo "# 每日进展布告栏"
  echo
  echo "- 由 \`SUPERVISOR_AI\` 自动生成"
  echo "- 更新时间：${generated_at}"
  echo
  echo "## 今日进展"
  echo

  for entry in ${REPOS}; do
    repo="${entry%%|*}"
    label="${entry#*|}"
    if [[ "${label}" == "${entry}" ]]; then
      label="${repo}"
    fi

    curl_args=(
      -fsSL
      -H "Accept: application/vnd.github+json"
    )

    if [[ -n "${GITHUB_TOKEN:-}" ]]; then
      curl_args+=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
    fi

    response="$(curl "${curl_args[@]}" "${api_root}/${OWNER}/${repo}/commits?per_page=1" 2>/dev/null || true)"

    if [[ -z "${response}" ]] || [[ "$(printf '%s' "${response}" | jq -r 'type')" != "array" ]]; then
      echo "- ${label}：仓库暂不可用。"
      continue
    fi

    count="$(printf '%s' "${response}" | jq 'length')"
    if [[ "${count}" -eq 0 ]]; then
      echo "- ${label}：尚无提交记录。"
      continue
    fi

    latest_message="$(printf '%s' "${response}" | jq -r '.[0].commit.message' | head -n 1)"
    latest_date="$(printf '%s' "${response}" | jq -r '.[0].commit.author.date' | cut -d'T' -f1)"
    latest_sha="$(printf '%s' "${response}" | jq -r '.[0].sha[0:7]')"

    echo "- ${label}：最新提交 ${latest_sha}，日期 ${latest_date}，说明：${latest_message}"
  done

  echo
  echo "## 说明"
  echo
  echo "- 本布告栏基于各成员仓当前可见的最新提交自动生成。"
} > docs/daily-status-board.md
