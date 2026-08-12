# choose-rag-retrieval-mode 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `choose-rag-retrieval-mode` | 争议：action | 回炉复测通过 |
| `should-trigger-02` | 应调用 | `choose-rag-retrieval-mode` | 通过 | 通过 |
| `should-trigger-03` | 应调用 | `choose-rag-retrieval-mode` | 通过 | 通过 |
| `should-not-trigger-01` | 诱饵 | `build-evidence-backed-memory` | 通过 | 通过 |
| `should-not-trigger-02` | 诱饵 | `progressively-disclose-capabilities` | 通过 | 通过 |
| `edge-01` | 边界 | `choose-rag-retrieval-mode` | 争议：boundary | 修正测试期望后通过 |
| `edge-02` | 边界 | `choose-rag-retrieval-mode` | 通过 | 通过 |

- 初始机械判卷：5/7（71.4%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-01`

- 初始问题：路由正确，但直接搭混合链，跳过稀疏稠密基线与证据覆盖指标。
- 独立裁决：`true_action_failure`。路由正确，但直接执行 E3 混合链，跳过 E1 证据集合和 E2 分块、索引上下文，未建立可判定基线。
- 处理：在 `choose-rag-retrieval-mode` 的 E 段增加执行硬门：证据集合和可比较基线完成前，不得直接搭建 hybrid、rerank 或 Agentic RAG。
- 复测：路由到 `choose-rag-retrieval-mode`；首个动作是“先定义答案所需证据集合：明确法条主体、时效、管辖范围、必引来源，以及需最相关文档还是全集覆盖。”

### `edge-01`

- 初始问题：动作虽转向SQL，但仍激活了预期明确排除的RAG专科。
- 独立裁决：`test_expectation_wrong`。问题正询问是否采用向量检索，description 覆盖检索模式选型；调用后按 E1/B 否决 RAG 合理。
- 处理：将预期改为允许激活该 Skill 做边界判定，只要求最终转 SQL/确定性全表聚合。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
