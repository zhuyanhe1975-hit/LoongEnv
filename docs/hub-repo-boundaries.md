# 中枢仓与成员仓边界说明

本文是 `LoongEnv` 仓库架构的**权威说明入口**。涉及仓库拓扑、成员仓接入、AI 角色与共享回流的说明，均应以本文及其直接链接为准。

## 1. 仓库角色

### `LoongEnv`（中枢仓）

负责以下内容：

- 团队共享文档与导航入口
- 跨成员可见的状态面板、项目快照与工作量统计
- 统一的 AI 工作流入口
- 共享设计、部署、诊断结论与可复用资料的归档位置

不负责以下内容：

- 成员项目的日常实现
- 成员实验分支与中间产物
- 成员项目专属的代码结构设计

### 成员仓（如 `LoongEnv-ZHU_YH`）

负责以下内容：

- 个人或项目组的实现代码
- 实验、原型、项目级流水线
- 项目专属页面与发布产物

成员仓完成阶段成果后，将**适合共享的结论**回流到中枢仓。

## 2. 本地目录与远程仓的关系

### `repos/`

`repos/` 目录在中枢仓内只表示**本地接入占位**：

- 用于预留成员仓本地路径
- 便于记录命名映射和接入说明
- 不代表这些成员仓内容被纳入中枢仓版本管理

当前 `.gitignore` 已忽略 `repos/ZHAO_SZ/`、`repos/WANG_CZ/`、`repos/ZHU_YH/`，说明它们不是中枢仓受控内容。

### `team/` 与 `.agents/`

- `team/`：团队协作的辅助入口与占位说明
- `.agents/`：AI 角色骨架与本地占位说明

二者都**不是架构权威文档区**。涉及边界、拓扑、命名与协作规则时，应回到 `docs/` 下的权威文档。

### 命名关系

| 本地占位目录 | 成员标识 | 远程仓示例 |
| --- | --- | --- |
| `repos/ZHU_YH` | `ZHU_YH` | `LoongEnv-ZHU_YH` |
| `repos/ZHAO_SZ` | `ZHAO_SZ` | 待开放 |
| `repos/WANG_CZ` | `WANG_CZ` | 待开放 |

## 3. AI 角色归属

AI 角色统一挂在 `LoongEnv` 中枢仓的 GitHub Actions 下，而不是独立 `agent-*` 仓：

- `DOCS_AI`
- `SUPERVISOR_AI`
- `DEPLOY_AI`

角色分工说明以 [团队协作模型](./team-collaboration-model.md) 为准，运行入口以 [`.github/workflows/README.md`](../.github/workflows/README.md) 为准。

## 4. 共享回流规则

适合回流到中枢仓的内容：

- 团队结论、里程碑、快照、周报 / 月报
- 可复用设计说明与共享建议
- 部署入口、诊断结论、原始日志样本
- 团队级提示词、协作模板、复用资料

默认回流位置：

- 说明类文档：`docs/`
- 设计沉淀：`archives/design/`
- 部署结果：`archives/deploy/`
- 诊断结论：`archives/diagnose/`
- 共享资产：`shared/`
- 原始日志：`logs/`
- 团队提示词：`prompts/`

说明：

- `archives/` 是中枢仓的共享归档命名空间
- 原根目录下的 `design/`、`deploy/`、`diagnose/` 正处于迁移过渡期，暂保留为兼容入口
- 4D+C 属于项目架构语义，详见 [`docs/4d-c-architecture.md`](./4d-c-architecture.md)

### 旧目录移除策略

- 当前整理周期内：保留 `design/`、`deploy/`、`diagnose/` 作为迁移说明入口
- 下一整理周期：若导航、引用和新增内容都已切换到 `archives/`，则评估是否移除旧目录
- 在正式移除前，应先完成链接检查、导航检查与迁移说明确认

## 5. 文档权威入口

为减少重复描述，建议按以下规则理解：

- 4D+C 架构：[`docs/4d-c-architecture.md`](./4d-c-architecture.md)
- 架构边界：本文
- 协作流程：[`docs/team-collaboration-model.md`](./team-collaboration-model.md)
- 拓扑与命名：[`docs/repo-topology.md`](./repo-topology.md)
- 成员仓接入：[`docs/member-repos.md`](./member-repos.md)
- 辅助入口目录：`team/`、`.agents/`、`repos/`
- 共享归档命名空间：[`archives/README.md`](../archives/README.md)
- 日常导航：[`README.md`](../README.md)、[`dashboard/README.md`](../dashboard/README.md)、[`docs/README.md`](./README.md)
