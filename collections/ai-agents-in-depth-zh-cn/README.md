# 《深入理解 AI Agent》Skills 集合

从李博杰《深入理解 AI Agent：设计原理与工程实践》v1.4 蒸馏出的 22 个可执行 Agent Skills。

- 原书仓库：<https://github.com/bojieli/ai-agent-book>
- 蒸馏版本：v1.4，2026-08-11
- 方法：cangjie-skill / RIA-TV++
- 测试：154 条独立盲测，22 个 Skills 最终均为 7/7，诱饵均为 2/2

## 阅读入口

- [INDEX.md](./INDEX.md)：Skill 总览、关系图和学习顺序
- [DIGEST.md](./DIGEST.md)：按全书论证骨架组织的精华长文
- [GLOSSARY.md](./GLOSSARY.md)：27 条共享术语
- [BOOK_OVERVIEW.md](./BOOK_OVERVIEW.md)：整书结构、解释、批判和应用潜力
- [verified.md](./verified.md)：22 个通过三重验证的方法单元
- [audit/](./audit/)：候选池和淘汰、合并记录
- [NOTICE.md](./NOTICE.md)：原书署名、版本和许可说明

## Skills 分类

### Foundations

- [`diagnose-agent-boundaries`](../../skills/ai-agent/foundations/diagnose-agent-boundaries/SKILL.md)
- [`choose-agent-autonomy`](../../skills/ai-agent/foundations/choose-agent-autonomy/SKILL.md)

### Context & Knowledge

- [`design-cache-stable-context`](../../skills/ai-agent/context-knowledge/design-cache-stable-context/SKILL.md)
- [`progressively-disclose-capabilities`](../../skills/ai-agent/context-knowledge/progressively-disclose-capabilities/SKILL.md)
- [`distill-explicit-agent-state`](../../skills/ai-agent/context-knowledge/distill-explicit-agent-state/SKILL.md)
- [`isolate-before-compressing-context`](../../skills/ai-agent/context-knowledge/isolate-before-compressing-context/SKILL.md)
- [`build-evidence-backed-memory`](../../skills/ai-agent/context-knowledge/build-evidence-backed-memory/SKILL.md)
- [`choose-rag-retrieval-mode`](../../skills/ai-agent/context-knowledge/choose-rag-retrieval-mode/SKILL.md)

### Tools & Runtime

- [`design-trusted-agent-tools`](../../skills/ai-agent/tools-runtime/design-trusted-agent-tools/SKILL.md)
- [`build-independent-review-loops`](../../skills/ai-agent/tools-runtime/build-independent-review-loops/SKILL.md)
- [`engineer-agent-failure-closure`](../../skills/ai-agent/tools-runtime/engineer-agent-failure-closure/SKILL.md)
- [`formalize-and-verify-agent-work`](../../skills/ai-agent/tools-runtime/formalize-and-verify-agent-work/SKILL.md)

### Evaluation

- [`measure-capability-vs-reliability`](../../skills/ai-agent/evaluation/measure-capability-vs-reliability/SKILL.md)
- [`build-reproducible-agent-evals`](../../skills/ai-agent/evaluation/build-reproducible-agent-evals/SKILL.md)
- [`attribute-first-errors`](../../skills/ai-agent/evaluation/attribute-first-errors/SKILL.md)

### Training & Evolution

- [`choose-sft-or-rl`](../../skills/ai-agent/training-evolution/choose-sft-or-rl/SKILL.md)
- [`design-verifiable-agent-rewards`](../../skills/ai-agent/training-evolution/design-verifiable-agent-rewards/SKILL.md)
- [`route-agent-updates`](../../skills/ai-agent/training-evolution/route-agent-updates/SKILL.md)
- [`govern-continuous-agent-evolution`](../../skills/ai-agent/training-evolution/govern-continuous-agent-evolution/SKILL.md)

### Interaction & Collaboration

- [`design-realtime-agent-interactions`](../../skills/ai-agent/interaction-collaboration/design-realtime-agent-interactions/SKILL.md)
- [`build-multiscale-action-loops`](../../skills/ai-agent/interaction-collaboration/build-multiscale-action-loops/SKILL.md)
- [`design-multi-agent-collaboration`](../../skills/ai-agent/interaction-collaboration/design-multi-agent-collaboration/SKILL.md)

本集合不分发原始 PDF 或蒸馏时的逐页工作文本。
