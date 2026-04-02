# 4D+C 架构说明

本文说明项目的正向设计架构 **4D+C**，并明确它与 `LoongEnv` 中枢仓目录语义的区别。

## 1. 什么是 4D+C

4D+C 指：

- `Define`
- `Design`
- `Deploy`
- `Diagnose`
- `Core`

这是一套**项目架构 / 模块开发结构**，用于表达项目本体如何被分解、推进和落地。

## 2. 4D+C 不等于中枢仓根目录

`LoongEnv` 首先是**团队中枢仓**，其根目录应优先表达：

- 文档与导航入口
- 协作入口
- 成员仓接入
- 共享沉淀与归档
- 自动化工作流入口

因此，4D+C 不应直接作为中枢仓根目录的一组一级模块名称来理解。

## 3. 为什么要与根目录语义分离

如果 `Design / Deploy / Diagnose` 直接出现在中枢仓根目录，容易产生两种误读：

1. 看起来像项目本体的模块结构
2. 又被误认为中枢仓本身的信息架构

尤其当这组目录并不完整时（例如根目录存在 `design/`、`deploy/`、`diagnose/`，但没有 `define/`、`core/`），误解会更明显。

## 4. 在 LoongEnv 中如何表达 4D+C

在 `LoongEnv` 中，4D+C 应主要通过以下方式呈现：

- 作为**架构说明**出现在 `docs/`
- 作为**共享结论的分类依据**影响归档方式
- 作为**成员仓实现结构**留在成员各自的工作仓中

这意味着：

- 中枢仓负责说明、映射、回流结果与导航
- 成员仓负责真实实现与模块落地

## 5. 与 `archives/` 的关系

为避免根目录混入 4D+C 的一级模块语义，`LoongEnv` 将逐步使用 `archives/` 作为共享归档命名空间，例如：

- `archives/design/`
- `archives/deploy/`
- `archives/diagnose/`

这些目录表达的是**中枢仓中的共享沉淀区**，不是 4D+C 模块在中枢仓中的真实实现目录。

## 6. 与其他文档的关系

- 中枢仓 / 成员仓边界：[`docs/hub-repo-boundaries.md`](./hub-repo-boundaries.md)
- 团队协作流程：[`docs/team-collaboration-model.md`](./team-collaboration-model.md)
- 仓库拓扑：[`docs/repo-topology.md`](./repo-topology.md)
- 文档总览：[`docs/README.md`](./README.md)
