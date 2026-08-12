# Contributing

## 路径与命名

- 使用 `skills/<domain>/<category>/<skill-slug>/`。
- `<domain>` 和 `<category>` 表达稳定分类，不使用作者名、日期或临时项目代号。
- `<skill-slug>` 使用小写 ASCII kebab-case，并与 `SKILL.md` frontmatter 的 `name` 完全一致。
- 同一来源产生的多个 Skills 在 `collections/<source-slug>/` 建立集合索引，不要为每本书复制一套分类树。

## Skill 最小要求

- `SKILL.md` 必须包含合法 YAML frontmatter。
- `description` 必须明确何时触发、何时不适用，并能与相邻 Skills 区分。
- 执行步骤必须可操作、可验收，并包含判停或升级条件。
- 边界部分必须记录失败模式、风险和替代方案。
- 如存在测试，使用 `test-prompts.json`；至少包含应调用、不应调用和边界场景。
- 测试执行后提交 `test-results.md`，如实保留失败、裁决与回炉记录。

## 来源与安全

- 外部来源必须在对应集合的 `NOTICE.md` 中标注作者、链接、版本和许可证。
- 不提交原始付费内容、无权分发的全文、访问令牌、私有配置、用户数据或本机绝对路径。
- 引用应短且可追溯；解释、步骤和边界应使用自己的组织与表述。
- 不静默覆盖同名 Skill。发生命名冲突时，先判断是否应合并、改名或用更具体的边界拆分。

## 提交前

```bash
ruby ./scripts/validate_repository.rb
```

确认新增 Skill 能被安装脚本发现，并至少用一条应调用和一条不应调用 prompt 做宿主验证。
