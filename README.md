# Skills

可复用 Agent Skills 仓库。Skill 按领域和主题分类存放，来源相同的一组 Skills 另在 `collections/` 中保留索引、精华和审计材料。

## 目录约定

```text
skills/
└── <domain>/
    └── <category>/
        └── <skill-slug>/
            ├── SKILL.md
            ├── test-prompts.json
            └── test-results.md

collections/
└── <source-slug>/
    ├── README.md
    ├── INDEX.md
    ├── DIGEST.md
    ├── GLOSSARY.md
    └── audit/
```

宿主通常要求每个 Skill 直接位于其 Skills 根目录下，因此仓库用嵌套目录维护分类，安装时由脚本按 slug 展平。

## 当前分类

| 领域 | 分类 | 内容 |
|---|---|---|
| `ai-agent` | [`foundations`](./skills/ai-agent/foundations/) | Agent 边界诊断与自治选型 |
| `ai-agent` | [`context-knowledge`](./skills/ai-agent/context-knowledge/) | 上下文、状态、记忆与检索 |
| `ai-agent` | [`tools-runtime`](./skills/ai-agent/tools-runtime/) | 工具信任、审核、故障闭环与形式化验证 |
| `ai-agent` | [`evaluation`](./skills/ai-agent/evaluation/) | 可复现评估、可靠性与首错归因 |
| `ai-agent` | [`training-evolution`](./skills/ai-agent/training-evolution/) | SFT/RL、奖励、更新载体与持续进化 |
| `ai-agent` | [`interaction-collaboration`](./skills/ai-agent/interaction-collaboration/) | 实时交互、多尺度行动与多 Agent 协作 |
| `stock` | [`skills`](./skills/stock/) | A股和美股数据、新闻情绪、机构资金流与股票筛选 |

当前集合：[`ai-agents-in-depth-zh-cn`](./collections/ai-agents-in-depth-zh-cn/)，从李博杰《深入理解 AI Agent：设计原理与工程实践》v1.4 蒸馏出 22 个 Skills。

## 安装

安装全部 Skills 到 Codex 用户目录：

```bash
./scripts/install.sh --target ~/.codex/skills
```

只安装一个 Skill：

```bash
./scripts/install.sh --target ~/.codex/skills --skill diagnose-agent-boundaries
```

Claude Code 或项目级安装只需更换 `--target`。脚本不会覆盖同名目录；如需升级，应先审阅 diff，再显式移除旧版本。

## 校验

```bash
ruby ./scripts/validate_repository.rb
```

校验覆盖 YAML frontmatter、slug 唯一性、相关 Skill 引用、测试 JSON、结果报告、本地 Markdown 链接和绝对路径泄漏。

## 添加 Skill

新增内容前阅读 [CONTRIBUTING.md](./CONTRIBUTING.md)。核心要求：一个目录只放一个原子 Skill；目录名与 frontmatter `name` 一致；必须说明触发条件与不适用边界；来源、许可证和测试随 Skill 一起提交。

## License

仓库自有内容采用 [Apache License 2.0](./LICENSE)。由外部作品蒸馏或引入的内容还须遵守对应集合中的 `NOTICE.md` 和上游许可证。
