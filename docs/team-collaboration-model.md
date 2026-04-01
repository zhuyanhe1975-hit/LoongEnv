# LoongEnv Team Collaboration Model

## 1. 仓库角色

`LoongEnv` 是团队共享中枢仓，不承载所有个人开发过程，而负责沉淀共享内容与统一协作入口。

仓库分工如下：

- `LoongEnv`：团队中枢仓，沉淀规范、文档、设计、部署与诊断结果
- `member-*`：成员个人工作仓，独立推进开发与实验
- `agent-*`：AI 成员工作仓，按角色承担固定辅助任务

## 2. 可见与分享

成员仓和 AI 仓彼此独立，但需要保持可见与可分享。

最小共享原则：

- 共享结论回流到 `LoongEnv`
- 共享设计回流到 `design/`
- 共享部署信息回流到 `deploy/`
- 共享诊断结果回流到 `diagnose/`
- 长期可复用材料沉淀到 `docs/` 或 `shared/`

## 3. AI 成员角色

LoongEnv 中的 AI 成员按固定职责组织，当前只保留两个角色。

- `DOCS_AI`：自动维护开发日志、里程碑归档和项目文档
- `SUPERVISOR_AI`：监督成员仓进展并生成每日工作进展布告栏

## 4. 协作流

```text
task/request
  -> member repo or agent repo
  -> local progress
  -> shared output back to LoongEnv
  -> human review
  -> merge / adopt / iterate
```

## 5. 4D 的位置

4D 是团队协作阶段，不是技能分层。

- `Define`：确认目标与边界
- `Design`：形成方案与调整建议
- `Deploy`：准备交付与发布
- `Diagnose`：定位问题并生成结论

`Diagnose` 的输出进入下一轮 `Design`，形成闭环，但最终决策由人负责。
