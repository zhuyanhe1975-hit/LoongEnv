# repos

`repos/` 用于记录**成员仓本地接入入口**，不是中枢仓受控的成员仓实现目录。

## 当前约定

- `repos/<成员标识>`：本地占位或本地 clone 挂载点
- 真实成员仓仍在各自独立远程仓中维护
- 这些目录默认被中枢仓 `.gitignore` 忽略，不参与中枢仓版本管理

## 参考文档

- [中枢仓与成员仓边界说明](../docs/hub-repo-boundaries.md)
- [成员仓说明](../docs/member-repos.md)
