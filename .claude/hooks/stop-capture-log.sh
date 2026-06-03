#!/bin/bash
# stop-capture-log.sh — Stop event hook
# Triggered: 每次 Claude task 結束（response 結束）
# Action: 找最新 session jsonl → copy 進 repo/session-logs/raw/ → convert markdown

set -uo pipefail

# Find repo root (this hook 在 .claude/hooks/ 下，repo root 是 ../..)
REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# Claude Code 把 session log 存在 ~/.claude/projects/<path-hash>/<session-id>.jsonl
# path-hash 是 repo path 把 / 換成 - 前面加 -
PROJECT_HASH=$(echo "$REPO_ROOT" | sed 's|/|-|g')
SESSION_DIR="$HOME/.claude/projects/$PROJECT_HASH"

if [ ! -d "$SESSION_DIR" ]; then
  # 第一次跑或還沒對話，靜默退出
  exit 0
fi

# 找今天最新 jsonl
LATEST_JSONL=$(ls -t "$SESSION_DIR"/*.jsonl 2>/dev/null | head -1)
if [ -z "$LATEST_JSONL" ]; then
  exit 0
fi

# 確保 raw/ 存在
mkdir -p "$REPO_ROOT/session-logs/raw"

# Copy jsonl (idempotent — file 同名會覆蓋)
SESSION_ID=$(basename "$LATEST_JSONL" .jsonl)
RAW_OUT="$REPO_ROOT/session-logs/raw/${SESSION_ID}.jsonl"
cp "$LATEST_JSONL" "$RAW_OUT"

# Convert to readable markdown
TODAY=$(date +%Y-%m-%d)
MD_OUT="$REPO_ROOT/session-logs/${TODAY}-${SESSION_ID:0:8}.md"

PYTHON_BIN=$(command -v python3 || command -v python || echo "")
if [ -n "$PYTHON_BIN" ] && [ -x "$REPO_ROOT/scripts/jsonl-to-markdown.py" ]; then
  "$PYTHON_BIN" "$REPO_ROOT/scripts/jsonl-to-markdown.py" "$RAW_OUT" "$MD_OUT" >/dev/null 2>&1 || true
fi

# 靜默退出（不打擾正常 output）
exit 0
