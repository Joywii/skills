# design-verifiable-agent-rewards 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `design-verifiable-agent-rewards` | 通过 | 通过 |
| `should-trigger-02` | 应调用 | `design-verifiable-agent-rewards` | 争议：action | 独立裁决通过 |
| `should-trigger-03` | 应调用 | `design-verifiable-agent-rewards` | 争议：action | 独立裁决通过 |
| `should-not-trigger-01` | 诱饵 | `choose-sft-or-rl` | 争议：action | 回炉复测通过 |
| `should-not-trigger-02` | 诱饵 | `build-reproducible-agent-evals` | 通过 | 通过 |
| `edge-01` | 边界 | `none` | 争议：action | 修正测试期望后通过 |
| `edge-02` | 边界 | `none` | 通过 | 通过 |

- 初始机械判卷：3/7（42.9%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-02`

- 初始问题：未列出可直接观察且决策时可见的中间事件，也未规划过程奖励消融
- 独立裁决：`grader_overstrict`。列最终状态、允许路径和不可妥协禁止路径完全符合 reward Skill 的 E1，过程信号是 E4。
- 处理：接受真实目标与禁区先行；后续再枚举环境可观察过程事件并逐项消融。

### `should-trigger-03`

- 初始问题：路由正确，但未按来源、时机、可见信息和路径四维先审计。
- 独立裁决：`grader_overstrict`。先定义终态、禁止路径并隔离验证面符合 E1-E2，四维奖励审计应在 E3 随后进行。
- 处理：接受目标和验证面硬门先行；后续检查 producer、time、visible_information、allowed_path。

### `should-not-trigger-01`

- 初始问题：路由正确，但直接收集SFT样例，跳过可解析性与外部修复检查。
- 独立裁决：`true_action_failure`。路由正确，但直接收集 SFT 样例，跳过 E1 复现、E2 外部修复消融与 E3 缺口分类。
- 处理：在 `choose-sft-or-rl` 的 E 段增加执行硬门：失败复现、动作可解析性和外部可修复性消融完成前，不得收集样本或选择 SFT/RL。
- 复测：路由到 `choose-sft-or-rl`；首个动作是“先固定模型版本、输入、工具状态、期望与实际函数调用，写成单一可复现失败，并用同一基线至少复现3次。”

### `edge-01`

- 初始问题：正确不做奖励设计，但未先核验数据集与相关性标注可信度。
- 独立裁决：`test_expectation_wrong`。正式 description/B 明确排除无人优化该分数的纯离线评测；数据标注核验不属于本 Skill 的执行契约。
- 处理：仅断言不激活奖励设计并按普通离线协议比较；标注核验可作评测建议，不作首动作硬匹配。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
