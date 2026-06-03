# W1 — AI 共學初探 + 主管派工 SOP

> 第一堂課（6/3 那週 · 120 min 午餐）
> **對應 Anthropic 教材**: [Claude Code 101 — CLAUDE.md file module](https://anthropic.skilljar.com/claude-code-101)

## 共學目標

**從「我裝完 Claude」(W0) 到「我每天用 Claude」** — 把 W0 收的真實場景跑出第一個 production-grade 結果（不是 W0 那種 wow demo，是工作真的用到）+ 看其他主管 demo 學別人怎麼用

> ⚠️ **W1 ≠ W0 重做** — W0 已完成個人 CLAUDE.md + 第一次對話 + 場景清單。W1 是「**把 W0 承諾的場景跑通**」

## 🔥 開場時事 hook — 黃仁勳 6/1 GTC Taipei 2026

開課前一天（6/1）黃仁勳在台北 GTC 揭曉 Vera Rubin AI 平台 + RTX Spark「Agent PC」，名言：「過去 40 年你開程式、點按、打指令；**現在你只要下指令，PC 幫你完成**」—— 正好對接今天的「主管派工」主題：你變成下指令的人，AI 幫你把事做完。「台北就是一切的起點」，台灣 150 家供應鏈夥伴共同打造。

🎥 [GTC Taipei 2026 黃仁勳主題演講](https://www.youtube.com/watch?v=AjCa3TTOPL4)

## 120 min Agenda

| 時段 | 內容 |
|------|------|
| 0:00-0:15 | **Share-out**：你 W0 承諾的場景這週試過嗎？（每人 1 句：wow / disappointment 哪個）|
| 0:15-0:45 | 🎤 **30 min 短講「AI 時代主管的 3 個身分」**（見下方）|
| 0:45-1:05 | **production-grade demo + 主管動手起步**（採訪逐字稿 → AI 摘要 → 編輯 review → ship 完整 workflow）|
| 1:05-1:10 | 伸展 + 4 人小組互看隔壁螢幕 |
| 1:10-1:40 | **同儕 demo round**：3 位主管現場 5 min demo + 評析 |
| 1:40-1:55 | 收斂 framing（從 3 個 demo 收回「主管 3 個身分」）|
| 1:55-2:00 | W3 預告 + 預習作業 |

## 🎤 W1 短講「AI 時代主管的 3 個身分 — 為什麼今天不是來學 prompt」（30 min）

不是學工具，是**重新定義主管邊界**。三個身分：

1. **派工者** — AI = 下屬，你要學會 delegate（怎麼餵 context、定 KPI、講樣子、講禁忌）
2. **編輯者** — 從作家轉編輯（呼應簡立峰「把 60 分初稿改到 80 分」）
3. **規則制定者** — 為團隊畫 AI 紅線（呼應「主管制定遊戲規則」）

> 互動式：每段講完留 2 min 反思「我對哪個身分最弱」，LINE 群打字回應

## 主管派工 SOP — 四步法（核心）

不教 prompt engineering 理論。用「**主管派工**」框架：

1. **餵 context** — 帶下屬熟悉狀況
2. **給角色** — 定 KPI
3. **給範例** — 講樣子
4. **給限制** — 講禁忌

→ 在 Claude 內打 `/ask` 會自動引導你跑這四步。

## ⚠️ 資料 / 資安邊界（必看）

W1 必懂 3 條白話規矩 — **W9 會擴展成你部門的正式 AI policy**：

| 規矩 | 內容 | 動作 |
|------|------|------|
| ✅ 公開資料 | 已在公司網站 / 媒體 / 公開報告 | 直接餵 AI |
| ⚠️ 內部資料 | 公司內但不識別到特定客戶 / 員工 | 把人名 / email / 客戶名換成代號（客戶A / email_001）再餵 |
| ❌ 客戶 PII / 個資 | email / 電話 / 身分證 / 訂單明細含真名 | **不直餵**，餵假資料結構讓 AI 寫程式 / SQL 你自己跑 |

不確定 = 不要餵。問講師 / 公司資安窗口。

→ 在 Claude 內問「客戶資料能不能餵 AI」`privacy-boundary` skill 自動啟動引導你。

## 📺 配套影片（W0-W1 之間預習，挑幾部看，每部 < 20 min）

🇹🇼 **中文**：
- 簡立峰《善用 AI 成為 1% 超級人才》TO Talk EP82（~20 min）— π 型人才 + 60→80 framing
- 簡立峰《AI 移民時代》NYCU keynote 精華 0:00-15:00 — AI 移民 hook（[完整版](https://www.youtube.com/watch?v=LZc6heAtXwo)）

🇺🇸 **英文**：
- Anthropic "Claude in 5 minutes"（Anthropic 官方 YouTube，5 min）— Claude Code intro
- Karpathy "Software 3.0" YC talk 精華 0:00-15:00 — AI native 工作流主管視角

**選讀（不強制）**：
- [簡立峰 哈佛商業評論 S2Ep56](https://www.youtube.com/watch?v=XHTfeCk0GwQ)
- [Dario Amodei「Machines of Loving Grace」](https://www.darioamodei.com/essay/machines-of-loving-grace)（Anthropic CEO essay）

## 要帶走

1. **追蹤 1 個 W0 承諾場景跑出 production-grade 結果**（真的 ship 到工作流，不是試試看）
2. 看過至少 3 個其他主管的 demo（學別人怎麼用）
3. CLAUDE.local.md 補充細節（角色 / 工作 / 痛點）
4. 下次 pair partner 1 位（W1-W5 同搭檔）

## 課前準備

- ✅ 填 CLAUDE.local.md 的個人欄位（或開課時填）
- ✅ 帶 laptop
- ✅ 想 1 個工作痛點（任何形式都可）

## 預習作業 → W3（只 1 條，不疊加）

**追蹤你 W1 跑通的場景，這週至少跑 3 次**（同一場景 deepen，不是新場景），記錄前後差距（時間 / 品質）

## 用得上的 Claude 指令

- `/ask` — 引導你用四步法問清楚
- `/save "心得"` — 一鍵存檔
- `delegate-sop` skill — 你說「想叫 AI 幫我做 X」時自動啟動
- `privacy-boundary` skill — 你問「客戶資料能不能餵」時自動啟動
