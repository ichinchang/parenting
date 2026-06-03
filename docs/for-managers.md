# 主管 onboarding guide

> 給「**第一次用 Claude Code 學 AI**」的主管。15-20 min 讀完。

## 你會學到什麼

不是工程師，不是 prompt engineering。**主管派工 SOP**：
- 怎麼把工作派給 AI（餵 context / 給角色 / 給範例 / 給限制）
- 怎麼驗收 AI 給的結果（4 維度評分）
- 怎麼把自己 know-how 變成 AI 可重用模板（SKILL.md）
- 怎麼跨部門互學

3 個月後，你會：
- 能判斷哪些工作該交 AI、哪些不該
- 有自己的個人 CLAUDE.md（AI 認識你的工作）
- 有至少 1 個 SOP/SKILL.md（你的「不睡覺員工」）
- 寫一份部門 AI 使用規範給屬下用

## 三個一鍵動作（必記）

| 動作 | Claude 桌面 / CLI 內 | Terminal |
|------|---------------------|----------|
| **存檔上傳** | `/save 心得` | `./scripts/save "心得"` |
| **抓最新教材** | `/update` | `./scripts/update` |
| **開新筆記** | `/start-class W3` | `./scripts/new-log "W3"` |

不會 git？**不用會**。`save` 這個 script 幫你 add+commit+push 一次到位。

## 三個會自動發生的事

1. **你跟 Claude 的對話自動 capture** 到 `session-logs/`（不用手寫筆記）
2. **任務結束會提醒存檔** （hook，throttle 15 min 避免太煩）
3. **講師更新教材你能拉到** （跑 `/update`）

## Hook 註冊（setup.sh 已自動處理）

`./scripts/setup.sh` v2 會**自動**寫進 `~/.claude/settings.json`（含 backup + jq/python merge）。**不用手動改 JSON**。

如果 setup.sh 報「沒裝 jq 也沒 python3」→ 跟講師說，他會手動幫你註冊一次。

驗證 hook 註冊成功：

```bash
cat ~/.claude/settings.json | grep stop-capture-log
```

看到 `stop-capture-log.sh` 就 OK。

## 對話 log 上傳機制

每次 Claude 結束一段對話 → hook 自動跑：
1. Copy 對話 jsonl 進 `session-logs/raw/`
2. 轉成 readable markdown 進 `session-logs/{date}-{topic}.md`

你跑 `/save` 時自動 commit + push 上 PRIVATE git repo。**講師會看到**（cohort 內、不公開）。

### 不想上傳某段對話

**最簡單**：對話開始前打 `/clear`。敏感對話從一開始就不要進 Claude session。

**事後刪**：跑 `/save` 前手動刪掉 `session-logs/raw/<file>.jsonl` 和對應 `.md`。

## 常見 Troubleshoot

### `./scripts/setup.sh` 跑不起來
- Mac：`chmod +x scripts/* .claude/hooks/*.sh` 後再試
- Windows：用 WSL 跑，或請講師幫忙

### Hook 沒觸發 / 對話沒 capture
- 跑 `cat ~/.claude/settings.json | grep stop-capture` 看 hook 有沒註冊
- 沒有 → 回上面「Hook 註冊」段重做

### Claude 沒看到 skill
- 重啟 Claude Code（quit + 重開）
- 確認 `.claude/skills/` 4 個資料夾都有 SKILL.md

### `./scripts/save` 報「沒新變更」
- 你還沒做事？或對話 log 還沒寫進來（hook 還沒 fire）
- 自己手動 `ls session-logs/` 看看有沒東西

### `python3 not found`
- Mac: `brew install python3`
- Windows: 從 [python.org](https://python.org) 裝
- 沒裝也沒關係，session log 還是會以 raw jsonl 形式存（只是少個 readable md）

## 我的 CLAUDE.local.md 該怎麼填？

W1 開始填。一頁紙包含：
- 你是誰（部門 / 職稱 / 管理規模）
- 你的工作（3-5 句）
- 想 AI 幫的痛點（3-5 個）
- 寫作 / 決策風格偏好
- AI 不該碰的禁區

Claude 每次對話會讀這個（你不用每次告訴它你是誰）。

這檔案 **不會上傳 git**（在 .gitignore 內），個人 context 保護。

## 上完課該不該繼續用？

12 週後你的 CLAUDE.md + SKILL.md = 永久資產（跟你走）。共學結束 ≠ 用 AI 結束。
