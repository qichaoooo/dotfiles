#!/usr/bin/env bash
# ~/dotfiles/scripts/gen-filelist.sh
# 生成 README 用的「配置文件列表」Markdown 表格
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$DOTFILES"

# 不是 Stow 包的目录（脚本自身、文档、测试等）
EXCLUDE_DIRS=("scripts" "docs" "tests")

is_excluded() {
    local name="$1" e
    for e in "${EXCLUDE_DIRS[@]}"; do
        [ "$name" = "$e" ] && return 0
    done
    return 1
}

printf '| 包 | 源文件（仓库内） | 链接到（实际路径） |\n'
printf '|---|---|---|\n'

found=0
for pkg_dir in */; do
    pkg="${pkg_dir%/}"
    is_excluded "$pkg" && continue

    # 跳过没有文件的目录
    [ -n "$(find "$pkg" -type f -print -quit)" ] || continue

    while IFS= read -r file; do
        rel="${file#"$pkg"/}"          # 包内相对路径，如 .bashrc / etc/ssh/sshd_config.d/99-custom.conf
        
        # 核心修改：如果路径以 etc/ 或 usr/ 开头，说明是系统级配置，链接到根目录 /
        if [[ "$rel" == etc/* ]] || [[ "$rel" == usr/* ]]; then
            dst="/$rel"
        else
            dst="~/$rel"
        fi

        printf '| %s | `%s` | `%s` |\n' "$pkg" "$file" "$dst"
        found=1
    done < <(find "$pkg" -type f ! -name '*.md' | sort)
done

if [ "$found" -eq 0 ]; then
    echo "(no packages found)" >&2
    exit 1
fi