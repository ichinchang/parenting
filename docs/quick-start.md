# 快速安裝（W1 開課前）— 兩條路選一

預估時間 **5 分鐘**。不要再花 30-60 min setup。

## 路徑 A: 桌面版（推薦給 0 經驗 / 不想開 terminal）

### Step 1: 裝 Claude Code 桌面版

到 [claude.ai/code](https://claude.ai/code) 下載 Mac / Windows 版。安裝（2 min）。

### Step 2: 接受 GitHub 邀請

到你的 GitHub 信箱找 invitation email → 點 "Accept invitation"。

### Step 3: 用桌面版 clone repo

打開 Claude Code → 左上「**Open Folder**」or「**Clone Repository**」→ 貼講師給你的 repo URL：

```
https://github.com/{YOUR-ORG}/yourname-leader-journey.git
```

### Step 4: 在 Claude Code 內跑 setup

對話框打：

```
/setup-bootcamp
```

Claude 會自動：
- 寫 hooks 進 settings.json（不用碰 JSON）
- 加 upstream remote（拿教材更新用）
- 設執行權限
- 引導你寫個人 CLAUDE.md（接著跑 `/setup-personal` 5 段引導）

**總計 5-6 min**，0 terminal 操作。

---

## 路徑 B: CLI 一行 curl（有經驗 / 講師現場 IT 跑）

```bash
# 把 ORG/REPO 換成你個人 repo 路徑
curl -fsSL https://raw.githubusercontent.com/Youngger9765/claude-leader-bootcamp-installer/main/quick-install.sh | bash -s -- ORG/REPO
```

或下載後跑：

```bash
curl -O https://raw.githubusercontent.com/Youngger9765/claude-leader-bootcamp/main/scripts/quick-install.sh
bash quick-install.sh ORG/REPO
```

Script 會自動：
1. 裝 gh / python3 / jq（Mac brew / Linux apt）
2. `gh auth login`（瀏覽器登入）
3. Clone 個人 repo 到 `~/leader-bootcamp/REPO`
4. 跑 `./scripts/setup.sh`
5. 打開 Claude Code

**總計 3-4 min**（含瀏覽器登入）。

---

## 現場 batch setup 策略（W1 開課當天 16 人同時跑）

### 講師端準備（W1 前 3 天）

1. **印 quick-start 卡** — 每人 1 張 A4，含：
   - 個人 repo URL
   - 路徑 A vs B 二選一指示
   - 萬一卡 → 講師電話
   - WiFi 密碼 / power outlet 位置

2. **預測卡關點 + IT 預備**：
   - **Windows 主管**: 走路徑 A（桌面版），跳過 brew
   - **公司電腦無 admin 權限**: 講師借備用筆電 1-2 台
   - **proxy / firewall block GitHub**: 用個人手機開熱點

3. **講師現場分工**:
   - 主要講師: 帶 baseline lane + 主題講解（不能停下來幫安裝）
   - 助教 / IT: 處理 setup 卡關（路徑 A 走桌面版優先）

### 開課當天 timeline (W1 130 min 內)

```
0:00-0:10  Baseline lane / IT 處理卡關（target: 14/16 setup OK）
0:10-0:25  圓桌一句話 — 同時最後 2 人 setup
0:25-0:50  主題講解（不再 setup，落單的助教 1-on-1）
0:50-...   動手實作（所有人 ready）
```

落單 2-4 人沒 setup OK → **不阻擋主課程**，助教課後 follow up。

---

## 安裝失敗 fallback

主管 setup 卡 5 min 沒解 → **直接放棄當下 setup**，走「**講師電腦 demo + 主管旁聽**」模式：
- 主管不裝 → 看講師螢幕 + 紙本筆記
- 課後助教 1-on-1 setup（不在主課程時間）

**心態**：W1 是 AI 思維啟蒙 + 共學 framing，不是 Git/Python 救火課。Setup 失敗 ≠ 課失敗。

---

## Troubleshoot 快查

| 問題 | 解 |
|------|---|
| 桌面版 Open Folder 報「沒 access」 | 確認 GitHub invitation 接受了 |
| `gh auth login` 卡瀏覽器 | 用 `gh auth login --with-token`（講師給 token） |
| `brew` 沒裝 | 走路徑 A 桌面版 |
| `python3 not found` | setup.sh 會 fallback，session log 仍 capture 但 markdown 轉換少 |
| Hook 沒 fire | 重啟 Claude Code |
| Clone 失敗 `403` | GitHub 沒登入 / 沒 access — `gh auth login` 重新 |
| Hook 寫 settings.json 失敗 | 講師手動加（看 docs/for-managers.md fallback 段）|
