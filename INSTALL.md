# Setup（給主管）

給完全沒用過 Claude Code / Git 的主管。每一步卡住都有講師帶，不用怕。

---

## Step 1: 裝 Claude Code 桌面版

到 [claude.ai/download](https://claude.ai/download) 下載（Mac / Windows 都有），裝好打開，**用公司給的 Claude Team 帳號登入**（Michelle 寄的邀請信那個）。

打不開？
- Mac：跳「無法驗證」→ 右鍵點 App → 打開
- Windows：跳 SmartScreen → 仍要執行

---

## Step 2: 把教材抓到電腦（不用會 git，最省事）

用瀏覽器下載就好，**不需要任何 git 設定**：

1. 瀏覽器登入 [github.com](https://github.com)，打開你的專屬 repo（完整網址班主任會給你）
2. 綠色 **Code** 鈕 → **Download ZIP**
3. 雙擊解壓，得到一個資料夾
4. 打開 Claude Code 桌面版 → **Code 分頁** → 開這個資料夾

這時 Claude 已經讀得到教材（CLAUDE.md + skills），可以開始幫你了。

---

## Step 3: 連上 GitHub + 接成可同步（一次性，講師會帶）

ZIP 下載的資料夾還不能「存檔上傳 / 抓更新」。要連上你的 GitHub 接成可同步 —— 在 Claude Code 對話框直接說：

> 幫我登入 GitHub，然後跑 ./scripts/connect-git.sh

- Claude 會帶你做**一次 GitHub 授權**：跳瀏覽器按一下「Authorize」就好（**不用貼任何 token**）
- `connect-git.sh` 會把資料夾接成可同步的 git repo，並逐項檢查 ✅
- 這是唯一要你點一下的地方，之後都不用再做

卡住 → 找講師，當場幫你。

---

## Step 4: 一次性 setup

對話框說：

> 幫我跑 ./scripts/setup.sh

會註冊 hook（任務結束自動提醒存檔）+ 建你的個人設定。

---

## Step 5: 學會 3 個一鍵動作

| 動作 | 在 Claude Code 對話框打 |
|------|------------------------|
| **存檔上傳** | `/save 心得一句話` |
| **抓最新教材** | `/update` |
| **開新一堂筆記** | `/start-class W3` |

就這樣。git 細節 hook 會幫你處理，你不用懂。

---

## ⚠️ 透明告知（重要）

**你跟 Claude 的對話 log 會被自動 capture 進 `session-logs/` 並上傳到 PRIVATE git repo**。

理由：共學收斂分析（W9 / W11）+ 講師改進教材 + 你自己回顧學習軌跡。

**隱私控制**：
- 你的 repo 是 PRIVATE，**其他 15 位主管看不到你的**（每人只有自己的 repo）
- 讀得到你 repo 的人：**你自己 + 講師（Young）+ 公司管理者（Michelle / IT，做共學營運管理用）**
- 不想上傳的對話可手動刪 `session-logs/raw/<file>.jsonl` 後再 `/save`
- 涉及客戶資料 / 個資的對話，**建議直接在 Claude Code 內 `/clear` 不上傳**

---

## 出問題了？

1. ZIP 解壓後 Claude Code 開不到資料夾 → 確認解壓完是「資料夾」不是還壓著的 .zip
2. `connect-git.sh` 說抓不到 repo → repo 名可能不對 / 你還沒被加進去 → 找班主任
3. `setup.sh` 失敗 → 看 `docs/for-managers.md` troubleshooting
4. 其他 → 直接 ping 講師
