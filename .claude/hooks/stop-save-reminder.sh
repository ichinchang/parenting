#!/bin/bash
# stop-save-reminder.sh — Stop event hook
# Triggered: 每次 Claude task 結束
# Action: 提醒主管存檔，但帶 throttle (15 min 內只提醒 1 次)
#         + 智能加強：偵測 user 訊息含「完成 / 結束 / 下課 / 累了 / 暫停」→ 立刻提醒

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
MARKER="$REPO_ROOT/.last-save-reminder"
THROTTLE_SEC=900  # 15 min

# 讀 hook context (Claude Code 透過 stdin / env 傳 user prompt)
USER_PROMPT="${CLAUDE_LAST_USER_PROMPT:-}"
if [ -z "$USER_PROMPT" ] && [ -t 0 ]; then
  # 沒 env var 且非 stdin pipe 模式，沒 prompt 可讀
  USER_PROMPT=""
fi

# 智能加強：偵測「完成」keyword
URGENT=0
if echo "$USER_PROMPT" | grep -qE "完成|結束|下課|累了|暫停|休息|先這樣|done|finish|stop"; then
  URGENT=1
fi

# Throttle check (urgent skip throttle)
if [ "$URGENT" = "0" ]; then
  if [ -f "$MARKER" ]; then
    LAST=$(cat "$MARKER" 2>/dev/null || echo 0)
    NOW=$(date +%s)
    AGE=$(( NOW - LAST ))
    if [ "$AGE" -lt "$THROTTLE_SEC" ]; then
      # 距上次提醒不到 15 min，靜默退出
      exit 0
    fi
  fi
fi

# 印提醒
echo ""
if [ "$URGENT" = "1" ]; then
  echo "💾 偵測到「結束」訊號 — 該存檔了！"
  echo "   跑 \`/save 心得一句話\` 或 \`./scripts/save \"心得\"\`"
else
  echo "💾 該存檔了嗎？跑 \`/save\` 或 \`./scripts/save \"今天學了什麼\"\`"
fi
echo ""

# 更新 marker
date +%s > "$MARKER"

exit 0
