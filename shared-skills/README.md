# Shared Skills — 跨主管 SKILL 庫

這資料夾收 cohort 內主管**主動分享**的 SKILL.md。

## 結構

```
shared-skills/
├── README.md (你正在讀)
├── {manager-slug-1}/
│   ├── recruit-screening.md  (HR 主管寫的招募初篩 SOP)
│   └── interview-followup.md
├── {manager-slug-2}/
│   └── editorial-style-guide.md  (編輯主管寫的稿件風格 SOP)
└── ...
```

## 怎麼用

### 我想用別人的 SKILL

跑 `./scripts/update` 拉 upstream → 翻 `shared-skills/` 看 → 試用 / 改寫 / 抄結構到我自己 `my-skills/`。

### 我想分享我的 SKILL 給別人

```bash
./scripts/share-skill <skill-name> --message "簡短說明"
```

Script 會：
1. Fork cohort template repo
2. 建 branch
3. 加你的 SKILL 進 `shared-skills/{你的 slug}/{skill-name}.md`
4. 開 PR 給講師 review
5. 講師 merge 後其他主管下次 `./update` 拉到

## 規則

- ✅ 分享前確認 SKILL 沒含**客戶識別資訊** / 真實 email / 個資
- ✅ 用「假資料 / 假客戶 / 假同事」當範例
- ❌ 不要分享 CLAUDE.local.md（這是個人 context，他人無用）
- ❌ 不要分享 session-logs/raw/（這是你跟 Claude 的真實對話）

## W7 / W9 對接

- **W7 兩兩 swap**：對話互教不寫進 shared-skills/（太多版本管理痛）
- **W9 Give-1**：上 demo 給 16 人看 + 同步透過 share-skill 開 PR → 講師 merge → cohort 共享
- **W11 demo**：每人挑 1 個最強 SKILL share 進 cohort 資產
