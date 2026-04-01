# ZHU_YH Repo Setup And Test

## 1. 本地仓设置

如果 GitHub 上已经创建了组织仓 `LoongEnv-HIT/LoongEnv-ZHU_YH`，在本地执行：

```bash
cd /home/yhzhu/LoongEnv-ZHU_YH
git remote add origin git@github.com:LoongEnv-HIT/LoongEnv-ZHU_YH.git
git branch -M main
```

如果已经配置过远程，只需检查：

```bash
git remote -v
```

## 2. 提交并 push

在 `ZHU_YH` 本地仓放入资料后执行：

```bash
cd /home/yhzhu/LoongEnv-ZHU_YH
git add .
git commit -m "Add initial materials"
git push -u origin main
```

## 3. 布告栏测试

`SUPERVISOR_AI` 会读取 `LoongEnv-ZHU_YH` 的最新提交，并在布告栏中以 `ZHU_YH` 名义显示。

测试方式有两种：

1. push 到 `LoongEnv-ZHU_YH` 后，去 `LoongEnv` 的 Actions 页面手动运行 `SUPERVISOR_AI`
2. 等待每天北京时间 08:10 的定时任务自动运行

## 4. 验证入口

- 中枢仓首页 `今日主入口`
- `dashboard/README.md`
- `docs/daily-status-board.md`
