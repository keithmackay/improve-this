#!/usr/bin/env bash
# ABOUTME: verifies the three copies of the improve-this skill body stay identical
# ABOUTME: run after editing skills/improve-this/SKILL.md, improve-this.md, or SKILL.md
set -euo pipefail
cd "$(dirname "$0")/.."

CANONICAL="skills/improve-this/SKILL.md"
COPIES=("improve-this.md" "SKILL.md")

status=0
for copy in "${COPIES[@]}"; do
  if ! diff -q <(grep -v '^<!-- SYNC:' "$CANONICAL") <(grep -v '^<!-- SYNC:' "$copy") > /dev/null; then
    echo "DRIFT: $copy does not match $CANONICAL"
    diff <(grep -v '^<!-- SYNC:' "$CANONICAL") <(grep -v '^<!-- SYNC:' "$copy") || true
    status=1
  fi
done

if [ "$status" -eq 0 ]; then
  echo "OK: $CANONICAL, ${COPIES[*]} are in sync"
fi

exit "$status"
