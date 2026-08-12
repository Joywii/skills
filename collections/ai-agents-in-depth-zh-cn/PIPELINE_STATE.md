# 《深入理解 AI Agent：设计原理与工程实践》蒸馏状态

## 当前状态

- **流水线**：Cangjie Skill / RIA-TV++
- **当前阶段**：全部完成
- **书籍版本**：v1.4，2026 年 8 月 11 日
- **作者**：李博杰
- **源文件**：`AI-Agents-in-Depth-zh-CN.pdf`（本仓库不分发原 PDF）
- **源文件 SHA-256**：`f0a0f81eef02afb8fdd0b5f0df6cab5edc8d3e597974441c5a6ab9aa24b8235e`
- **页数**：307
- **工作文本**：构建期逐页文本（未分发，仅用于本次蒸馏）

## 阶段检查表

- [x] 阶段 0：Adler 整书理解
- [x] 生成 `BOOK_OVERVIEW.md`
- [x] 核对封面、版本、作者、目录、各章小结和后记
- [x] 用户确认阶段 0 骨架和重点方向（2026 年 8 月 11 日）
- [x] 阶段 1：五类提取器生成候选池
- [x] 阶段 1.5：语义去重与 V1/V2/V3 三重验证
- [x] 用户确认 22 个拟生成 Skill 单元（2026 年 8 月 12 日）
- [x] 阶段 2：构造 22 个 RIA++ Skills
- [x] 阶段 2 质量回炉：22 条 R 引文与源文本精确匹配
- [x] 阶段 3：Zettelkasten 链接、索引和术语表
- [x] 阶段 4：压力测试、独立裁决与回炉复测
- [x] 阶段 5：生成 DIGEST 并安装通过测试的 Skills

## 已完成产物

- `BOOK_OVERVIEW.md`：整书结构、关键术语、核心命题、论证链、批判边界和候选 Skill 方向
- `candidates/frameworks.md`：30 条框架候选
- `candidates/principles.md`：100 条原则候选
- `candidates/cases.md`：100 条案例证据，覆盖全书 103 个编号实验
- `candidates/counter-examples.md`：115 条反例与失败模式
- `candidates/glossary.md`：27 条核心术语
- `verified.md`：22 个通过全部三重验证的合并方法单元
- `rejected/*.md`：103 个合并吸收记录与 5 个明确淘汰记录
- `<skill-slug>/SKILL.md`：22 个完整 RIA++ Skills
- `INDEX.md`：22 个 Skills 的主题索引、关系图与学习顺序
- `GLOSSARY.md`：27 条共享术语
- `<skill-slug>/test-prompts.json`：22 份 darwin 兼容测试，共 154 条 prompt
- `<skill-slug>/test-results.md`：22 份独立盲测报告；最终均为 7/7，诱饵均为 2/2
- `DIGEST.md`：按全书论证骨架组织、链接全部 22 个 Skills 的精华长文
- `README.md`、`LICENSE`、`NOTICE.md`：GitHub 发布说明、Apache-2.0 许可证和原书署名
- Codex 用户级安装已验证：22/22 个目录与构建产物一致

## 下一步

流水线已完成并收录到 `Joywii/skills`。后续可由仓库根目录的安装脚本部署，并使用各目录的 `test-prompts.json` 做持续回归或自动进化。
