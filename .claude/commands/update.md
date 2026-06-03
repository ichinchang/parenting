---
description: 抓最新教材（從 cohort template upstream pull）。等同跑 `./scripts/update`。
---

# /update — 抓最新教材

跑 `./scripts/update`。

從 cohort template (upstream) 拉 W{N} 最新教材 / skill / scripts 改動。**只動教材檔，不動你個人 CLAUDE.local.md / my-skills/ / session-logs/**。

實際跑（v3 路徑式，2026-06-02 修 unrelated-histories bug）：
```
git fetch upstream main
git checkout upstream/main -- classes docs scripts .claude README.md INSTALL.md ...   # 只覆蓋教材路徑
# session-logs/ my-skills/ CLAUDE.local.md 不在清單 → 永遠不碰
git commit -m "update 教材 from template"
```

界線（實測驗證）：
- ✅ 更新：classes/ docs/ scripts/ .claude/ + 根目錄教材檔
- 🔒 保護：session-logs/ my-skills/ CLAUDE.local.md（你的紀錄絕不被蓋）
- ⚠️ 你若改過教材檔 → 會被 template 覆蓋（教材以講師為準）

成功 → 印「下一堂該做什麼」摘要。失敗 → friendly error（網路 / auth）。
**注意**：seed 是 fresh-init，跟 template 無共同歷史，所以**不能用 `git merge`**（會 fatal）。
