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
  attach   <issue_id> <file> [notes]  ファイル添付（スクショ等。MCP不可の代替）
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
  $(basename "$0") attach 42 ./shot.png 'UI確認: 一覧表示'
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
    attach)
        # MCP redmine_api_request は JSON のみ。バイナリはここ（または curl）で送る。
        [ -n "${1:-}" ] && [ -f "${2:-}" ] || {
            echo "Error: issue_id and existing file required" >&2
            echo "Usage: $(basename "$0") attach <issue_id> <file> [notes]" >&2
            exit 1
        }
        require_key
        issue_id="$1"
        file_path="$2"
        notes="${3:-添付: $(basename "$file_path")}"
        filename="$(basename "$file_path")"
        # MIME 推定（file コマンドが無い環境向けに拡張子フォールバック）
        content_type="$(file -b --mime-type "$file_path" 2>/dev/null || true)"
        case "${content_type:-}" in
            image/*|application/pdf|text/*|application/json) ;;
            *)
                case "${filename##*.}" in
                    png) content_type="image/png" ;;
                    jpg|jpeg) content_type="image/jpeg" ;;
                    webp) content_type="image/webp" ;;
                    gif) content_type="image/gif" ;;
                    pdf) content_type="application/pdf" ;;
                    *) content_type="application/octet-stream" ;;
                esac
                ;;
        esac
        upload_tmp="$(mktemp)"
        upload_code="$(curl -sS -o "$upload_tmp" -w "%{http_code}" \
            -X POST \
            -H "X-Redmine-API-Key: ${REDMINE_KEY}" \
            -H "Content-Type: application/octet-stream" \
            --data-binary @"${file_path}" \
            "${REDMINE_URL}/uploads.json?filename=$(python3 -c 'import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))' "$filename")")"
        if [ "$upload_code" != "201" ]; then
            echo "Error: upload HTTP ${upload_code}" >&2
            cat "$upload_tmp" >&2
            rm -f "$upload_tmp"
            exit 1
        fi
        token="$(python3 -c 'import json,sys; print(json.load(sys.stdin)["upload"]["token"])' <"$upload_tmp")"
        rm -f "$upload_tmp"
        [ -n "$token" ] || { echo "Error: empty upload token" >&2; exit 1; }
        payload="$(python3 -c '
import json, sys
issue_id, token, filename, content_type, notes = sys.argv[1:6]
print(json.dumps({
  "issue": {
    "notes": notes,
    "uploads": [{
      "token": token,
      "filename": filename,
      "content_type": content_type
    }]
  }
}))
' "$issue_id" "$token" "$filename" "$content_type" "$notes")"
        redmine_api PUT "/issues/${issue_id}.json" "$payload"
        echo "Attached ${filename} to #${issue_id}"
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
