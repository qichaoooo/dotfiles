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

printf '| 包 | 源文件（仓库内） | 链接到（$HOME） |\n'
printf '|---|---|---|\n'

found=0
for pkg_dir in */; do
    pkg="${pkg_dir%/}"
    is_excluded "$pkg" && continue

    # 跳过没有文件的目录
    [ -n "$(find "$pkg" -type f -print -quit)" ] || continue

    while IFS= read -r file; do
        rel="${file#"$pkg"/}"          # 包内相对路径，如 .bashrc / .vim/coc-settings.json
        printf '| %s | `%s` | `~/%s` |\n' "$pkg" "$file" "$rel"
        found=1
    done < <(find "$pkg" -type f ! -name '*.md' | sort)
done

if [ "$found" -eq 0 ]; then
    echo "(no packages found)" >&2
    exit 1
fi