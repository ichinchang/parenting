# 我的 SKILL（自己寫的 AI 模板）

> W5 開始你會在這裡寫自己的 SKILL.md（一頁工作 SOP 給 AI 用）。

## 這資料夾是什麼

當你把自己的 know-how 變成 **AI 可重用模板**，就放這。

例如：
- HR 部門「招募初篩 SOP」 → `recruit-screening.md`
- 編輯部「採訪逐字稿整理」 → `interview-transcript-clean.md`
- 業務「客戶 follow up 信」 → `customer-follow-up.md`

每個 SKILL 一個 `.md` 檔。Claude 看到本 repo 自動把這些當你的私人工具。

---

## 一頁 SOP 模板（W5 會教）

```markdown
---
name: my-skill-name
description: 簡短一句話。Claude 用這判斷何時啟動此 skill。
---

# 我的工作 SOP

## 何時用
（描述什麼情境會用到，3-5 句）

## 步驟
1. ...
2. ...
3. ...

## 輸入
- 我會給 Claude 什麼資料
- 什麼格式

## 輸出
- 我期待 Claude 給回什麼
- 什麼格式

## 範例
（給 1-2 個真實 case）
```

W5 上完後，你會寫第一個。W7 swap 給其他主管看 + 拿別人的試。

---

## 範例：Young 的 crm-skill

看 `examples/crm-skill-example.md`（W5 demo 用）— Young 把人脈分析 SOP 變 AI 模板的完整 case study。
