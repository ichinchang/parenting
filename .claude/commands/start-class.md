---
description: 開始上某一堂課。`/start-class W1` 會印該堂教材摘要 + 建 session log。
---

# /start-class — 開新課堂 session

User 輸入：`/start-class $ARGUMENTS`

`$ARGUMENTS` = 課堂代號（W0 / W1 / W3 / W5 / W7 / W9 / W11）

## 動作

1. 讀 `classes/wN-*/README.md`（對應該課堂）
2. 印該堂的「共學目標 + 要帶走 + 主影片連結」摘要
3. 跑 `./scripts/new-log "$ARGUMENTS 上課筆記"` 建 session log
4. 提示主管：「對話自動存到 session-logs/。準備好就開始問問題。」

## 找不到對應堂

如果 `$ARGUMENTS` 不在 `[W0, W1, W3, W5, W7, W9, W11]` → 印錯誤 + 列出可選堂。
