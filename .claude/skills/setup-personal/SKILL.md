---
name: setup-personal
description: 互動引導填 CLAUDE.local.md。當用戶說「填個人 CLAUDE」「設定個人檔案」「CLAUDE.local.md 怎麼填」「我不知道怎麼填這 template」「教我寫自己的 CLAUDE.md」「我是新主管要 setup」「W1 開始」，跑互動式 5 段引導，**不丟模板**，一段一段問完寫進 CLAUDE.local.md。
---

# Setup Personal — 互動填 CLAUDE.local.md

W1 開課時用。**不要丟模板給主管自己填**（會放棄）。一段一段對話引導，邊填邊寫進 `CLAUDE.local.md`。

## 何時啟動

用戶說：
- 「填個人 CLAUDE」
- 「設定個人檔案」
- 「CLAUDE.local.md 怎麼填」
- 「我不知道怎麼填這 template」
- 「教我寫自己的 CLAUDE.md」
- 「我是新主管要 setup」
- 「W1 開始」

## 5 段互動引導（一次一段）

### Section 1: 你是誰
> 「我來幫你建個人 CLAUDE.md，這檔案讓 Claude 認識你不用每次重講。
>
> 兩種模式：
> 1. **快速模式**：你直接給我一段話描述自己（部門 / 工作 / 痛點 / 風格），我幫你 organize 成 CLAUDE.md → 一次搞定，30 秒
> 2. **引導模式**：我一段一段問 5 個 section → 3 分鐘搞定，0 經驗推薦
>
> 你想要哪個？或直接貼一段給我也行。」

**快速模式偵測**：如果用戶第一句 > 100 字含部門+工作描述 → 直接走快速模式，不跑下面 5 段。Organize 成 CLAUDE.md 寫檔 + 結尾「想 refine 哪段直接說」。

**否則**走下面 5 段。

### Section 1.1: 你是誰（引導模式）
> 「OK 走引導模式。第 1 段：你是誰。請給我：
> 1. 你姓名（用真名或化名都可）
> 2. 你部門（HR / 編輯 / 行銷 / 業務 / 客服 / 其他）
> 3. 你職稱
> 4. 你帶幾人團隊（沒帶人寫 0）
>
> 一次給我這 4 個就好。」

### Section 2: 你的工作
> 「第 2 段：你每天主要做什麼。3-5 句話描述。
>
> 不用完美，例：『我管編輯部，每天看稿、跟作者溝通、排版上稿』就夠。」

### Section 3: 痛點（最關鍵）
> 「第 3 段：你最想 AI 幫你解的 3-5 個痛點。
>
> 不知怎麼想？給你 5 個提示：
> 1. 你每天最不想做但又必做的事？
> 2. 你常花 1 hr 以上做的重複性工作？
> 3. 你會說「這事丟給屬下做」但屬下也不會的？
> 4. 你寫一樣的 email / 報告 / 摘要 N 次的？
> 5. 你常拖延的東西？
>
> 寫 3-5 個就好。」

### Section 4: 風格（短答即可）
> 「第 4 段：你工作風格偏好。每題挑 1 個（或自己描述）：
>
> 1. 寫作: 簡潔 vs 詳盡？
> 2. 用詞: 中文 vs 中英混 vs 全英文？
> 3. Emoji: 喜歡 vs 不要？
> 4. 對外: 偏正式 vs 偏輕鬆？
>
> 一次 4 個答案。」

### Section 5: 禁區
> 「最後一段：AI 絕不能用在哪？
>
> 例：客戶識別資料 / 合約最終版 / 員工績效 / 健康 / 家庭。
>
> 列你自己的（2-4 個）。寫完我會幫你存。」

## 收完 5 段 → 寫檔

組合成 `CLAUDE.local.md`，存到 repo root。

```markdown
# 我的個人 CLAUDE.md

> Setup: {today date} via /setup-personal

## 我是誰
- 姓名: {Section 1.1}
- 部門: {Section 1.2}
- 職稱: {Section 1.3}
- 管理規模: {Section 1.4}

## 我的工作
{Section 2}

## 我最想 AI 幫我解的痛
{Section 3 列點}

## 我的工作風格
- 寫作: {Section 4.1}
- 用詞: {Section 4.2}
- Emoji: {Section 4.3}
- 對外: {Section 4.4}

## AI 不該碰的禁區
{Section 5 列點}

---
*v0 created via /setup-personal · 上完 W3 可以回來 iterate (加 Triage 思維) · W9 加部門 AI 規範對接*
```

存完印：
> ✅ 個人 CLAUDE.md 寫好了 (`CLAUDE.local.md`)。下次跟 Claude 對話會自動讀。要 iterate 跑 `/setup-personal` 再來一次。

## 重要規則

- ❌ 不要一次列 5 段問題（主管放棄）
- ❌ 不要直接 write 模板到 `CLAUDE.local.md` 讓用戶自己填（這是 dry-run 發現的 P0 friction）
- ✅ 一段一段問，等回答才下一段
- ✅ Section 3「痛點」最關鍵，0 經驗主管會卡，必給 5 提示
- ✅ Section 4「風格」用選一個的方式，不要 open question
- ✅ 全部完成才寫檔，不要寫半完成版

## 失敗 fallback

如果用戶 mid-flow 說「太多 / 不想填了 / 跳過」：

→ 「沒問題，只填你想填的 section。其他空白也能 work，Claude 會用 default 行為。我直接幫你存目前有的，之後想補再跑 `/setup-personal`。」

→ 寫部分版本，標明 `(待填)`，存檔。
