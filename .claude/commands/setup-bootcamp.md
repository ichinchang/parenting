---
description: 一鍵 setup Leader Bootcamp（給桌面版主管用，不碰 terminal）。處理 hooks 註冊 / upstream remote / 個人 CLAUDE.md。
---

# /setup-bootcamp — 桌面版一鍵 setup

User 第一次開 Claude Code 進入這 repo 跑此 command。代替 `./scripts/setup.sh`（terminal 版）。

## 動作（一步一步跑，每步 echo 結果）

### Step 1: 偵測 prereqs
跑 `python3 --version` + `jq --version`，回報有沒裝。沒裝給 install 指令（不擋）。

### Step 2: 設執行權限
```bash
chmod +x scripts/* .claude/hooks/*.sh
```

### Step 3: 自動寫 Stop hooks 到 ~/.claude/settings.json
跑 `./scripts/setup.sh` 內 step 3 邏輯（jq merge or python fallback 自動寫）。

包含 backup `settings.json.backup-{timestamp}`。

### Step 4: 加 upstream remote（cohort template）
- Check `.upstream-template` file 是否存在
- 如有 → `git remote add upstream https://github.com/$(cat .upstream-template).git`
- 如無 → 提示「沒設定 upstream，./scripts/update 將無法拉教材更新，ping 講師」

### Step 5: Mark setup done
```bash
touch .setup-done
```

### Step 6: 啟動個人 CLAUDE.md 引導
跑完上面後直接接：「Setup 完成！現在幫你建個人 CLAUDE.md。」自動啟動 `setup-personal` skill 跑 5 段引導。

## 完成後印

```
✅ Setup 完成！

你現在可以：
1. /start-class W1   — 開始第一堂課
2. /save 心得         — 存檔上傳
3. 直接打字問問題     — Claude 會引導你

不會做的事：
- /setup-bootcamp 不會再跑第二次（.setup-done marker 存在）
- 要重設刪 .setup-done 再跑
```

## 失敗 fallback

任何 step 失敗 → 明確說哪步失敗 + 對應 troubleshoot：
- python3 沒裝 → Mac: brew install python3 / Win: python.org
- 寫 settings.json 失敗 → ping 講師手動加
- upstream 加失敗 → 講師要在 `.upstream-template` 放對 ORG/REPO 字串

不打斷主管 flow — 失敗的 step skip，能跑的繼續跑。
