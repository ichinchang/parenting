#!/bin/bash
# connect-git.sh — git cold-start + check
#
# 給「用瀏覽器下載 ZIP、還沒設過 git」的主管。
# 把 ZIP 解壓的純資料夾，接成「可同步雲端」的 git repo，並檢查每一步。
# Claude Code 會幫你跑這支；卡住的地方它會照下面的訊息引導你。
#
# 用法（Claude Code 內或終端機）：
#   ./scripts/connect-git.sh                 # 自動從資料夾名猜你的 repo
#   ./scripts/connect-git.sh cp-member-你的   # 或明確指定你的 repo 名

set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"; cd "$ROOT"
ORG="parenting-execs-2026"

echo "🔧 git cold-start 檢查 + 設定"
echo "────────────────────────────"

# ── 1. git 裝了嗎 ───────────────────────────────
if ! command -v git >/dev/null 2>&1; then
  echo "❌ [1/5] git 還沒裝"
  echo "     Mac：終端機跑  xcode-select --install  （跳視窗按安裝）"
  echo "     Windows：到 git-scm.com 下載安裝，裝完重開 Claude"
  echo "     裝好再跑一次我"
  exit 1
fi
echo "✅ [1/5] git: $(git --version | awk '{print $3}')"

# ── 2. 已經是 git repo？（用 clone 來的就跳過接線）─────
if [ -d .git ]; then
  echo "✅ [2/5] 這已經是 git repo（你是用 clone 來的）→ 不用接線"
  HAVE_GIT=1
else
  echo "📦 [2/5] 偵測到這是「ZIP 下載」的資料夾（沒有 git 歷史）→ 等下幫你接上雲端"
  HAVE_GIT=0
fi

# ── 3. gh 裝了嗎 + 授權了嗎 ──────────────────────
if ! command -v gh >/dev/null 2>&1; then
  echo "❌ [3/5] GitHub CLI (gh) 還沒裝"
  echo "     Mac：brew install gh   /   Windows：winget install GitHub.cli"
  echo "     （不會裝就跟 Claude 說「幫我裝 gh」或找助教）裝好再跑一次我"
  exit 1
fi
if ! gh auth status >/dev/null 2>&1; then
  echo "🌐 [3/5] GitHub 還沒授權 — 這是唯一要你點一下的地方"
  echo "     請跑這行（會開瀏覽器讓你按 Authorize，不用貼任何 token）："
  echo ""
  echo "         gh auth login --web --git-protocol https"
  echo ""
  echo "     或直接在這個對話跟 Claude 說「幫我登入 GitHub」。授權完再跑一次我。"
  exit 2
fi
echo "✅ [3/5] GitHub 已授權：$(gh api user --jq .login 2>/dev/null)"
gh auth setup-git 2>/dev/null || true

# ── 4. 接上雲端（只有 ZIP 資料夾才需要）──────────────
if [ "$HAVE_GIT" = "0" ]; then
  REPO="${1:-}"
  if [ -z "$REPO" ]; then
    BASE=$(basename "$ROOT")
    REPO=$(echo "$BASE" | sed -E "s/^${ORG}-//; s/-[0-9a-f]{7,40}$//")
    echo "   （從資料夾名猜你的 repo 是：${REPO}，若不對請改跑 ./scripts/connect-git.sh cp-member-你的）"
  fi
  REMOTE="https://github.com/${ORG}/${REPO}.git"
  echo "⬇️  [4/5] 接上雲端 ${ORG}/${REPO} ..."
  git init -b main -q
  git remote remove origin 2>/dev/null || true
  git remote add origin "$REMOTE"
  if git fetch origin main -q 2>/dev/null; then
    git reset --hard origin/main -q
    git branch --set-upstream-to=origin/main main >/dev/null 2>&1 || true
    echo "✅ [4/5] 接上成功 — 你的資料夾現在是可同步的 git repo"
  else
    echo "❌ [4/5] 抓不到 $ORG/$REPO"
    echo "     多半是：repo 名不對，或你還沒被加進這個 repo"
    echo "     → 找班主任 / 助教確認你的 repo 名 + 你有沒有被邀請"
    exit 3
  fi
else
  echo "✅ [4/5] 已是 git repo，不用接線"
fi

# ── 5. 最終檢查 ─────────────────────────────────
echo ""
echo "===== ✅ git cold-start 檢查結果 ====="
echo "  git repo  : $([ -d .git ] && echo 'yes' || echo 'NO')"
echo "  remote    : $(git remote get-url origin 2>/dev/null || echo '（無）')"
echo "  branch    : $(git branch --show-current 2>/dev/null || echo '?')"
echo "  GitHub 帳號: $(gh api user --jq .login 2>/dev/null || echo '?')"
echo "  最新 commit: $(git log -1 --oneline 2>/dev/null || echo '?')"
echo ""
echo "👉 都 ✅ 的話，接著跑：./scripts/setup.sh   （完成 hook + 個人設定）"
