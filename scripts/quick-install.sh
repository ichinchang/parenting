#!/bin/bash
# quick-install.sh — Leader Bootcamp CLI 一鍵安裝
#
# Usage:
#   curl -fsSL <GIST_URL> | bash -s -- ORG/REPO_NAME
#
# 或下載:
#   bash quick-install.sh ORG/REPO_NAME
#
# 例:
#   bash quick-install.sh commonwealth-parenting/yourname-leader-journey
#
# 做的事:
#   1. Check / install prereqs (brew on Mac / gh / python3)
#   2. gh auth login (瀏覽器登入)
#   3. clone 個人 repo
#   4. 跑 setup.sh
#   5. 印開啟 Claude Code 指令

set -uo pipefail

REPO="${1:-}"
if [ -z "$REPO" ]; then
  echo "❌ Usage: bash quick-install.sh ORG/REPO_NAME"
  echo "   例: bash quick-install.sh commonwealth-parenting/yourname-leader-journey"
  exit 1
fi

echo "🚀 Leader Bootcamp 一鍵安裝（< 5 分鐘）"
echo "   Repo: $REPO"
echo ""

# Detect OS
OS="$(uname -s)"
case "$OS" in
  Darwin) PLATFORM="mac" ;;
  Linux) PLATFORM="linux" ;;
  *) echo "⚠️  Windows 請走桌面版 + /setup-bootcamp，不要跑這 script"; exit 1 ;;
esac

# Step 1: Install prereqs
echo "[1/5] Check prereqs ($PLATFORM)..."

install_if_missing() {
  local cmd="$1"
  local install_cmd="$2"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "  📦 $cmd 沒裝，安裝中..."
    eval "$install_cmd"
  else
    echo "  ✅ $cmd: $(command -v $cmd)"
  fi
}

if [ "$PLATFORM" = "mac" ]; then
  # Mac: brew chain
  if ! command -v brew >/dev/null 2>&1; then
    echo "  📦 Homebrew 沒裝。請手動裝："
    echo "      /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    echo "  裝完再跑此 script。"
    exit 1
  fi
  install_if_missing gh "brew install gh"
  install_if_missing python3 "brew install python3"
  install_if_missing jq "brew install jq"
elif [ "$PLATFORM" = "linux" ]; then
  # Linux: apt assumed (Ubuntu/Debian) — Young 不該遇到
  install_if_missing gh "sudo apt install -y gh"
  install_if_missing python3 "sudo apt install -y python3"
  install_if_missing jq "sudo apt install -y jq"
fi

echo ""

# Step 2: gh auth
echo "[2/5] GitHub 登入..."
if gh auth status >/dev/null 2>&1; then
  echo "  ✅ 已登入 ($(gh api /user --jq .login))"
else
  echo "  🌐 開啟瀏覽器登入..."
  gh auth login --web --git-protocol https
fi

echo ""

# Step 3: Clone repo
echo "[3/5] Clone 個人 repo..."
REPO_NAME=$(basename "$REPO")
TARGET_DIR="$HOME/leader-bootcamp/$REPO_NAME"

if [ -d "$TARGET_DIR" ]; then
  echo "  ⚠️  $TARGET_DIR 已存在 — 跳過 clone"
else
  mkdir -p "$HOME/leader-bootcamp"
  if gh repo clone "$REPO" "$TARGET_DIR"; then
    echo "  ✅ Clone 到 $TARGET_DIR"
  else
    echo "  ❌ Clone 失敗。確認 repo URL + 你有 access"
    exit 1
  fi
fi

cd "$TARGET_DIR"

# Step 4: setup.sh
echo ""
echo "[4/5] 跑 setup.sh..."
if [ -x scripts/setup.sh ]; then
  ./scripts/setup.sh 2>&1 | sed 's/^/  /'
else
  chmod +x scripts/setup.sh 2>/dev/null
  ./scripts/setup.sh 2>&1 | sed 's/^/  /' || echo "  ⚠️  setup.sh 出問題 — ping 講師"
fi

# Step 5: Open Claude Code
echo ""
echo "[5/5] 打開 Claude Code..."
if command -v claude >/dev/null 2>&1; then
  echo "  ✅ CLI 找到。執行: cd $TARGET_DIR && claude"
elif [ "$PLATFORM" = "mac" ] && [ -d "/Applications/Claude.app" ]; then
  echo "  ✅ 桌面版找到。打開中..."
  open -a "Claude" "$TARGET_DIR" 2>/dev/null || open -a "Claude Code" "$TARGET_DIR" 2>/dev/null
else
  echo "  ⚠️  Claude Code 沒裝。請到 https://claude.ai/code 下載"
fi

echo ""
echo "════════════════════════════════════"
echo "🎉 安裝完成！"
echo "════════════════════════════════════"
echo ""
echo "📁 你的 repo 在: $TARGET_DIR"
echo ""
echo "下一步:"
echo "  1. 開 Claude Code 在這 repo"
echo "  2. 對話框打 /setup-personal 建你的個人 CLAUDE.md (3 min)"
echo "  3. W1 開課時打 /start-class W1"
echo ""
echo "三個一鍵動作:"
echo "  • /save 心得          一鍵存檔"
echo "  • ./scripts/update    抓最新教材"
echo "  • /start-class W3     開新一堂"
