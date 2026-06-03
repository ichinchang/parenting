# W3 — Triage + AI 交付驗收

> 第二堂課（W3，第 3 週）。130 min 午餐。
> **對應 Anthropic 教材**: [Claude Code 101 — Daily workflows / Explore → Plan → Code → Commit](https://anthropic.skilljar.com/claude-code-101) · **主管轉譯**: Explore → Plan → **Delegate → Review**

⚠️ **連假衝突**: 注意當週連假，依 `client-config.yaml` 的 `holiday_conflicts` 調整實際日期。

## 共學目標

從「派工」進化到「**Triage + 驗收**」— 主管不只判斷哪些 task 派 AI，還要設計**怎麼驗收**。

→ AI for executives 課程最常漏的就是「驗收 + 授權 + guardrail」這 W3 補上。

## 130 min Agenda

| 時段 | 內容 |
|------|------|
| 0:00-0:10 | 🎯 Baseline lane |
| 0:10-0:25 | W1 回顧（3 主管分享派 1 件事結果） |
| 0:25-0:55 | 主題講解：Triage 三欄 + Delegate→Review + AI 驗收表 4 維度 |
| 0:55-1:35 | 動手：畫 Triage 表 + AI 驗收表 v0（部門 5 個 task）|
| 1:35-2:00 | 4 人小組分享（跨部門）|
| 2:00-2:10 | 收尾 + W5 預習 |

## Triage 三欄（核心）

| 直接派 | 半自動 | AI 不該碰 |
|--------|--------|----------|
| Routine / low-stakes | Judgment-heavy | Ethics / legal / IP / 個資 |
| 例：raw 採訪逐字稿整理 | 例：HR 績效面談 draft | 例：合約最終版 / 客戶識別資料 |

判斷 3 維度：
1. 風險高低
2. 我要不要 own 結果
3. Judgment-heavy 嗎

## AI 交付驗收表 4 維度（核心）

每維 1-5 分：

1. **正確性** — 事實 / 邏輯對嗎？怎麼 verify？
2. **完整性** — 該講的有都講到？caveat 齊嗎？
3. **風險暴露** — 誰會看到？撤得回嗎？
4. **Own 結果** — 願意掛我的名嗎？

總分 16-20 = 🟢 可用 / 11-15 = 🟡 refine / 6-10 = 🟠 reframe / 4-5 = 🔴 不該派

→ 在 Claude 內打「這 OK 嗎」會自動啟動 `acceptance-check` skill 引導你跑這 4 維度。

## 要帶走

- [ ] Triage 三欄表（自己部門 specific）
- [ ] AI 交付驗收表 v0
- [ ] Explore → Plan → Delegate → Review 主管轉譯版理解
- [ ] 4 人小組 ≥ 1 個跨部門合作場景

## 主影片 + 中文導讀

🎥 [簡立峰 哈佛商業評論 S2Ep56](https://www.youtube.com/watch?v=XHTfeCk0GwQ)

**導讀重點**：
- 「失落的一代」= 60-80 分階段的人最危險（AI 容易做到 80 分）
- 1% 超級人類 vs 99% — 主管的工作是把團隊推往 1% 那邊
- 對應 Triage：哪些 task 屬 60-80 分階段最易被 AI 取代？該怎麼幫團隊升級？

## 選讀

- [Karpathy "Software Is Changing (Again)"](https://www.youtube.com/watch?v=LCEmiRjPEtQ)（英文，stretch lane 才推）
- [Drew Bent on EdTech Insiders](https://www.youtube.com/watch?v=P8xfB9IhJMg)（Anthropic Education，stretch lane）

## 預習作業 → W5

- **必做**: 找自己團隊 1 個 SOP 想試教 AI 接
- **必做**: 讀 [Anthropic Engineering Blog — Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)（10 min）
- **選做**: Triage 表中 1 個「半自動」task 真的試派 + 用驗收表 score
- **Stretch**: AI 驗收表給屬下用 1 週收 feedback

## 用得上的指令 / skill

- `acceptance-check` skill 自動啟動（你說「這 OK 嗎 / 怎麼驗收」時）
- `delegate-sop` skill 繼續派工用
- `/save "W3 心得"`
