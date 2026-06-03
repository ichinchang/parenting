# Claude Leader Bootcamp

> 給「<b>主管學 Claude Code</b>」用的可重用 template。3 個月 / 6 堂課 / 不教 prompt engineering 理論，教<b>主管派工 SOP</b>。

## 3 層架構

```
Layer 1: claude-leader-bootcamp (Young PRIVATE)            ← 教材 source of truth
              ↓ 客戶接案 ./customize-cohort-template.sh
Layer 2: {客戶ORG}/cohort-template-{year}                   ← Cohort 客製（開課日 / 學員數）
              ↓ 16 主管各自 fork ./create-manager-repos.sh
Layer 3: {客戶ORG}/{manager}-leader-journey                  ← 16 個獨立個人 repo
         (Young admin 看全部，主管只看自己)
```

詳細 ownership / permission matrix: [`docs/architecture.md`](docs/architecture.md)

## 這個 repo 是什麼

**Layer 1 template**。雙受眾:
- 🧑‍🏫 **講師（Young）**: 在此維護教材 source of truth，新客戶接案時跑 `customize-cohort-template.sh` 產出 Layer 2
- 🎓 **主管學員**: 不直接 clone 此 repo。他們從 Layer 3 個人 repo clone

**設計原則**:
- 不會 git 也能用（`./save "心得"` 一鍵存檔）
- Claude 對話 log 自動 capture（不用手動寫筆記）
- 任務結束自動提醒存檔（不會忘）
- 每堂課對應 [Anthropic 官方教材](https://anthropic.skilljar.com/claude-code-101) 路徑

## 主管快速上手

```bash
git clone <你拿到的 repo URL>
cd <repo>
./scripts/setup.sh             # 一次性 setup
./scripts/new-log "我的學習開始"
# 上課中... 跟 Claude 對話會自動 capture
./scripts/save "上完 W1 心得"  # 一鍵存檔上傳
```

詳細：[`docs/for-managers.md`](docs/for-managers.md)

## 講師使用（fork 給新客戶）

```bash
./scripts/customize-cohort-template.sh "客戶公司名" 16 2026-09-01
# 產出 customized 版本 → push 到客戶 ORG/cohort-template-{year}
# 再跑 ./scripts/create-manager-repos.sh ORG TEMPLATE csv → 一次建 16 個個人 repo
```

詳細：[`docs/customize-for-client.md`](docs/customize-for-client.md) + [`docs/architecture.md`](docs/architecture.md)

## 6 堂課架構

| 堂 | 主題 | 對應 Anthropic 教材 |
|----|------|---------------------|
| W0 | Pre-assessment | Claude Code 101 — What is Claude Code |
| W1 | AI 共學初探 + 主管派工 SOP | Claude Code 101 — CLAUDE.md |
| W3 | Triage + AI 驗收 | Claude Code 101 — Daily workflows |
| W5 | SOP 沉澱 | Engineering Blog — Agent Skills |
| W7 | 跨部門 swap | anthropics/skills repo |
| W9 | 共學收斂 + 部門 AI 規範 | Claude Code in Action |
| W11 | Demo 發表 | 整合演練 |

完整教材：[`classes/`](classes/)

## License

教學素材 IP: redutek（睿度科技）。客戶可使用，不可二次商業教學。詳見 [LICENSE](LICENSE).
