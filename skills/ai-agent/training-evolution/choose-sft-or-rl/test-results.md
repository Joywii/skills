# choose-sft-or-rl 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `choose-sft-or-rl` | 争议：action | 独立裁决通过 |
| `should-trigger-02` | 应调用 | `choose-sft-or-rl` | 争议：action | 独立裁决通过 |
| `should-trigger-03` | 应调用 | `choose-sft-or-rl` | 通过 | 通过 |
| `should-not-trigger-01` | 诱饵 | `route-agent-updates` | 通过 | 通过 |
| `should-not-trigger-02` | 诱饵 | `govern-continuous-agent-evolution` | 通过 | 通过 |
| `edge-01` | 边界 | `choose-sft-or-rl` | 争议：boundary | 修正测试期望后通过 |
| `edge-02` | 边界 | `choose-sft-or-rl` | 争议：action | 独立裁决通过 |

- 初始机械判卷：3/7（42.9%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-01`

- 初始问题：未先测量解析率并设为RL准入门，也未明确当前应先SFT固形
- 独立裁决：`grader_overstrict`。固定模型、工具、格式并复现解析失败正是 choose-sft-or-rl 的 E1，解析率准入在后续 E4-E5。
- 处理：接受可复现实例为首动作，后续要求外部修复消融、协议基线和 RL 准入检查。

### `should-trigger-02`

- 初始问题：路由正确，但未先判定缺口类型并检查RL环境与奖励准入。
- 独立裁决：`grader_overstrict`。固定版本、输入、工具状态和验收并复现失败符合 E1，缺口分类及 RL 准入是 E3、E5。
- 处理：允许 E1 先行，再检查策略泛化分类、奖励隔离、可复位环境和 OOD 留出集。

### `edge-01`

- 初始问题：动作虽建议检索，但仍激活被预期明确排除的SFT或RL专科。
- 独立裁决：`test_expectation_wrong`。用户明确在 Prompt 与 SFT 间选型，符合 description；调用后识别可变事实并按 E3/B 停训合理。
- 处理：允许该 Skill 参与否决训练，只要求最终把政策路由到版本化知识库/RAG并保留来源。

### `edge-02`

- 初始问题：未验证现有解析率、奖励与留出环境，也未给出可直接RL的边界
- 独立裁决：`grader_overstrict`。固定版本、环境、验证器并构造可复现策略缺口符合 E1，已有解析率和 RL 门槛应在 E4-E5核验。
- 处理：接受 E1 为首动作；后续检查外部修复、基础策略、奖励隔离及直接 RL 小规模对照。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
