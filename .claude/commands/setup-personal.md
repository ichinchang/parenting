---
description: 互動建你個人 CLAUDE.md（5 段引導 3 分鐘）。同義於直接說「幫我建立個人 CLAUDE.md」。
---

# /setup-personal — 互動建個人 CLAUDE.md

跑 `setup-personal` skill。對應 `.claude/skills/setup-personal/SKILL.md`。

5 段引導：
1. 你是誰（部門 / 職稱 / 規模）
2. 你的工作（3-5 句）
3. 痛點（3-5 個，含 5 提示）
4. 風格（4 短答）
5. 禁區（2-4 個）

完成後寫進 `CLAUDE.local.md`（gitignored 不上傳）。

## 重度用戶 escape

第 1 段問完偵測到主管已給長段落 + role + example → 直接走快速模式 organize 寫檔，不跑剩 4 段。
