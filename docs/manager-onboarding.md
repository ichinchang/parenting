# 主管 Onboarding — 從 0 到上完 W1 的完整步驟

> 這是給 16 主管的 step-by-step。預估 30 分鐘搞定 setup。

## 你會收到的東西

開課前 5 天，講師（Young）會寄一封信，含：

1. 你的個人 PRIVATE repo URL（範例：`github.com/commonwealth-parenting/yourname-leader-journey`）
2. GitHub invitation 通知（要 accept）
3. Claude Code 下載連結 + 帳號開立指引
4. W0 self-assessment Google Form

## Step 1: 接受 GitHub 邀請

到你的 GitHub 信箱 / notification 找邀請信。點 "Accept invitation"。

如果沒收到，跟 IT 確認 GitHub username 對得上你的公司 email。

## Step 2: 裝 Claude Code

兩種選一個：

### 桌面版（推薦給 0 經驗）
到 [claude.ai/code](https://claude.ai/code) 下載 Mac / Windows 版。

### CLI 版（有用過 terminal）
```bash
npm install -g @anthropic-ai/claude-code
```

## Step 3: Clone 你的 repo

打開 terminal（Mac: Spotlight 找「Terminal」/ Windows: PowerShell）：

```bash
git clone https://github.com/{你的客戶ORG}/yourname-leader-journey.git
cd yourname-leader-journey
```

如果 `git` 沒裝，桌面版 Claude Code 在 settings 找「Open Folder」直接打開資料夾也可。

## Step 4: 跑一次 setup

```bash
./scripts/setup.sh
```

這會 (30 秒)：
- 設定執行權限
- 自動寫 Stop hook 進 `~/.claude/settings.json`（**自動**，不用手改 JSON）
- 確認 git remote OK
- 測試 hook 觸發

## Step 5: 建你的個人 CLAUDE.md（W1 開課時做）

開 Claude Code（在你 clone 的資料夾），對話框打：

```
/setup-personal
```

或**直接打字**也可以（任一種 Claude 都會啟動）：
> 「幫我填個人 CLAUDE.md」/「設定個人檔案」/「教我寫自己的 CLAUDE.md」

桌面版會在輸入框看到 slash command 提示，CLI 版直接打字即可。

Claude 會跑 5 段互動 (3 分鐘)：
1. 你是誰（部門 / 職稱 / 規模）
2. 你的工作（3-5 句）
3. 痛點（3-5 個，含 5 個提示）
4. 風格（4 個短答）
5. 禁區（2-4 個）

完成後 Claude 自動寫進 `CLAUDE.local.md`（不會上傳 git，個人 context）。

## Step 6: 開始上課

W1 課堂上：

| 想做的事 | 在 Claude 內打 |
|---------|--------------|
| 開新筆記 | `/start-class W1` |
| 引導我問問題 | `/ask` |
| 派工給 AI | 直接說「我想叫 AI 幫我做 X」(`delegate-sop` 自動啟動) |
| 問資料能不能餵 AI | 直接問「能不能丟 X 給 AI」(`privacy-boundary` 自動啟動) |
| 一鍵存檔 | `/save 心得` |

## 三個一鍵動作（必記）

| 動作 | Claude 對話框 | Terminal |
|------|--------------|---------|
| **存檔上傳** | `/save 心得` | `./scripts/save "心得"` |
| **抓最新教材** | 沒 command，跑 terminal | `./scripts/update` |
| **開新筆記** | `/start-class W3` | `./scripts/new-log "W3"` |

## 你跟 Claude 對話會自動 capture

**重要：每次 Claude task 結束**，hook 自動：
1. Copy 對話 jsonl 進 `session-logs/raw/`
2. 轉成 readable markdown 進 `session-logs/{date}-{topic}.md`

你跑 `/save` 時自動 commit + push 上你的 PRIVATE repo。**只有你 + 講師看得到**（其他 15 主管看不到你的 repo）。

### 不想上傳某段對話？

**做法 A（推薦）**：對話前打 `/clear`。敏感內容（客戶資料 / 個資 / 合約）從一開始就不要進 Claude session。

**做法 B**：跑 `/save` 前手動刪 `session-logs/raw/<file>.jsonl` 對應 `.md` 也刪。

## 常見 Troubleshoot

| 問題 | 解 |
|------|---|
| `./scripts/setup.sh` 沒權限 | `chmod +x scripts/* .claude/hooks/*.sh` 再試 |
| Hook 沒觸發 | 重啟 Claude Code |
| `python3 not found` | Mac: `brew install python3` / Windows: 到 [python.org](https://python.org) 裝 |
| Git push 失敗 | 跑 `gh auth login` 重新登入，或 ping 講師 |
| Claude 沒讀我 CLAUDE.md | 重啟 Claude Code（quit + 重開） |

## 隱私 + 安全要點

- ✅ Repo PRIVATE — 只有你 + 講師（org admin）+ 你 invite 的人看得到
- ✅ CLAUDE.local.md 不上傳 git（在 .gitignore）
- ✅ 對話 log 可手動刪除不上傳
- ❌ **不要** 把客戶 PII（email / 電話 / 身分證 / 訂單明細含真名）直餵 Claude — W1 會講 3 條規矩
- ❌ **不要** push 任何 token / API key / 密碼到 git

## 開課前 checklist

- [ ] GitHub invitation accepted
- [ ] Claude Code 裝好
- [ ] Repo cloned
- [ ] `./scripts/setup.sh` 跑過
- [ ] W0 self-assessment Google Form 填好
- [ ] W1 當天 laptop 充飽 + 帶來

任何問題直接 ping 講師。
