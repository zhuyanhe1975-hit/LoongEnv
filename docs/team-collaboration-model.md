# LoongEnv 团队协作模型

本文描述协作流与 AI 分工；仓库边界与目录语义以 [中枢仓与成员仓边界说明](./hub-repo-boundaries.md) 为准。

## 1. 仓库角色

`LoongEnv` 是团队共享中枢仓，不承载所有个人开发过程，而负责沉淀共享内容与统一协作入口。

仓库分工如下：

- `LoongEnv`：团队中枢仓，沉淀规范、文档、设计、部署与诊断结果
- 成员仓：以成员标识（如 `ZHU_YH`）区分，对应本地接入目录 `repos/<成员标识>` 与远程成员仓 `LoongEnv-<成员标识>`
- `LoongEnv` GitHub Actions：团队级 AI 角色的统一运行入口

## 2. 可见与分享

成员仓与团队级 AI 流程彼此分离，但需要保持可见与可分享。

最小共享原则：

- 共享结论回流到 `LoongEnv`
- 共享设计回流到 `design/`
- 共享部署信息回流到 `deploy/`
- 共享诊断结果回流到 `diagnose/`
- 长期可复用材料沉淀到 `docs/` 或 `shared/`

## 3. AI 成员角色

LoongEnv 中的 AI 成员按固定职责组织，统一挂在组织中枢仓下。

- `DOCS_AI`：自动维护开发日志、里程碑归档和项目文档
- `SUPERVISOR_AI`：监督成员仓进展并生成每日工作进展布告栏
- `DEPLOY_AI`：调度成员仓发布流水线并维护统一部署入口

## 4. 协作流

```text
task/request
  -> member repo
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
