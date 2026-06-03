#!/bin/bash
# setup.sh — 主管首次跑這（一次性）
#
# v2 (2026-05-22 dry-run fix P0):
#   自動寫 ~/.claude/settings.json (with backup + jq merge)
#   不再叫主管自己改 JSON

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

MARKER="$REPO_ROOT/.setup-done"

if [ -f "$MARKER" ]; then
  echo "✅ 已 setup 過。如要重設：rm $MARKER && ./scripts/setup.sh"
  exit 0
fi

echo "🚀 Claude Leader Bootcamp 首次 setup（約 30 秒）..."
echo ""

# 1. Make scripts executable
echo "[1/6] 設定執行權限..."
chmod +x "$REPO_ROOT"/scripts/* 2>/dev/null || true
chmod +x "$REPO_ROOT"/.claude/hooks/*.sh 2>/dev/null || true
echo "  ✅"

# 2. Check dependencies
echo "[2/6] 檢查 dependency..."
if ! command -v python3 >/dev/null 2>&1; then
  echo "  ⚠️  python3 沒裝 — session log markdown 轉換會失敗"
  echo "      Mac: brew install python3 / Windows: 到 python.org 裝"
  echo "      (沒裝也能上課，只是少 readable md 版本)"
else
  echo "  ✅ python3: $(python3 --version 2>&1)"
fi
if ! command -v jq >/dev/null 2>&1; then
  echo "  ⚠️  jq 沒裝 — 自動 hook 註冊會 fallback 到 python"
  echo "      Mac: brew install jq"
else
  echo "  ✅ jq: $(jq --version)"
fi

# git 身份（新手主管常沒設 → 之後 ./save commit 會失敗，所以這裡先處理好）
if git config user.email >/dev/null 2>&1 || git config --global user.email >/dev/null 2>&1; then
  _GN=$(git config user.name 2>/dev/null || git config --global user.name 2>/dev/null)
  _GE=$(git config user.email 2>/dev/null || git config --global user.email 2>/dev/null)
  echo "  ✅ git 身份: $_GN <$_GE>"
else
  # 試從 GitHub 帳號自動帶（gh 已登入時）
  GH_LOGIN=$(gh api user --jq '.login' 2>/dev/null || echo "")
  if [ -n "$GH_LOGIN" ]; then
    GH_EMAIL=$(gh api user --jq '.email // empty' 2>/dev/null || echo "")
    [ -z "$GH_EMAIL" ] && GH_EMAIL="${GH_LOGIN}@users.noreply.github.com"
    git config --global user.name "$GH_LOGIN"
    git config --global user.email "$GH_EMAIL"
    echo "  ✅ git 身份自動設好（從 GitHub 帳號）：$GH_LOGIN <$GH_EMAIL>"
  else
    echo "  ⚠️  git 身份還沒設，且抓不到 GitHub 帳號 — 存檔前請設一次（一次就好）："
    echo "        git config --global user.name \"你的名字\""
    echo "        git config --global user.email \"你的email\""
  fi
fi

# 3. Auto-register hooks to ~/.claude/settings.json
echo "[3/6] 自動註冊 Stop hooks 到 ~/.claude/settings.json..."

SETTINGS_DIR="$HOME/.claude"
SETTINGS="$SETTINGS_DIR/settings.json"
HOOK_DIR="$REPO_ROOT/.claude/hooks"

mkdir -p "$SETTINGS_DIR"

# Initialize empty settings if missing
if [ ! -f "$SETTINGS" ]; then
  echo "{}" > "$SETTINGS"
  echo "  📝 建立 ~/.claude/settings.json (原本不存在)"
fi

# Backup
BACKUP="$SETTINGS.backup-$(date +%Y%m%d-%H%M%S)"
cp "$SETTINGS" "$BACKUP"
echo "  💾 Backup: $BACKUP"

# Check if already registered
if grep -q "$HOOK_DIR/stop-capture-log.sh" "$SETTINGS" 2>/dev/null; then
  echo "  ✅ Hook 已註冊，跳過"
else
  # Use jq if available
  if command -v jq >/dev/null 2>&1; then
    NEW_HOOK_GROUP=$(cat <<EOF
{
  "hooks": [
    { "type": "command", "command": "bash $HOOK_DIR/stop-capture-log.sh", "timeout": 5 },
    { "type": "command", "command": "bash $HOOK_DIR/stop-save-reminder.sh", "timeout": 3 }
  ]
}
EOF
)
    # Merge: ensure hooks.Stop exists as array, append new group
    jq --argjson group "$NEW_HOOK_GROUP" '
      .hooks //= {}
      | .hooks.Stop //= []
      | .hooks.Stop += [$group]
    ' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
    echo "  ✅ 已自動寫入 settings.json (Stop hook group 加入)"
  else
    # Python fallback
    if command -v python3 >/dev/null 2>&1; then
      python3 - "$SETTINGS" "$HOOK_DIR" <<'PYEOF'
import json
import sys
from pathlib import Path

settings_path = Path(sys.argv[1])
hook_dir = sys.argv[2]
data = json.loads(settings_path.read_text() or "{}")
data.setdefault("hooks", {}).setdefault("Stop", []).append({
    "hooks": [
        {"type": "command", "command": f"bash {hook_dir}/stop-capture-log.sh", "timeout": 5},
        {"type": "command", "command": f"bash {hook_dir}/stop-save-reminder.sh", "timeout": 3},
    ]
})
settings_path.write_text(json.dumps(data, indent=2, ensure_ascii=False))
print("  ✅ 已自動寫入 settings.json (Python fallback)")
PYEOF
    else
      echo "  ❌ 沒 jq 也沒 python3，無法自動註冊。請手動加 hook（見 docs/for-managers.md）"
    fi
  fi
fi

# 4. Personal CLAUDE.md hint (不直接 copy 模板，讓 /setup-personal 引導)
echo "[4/6] 個人 CLAUDE.md..."
if [ ! -f "CLAUDE.local.md" ]; then
  echo "  📝 你還沒有個人 CLAUDE.md。W1 開課時跟 Claude 說「\\setup-personal」"
  echo "      或現在說「填個人 CLAUDE」，會互動引導 5 段 (3 分鐘)。"
  echo "      不要直接編 template — 互動式比較不會放棄。"
else
  echo "  ✅ 已存在 CLAUDE.local.md"
fi

# 5. Git remote + upstream (拿教材更新用)
echo "[5/6] Git remote..."
if [ ! -d .git ]; then
  echo "  ⚠️  不是 git repo — 對話 log 只會存 local 不會上傳"
  echo "      請聯絡講師 setup remote"
elif ! git remote | grep -q origin; then
  echo "  ⚠️  沒 origin remote — 對話 log 只存 local"
else
  echo "  ✅ origin: $(git remote get-url origin)"

  # Auto-setup upstream remote from .upstream-template (講師建 repo 時放的)
  if [ -f .upstream-template ]; then
    UPSTREAM_REPO=$(cat .upstream-template | tr -d '[:space:]')
    if ! git remote | grep -q upstream; then
      git remote add upstream "https://github.com/$UPSTREAM_REPO.git"
      echo "  ✅ upstream: https://github.com/$UPSTREAM_REPO.git (拿教材更新用)"
    else
      echo "  ✅ upstream: $(git remote get-url upstream)"
    fi
  else
    echo "  ⚠️  沒 .upstream-template 檔 — ./scripts/update 將無法拉教材更新"
    echo "      講師應該已加，沒加請 ping 講師"
  fi
fi

# 6. Test hooks
echo "[6/6] 測試 hook 觸發..."
if [ -x "$REPO_ROOT/.claude/hooks/stop-save-reminder.sh" ]; then
  if bash "$REPO_ROOT/.claude/hooks/stop-save-reminder.sh" >/dev/null 2>&1; then
    echo "  ✅ Hook 可執行"
    rm -f "$REPO_ROOT/.last-save-reminder"
  else
    echo "  ⚠️  Hook 跑但回非 0，看 docs/for-managers.md troubleshooting"
  fi
else
  echo "  ❌ Hook 沒執行權限"
fi

touch "$MARKER"
echo ""
echo "✅ Setup 完成！下次開 Claude Code 在這資料夾，hook 就會 fire。"
echo ""
echo "💡 開始第一堂："
echo "   開 Claude Code → 說「我要開始 W1，幫我填個人 CLAUDE.md」"
echo "   (會跑 /setup-personal 引導你 3 分鐘建好)"
echo ""
echo "三個一鍵動作："
echo "  • ./scripts/save  \"心得\"   — 一鍵存檔上傳"
echo "  • ./scripts/update            — 抓最新教材"
echo "  • ./scripts/new-log \"主題\"  — 開新筆記"
echo ""
echo "Backup 還在：$BACKUP (測試 OK 後可刪)"
