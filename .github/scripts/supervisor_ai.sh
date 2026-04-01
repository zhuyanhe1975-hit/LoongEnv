#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$repo_root"

: "${OWNER:?OWNER is required}"
: "${REPOS:?REPOS is required}"
generated_at="$(date -u +"%Y-%m-%d %H:%M UTC")"
api_root="https://api.github.com/repos"
mkdir -p docs

curl_api() {
  local url="$1"
  local curl_args=(
    -fsSL
    -H "Accept: application/vnd.github+json"
  )

  if [[ -n "${GITHUB_TOKEN:-}" ]]; then
    curl_args+=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
  fi

  curl "${curl_args[@]}" "$url" 2>/dev/null || true
}

write_period_report() {
  local period_key="$1"
  local period_title="$2"
  local since_iso="$3"
  local output_file="$4"

  {
    echo "# ${period_title}"
    echo
    echo "- 由 \`SUPERVISOR_AI\` 自动生成"
    echo "- 更新时间：${generated_at}"
    echo "- 统计起点：${since_iso}"
    echo
    echo "## 工作量统计"
    echo

    for entry in ${REPOS}; do
      repo="${entry%%|*}"
      label="${entry#*|}"
      if [[ "${label}" == "${entry}" ]]; then
        label="${repo}"
      fi

      commits_json="$(curl_api "${api_root}/${OWNER}/${repo}/commits?since=${since_iso}&per_page=100")"
      if [[ -z "${commits_json}" ]] || [[ "$(printf '%s' "${commits_json}" | jq -r 'type')" != "array" ]]; then
        echo "### ${label}"
        echo
        echo "- 仓库状态：暂不可统计。"
        echo
        continue
      fi

      commit_count="$(printf '%s' "${commits_json}" | jq 'length')"
      if [[ "${commit_count}" -eq 0 ]]; then
        echo "### ${label}"
        echo
        echo "- 提交次数：0"
        echo "- 代码增量：0 行"
        echo "- 代码删除：0 行"
        echo "- 文档文件变更：0 个"
        echo
        continue
      fi

      total_additions=0
      total_deletions=0
      total_changed_files=0
      doc_file_changes=0

      while IFS= read -r sha; do
        [[ -z "${sha}" ]] && continue
        commit_detail="$(curl_api "${api_root}/${OWNER}/${repo}/commits/${sha}")"
        [[ -z "${commit_detail}" ]] && continue

        additions="$(printf '%s' "${commit_detail}" | jq '.stats.additions // 0')"
        deletions="$(printf '%s' "${commit_detail}" | jq '.stats.deletions // 0')"
        changed_files="$(printf '%s' "${commit_detail}" | jq '.files | length // 0')"
        doc_changes="$(printf '%s' "${commit_detail}" | jq '[.files[]? | select(.filename | test("(^docs/|README\\.md$|\\.md$|\\.rst$|\\.txt$)"))] | length')"

        total_additions=$((total_additions + additions))
        total_deletions=$((total_deletions + deletions))
        total_changed_files=$((total_changed_files + changed_files))
        doc_file_changes=$((doc_file_changes + doc_changes))
      done < <(printf '%s' "${commits_json}" | jq -r '.[].sha')

      echo "### ${label}"
      echo
      echo "- 提交次数：${commit_count}"
      echo "- 变更文件数：${total_changed_files}"
      echo "- 代码新增：${total_additions} 行"
      echo "- 代码删除：${total_deletions} 行"
      echo "- 文档文件变更：${doc_file_changes} 个"
      echo
    done

    echo "## 说明"
    echo
    echo "- 统计基于 GitHub 当前可见提交记录生成。"
    echo "- 文档文件按 README、docs 目录以及常见文本扩展名粗略统计。"
  } > "${output_file}"
}

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

    response="$(curl_api "${api_root}/${OWNER}/${repo}/commits?per_page=1")"

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

weekly_since="$(date -u -d '7 days ago' +"%Y-%m-%dT%H:%M:%SZ")"
monthly_since="$(date -u -d '30 days ago' +"%Y-%m-%dT%H:%M:%SZ")"

write_period_report "weekly" "每周工作量统计" "${weekly_since}" "docs/weekly-work-summary.md"
write_period_report "monthly" "每月工作量统计" "${monthly_since}" "docs/monthly-work-summary.md"
