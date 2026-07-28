#!/usr/bin/env bash
# Redmine ヘルパー CLI（MCP 非接続時のフォールバック）
set -euo pipefail

REDMINE_URL="${REDMINE_URL:-http://127.0.0.1:3000}"
REDMINE_KEY="${REDMINE_API_KEY:-}"

usage() {
    cat <<EOF
Usage: $(basename "$0") <command> [args] [options]

Commands:
  get      <issue_id>              チケット取得
  list     [project_id]            チケット一覧
  create   <json_file>             チケット作成（JSONファイル）
  update   <issue_id> <json_file>  チケット更新（JSONファイル）
  note     <issue_id> <text|->     コメント追加（文字列 or stdin）
  status                           ステータス一覧
  trackers                         トラッカー一覧
  users                            ユーザー一覧
  help                             このヘルプ

Environment:
  REDMINE_URL       default: http://127.0.0.1:3000
  REDMINE_API_KEY   required

Examples:
  $(basename "$0") get 42
  $(basename "$0") list {your-redmine-project}
  $(basename "$0") create ./new_issue.json
  $(basename "$0") update 42 ./patch.json
  $(basename "$0") note 42 '進捗中: API確認'
  echo '完了メモ' | $(basename "$0") note 42 -
EOF
}

require_key() {
    if [ -z "${REDMINE_KEY}" ]; then
        echo "Error: REDMINE_API_KEY is not set" >&2
        exit 1
    fi
}

# stdout: body, stderr: http code via last line on fd3 pattern — print body, return non-zero on HTTP >=400
redmine_api() {
    local method="$1"
    local path="$2"
    local data="${3:-}"
    local tmp http_code

    require_key
    tmp="$(mktemp)"
    if [ -n "$data" ]; then
        http_code="$(curl -sS -o "$tmp" -w "%{http_code}" \
            -X "$method" \
            -H "X-Redmine-API-Key: ${REDMINE_KEY}" \
            -H "Content-Type: application/json" \
            -d "$data" \
            "${REDMINE_URL}${path}")"
    else
        http_code="$(curl -sS -o "$tmp" -w "%{http_code}" \
            -X "$method" \
            -H "X-Redmine-API-Key: ${REDMINE_KEY}" \
            -H "Content-Type: application/json" \
            "${REDMINE_URL}${path}")"
    fi

    cat "$tmp"
    echo
    rm -f "$tmp"

    case "$http_code" in
        2??) return 0 ;;
        *)
            echo "Error: HTTP ${http_code} for ${method} ${path}" >&2
            return 1
            ;;
    esac
}

cmd="${1:-help}"
shift || true

case "$cmd" in
    get)
        [ -n "${1:-}" ] || { echo "Error: issue_id required" >&2; exit 1; }
        redmine_api GET "/issues/${1}.json?include=journals,attachments"
        ;;
    list)
        if [ -n "${1:-}" ]; then
            redmine_api GET "/issues.json?project_id=${1}&limit=100"
        else
            redmine_api GET "/issues.json?limit=100"
        fi
        ;;
    create)
        [ -f "${1:-}" ] || { echo "Error: JSON file required" >&2; exit 1; }
        redmine_api POST "/issues.json" "$(cat "$1")"
        ;;
    update)
        [ -n "${1:-}" ] && [ -f "${2:-}" ] || { echo "Error: issue_id and JSON file required" >&2; exit 1; }
        redmine_api PUT "/issues/${1}.json" "$(cat "$2")"
        ;;
    note)
        [ -n "${1:-}" ] || { echo "Error: issue_id required" >&2; exit 1; }
        issue_id="$1"
        if [ "${2:-}" = "-" ] || [ -z "${2:-}" ]; then
            notes="$(cat)"
        else
            notes="$2"
        fi
        # Redmine: notes are sent via issue update, not /journals.json
        payload="$(python3 -c 'import json,sys; print(json.dumps({"issue":{"notes":sys.stdin.read()}}))' <<<"$notes")"
        redmine_api PUT "/issues/${issue_id}.json" "$payload"
        ;;
    status)
        redmine_api GET "/issue_statuses.json"
        ;;
    trackers)
        redmine_api GET "/trackers.json"
        ;;
    users)
        redmine_api GET "/users.json"
        ;;
    help|--help|-h)
        usage
        ;;
    *)
        echo "Unknown command: $cmd" >&2
        usage
        exit 1
        ;;
esac
