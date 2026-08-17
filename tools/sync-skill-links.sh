#!/usr/bin/env bash
# ticket-* / git-* / code-refactor をリポジトリ正本への symlink にする。
# OpenCode: ~/.agents/skills
# Hermes:   ~/.hermes/skills/software-development
# Cursor 個人: ~/.cursor/skills（既にリンクなら維持）
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CANONICAL="$ROOT/skills"
BACKUP_ROOT="${TICKET_DRIVEN_SKILL_BACKUP:-$HOME/.ticket-driven-skill-copies.bak/$(date +%Y%m%d)}"

resolve() {
    python3 -c "import os, sys; print(os.path.realpath(sys.argv[1]))" "$1"
}

skill_names() {
    for d in "$CANONICAL"/*/; do
        [ -f "${d}SKILL.md" ] || continue
        basename "$d"
    done
}

link_one() {
    local dest_root="$1"
    local name="$2"
    local src="$CANONICAL/$name"
    local dest="$dest_root/$name"

    mkdir -p "$dest_root"

    if [ -L "$dest" ]; then
        if [ "$(resolve "$dest")" = "$(resolve "$src")" ]; then
            printf 'keep  %s\n' "$dest"
            return 0
        fi
        rm "$dest"
        ln -s "$src" "$dest"
        printf 'relink %s -> %s\n' "$dest" "$src"
        return 0
    fi

    if [ -e "$dest" ]; then
        local bak="$BACKUP_ROOT/$(basename "$dest_root")"
        mkdir -p "$bak"
        mv "$dest" "$bak/$name"
        printf 'backup %s -> %s/%s\n' "$dest" "$bak" "$name"
    fi

    ln -s "$src" "$dest"
    printf 'link  %s -> %s\n' "$dest" "$src"
}

DESTS=(
    "$HOME/.agents/skills"
    "$HOME/.hermes/skills/software-development"
    "$HOME/.cursor/skills"
)

echo "canonical: $CANONICAL"
for dest_root in "${DESTS[@]}"; do
    echo "== $dest_root"
    mkdir -p "$dest_root"
    while IFS= read -r name; do
        link_one "$dest_root" "$name"
    done < <(skill_names)
done
