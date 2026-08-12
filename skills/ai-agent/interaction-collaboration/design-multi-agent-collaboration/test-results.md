# design-multi-agent-collaboration 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `design-multi-agent-collaboration` | 通过 | 通过 |
| `should-trigger-02` | 应调用 | `design-multi-agent-collaboration` | 争议：action | 独立裁决通过 |
| `should-trigger-03` | 应调用 | `design-multi-agent-collaboration` | 争议：action | 独立裁决通过 |
| `should-not-trigger-01` | 诱饵 | `isolate-before-compressing-context` | 争议：action | 回炉复测通过 |
| `should-not-trigger-02` | 诱饵 | `build-independent-review-loops` | 通过 | 通过 |
| `edge-01` | 边界 | `design-multi-agent-collaboration` | 争议：boundary | 修正测试期望后通过 |
| `edge-02` | 边界 | `design-multi-agent-collaboration` | 通过 | 通过 |

- 初始机械判卷：3/7（42.9%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-02`

- 初始问题：只做单Agent基线，未先建立角色可见性矩阵和结构化移交包
- 独立裁决：`grader_overstrict`。等预算单 Agent 基线是多 Agent Skill 的 E1，证明角色信息或权限增量是紧接的 E2。
- 处理：接受 E1-E2 为首动作，后续检查可见性矩阵、自包含移交包及最小权限。

### `should-trigger-03`

- 初始问题：路由正确，但首动作未落实visited set、父子取消与隔离写入。
- 独立裁决：`grader_overstrict`。先建等预算基线并画带所有者、验收的 DAG 符合 E1 与 E3，生命周期治理是后续 E6。
- 处理：接受基线和 DAG 先行；后续强制检查 visited set、父子取消、全局预算和隔离写空间。

### `should-not-trigger-01`

- 初始问题：路由正确，但直接隔离且只规定输出，缺少自包含输入与验收契约。
- 独立裁决：`true_action_failure`。路由正确，但直接隔离且只约束回传，缺少 E2-E3 要求的自包含输入和独立验收，命中 ce025。
- 处理：在 `isolate-before-compressing-context` 的 E 段增加执行硬门：共享依赖和自包含输入、输出、验收契约明确前，不得创建隔离上下文。
- 复测：路由到 `isolate-before-compressing-context`；首个动作是“先建立信息流与腐化基线：标记搜索日志的来源、体积、重复度、消费者和可重建性，并记录约束遗忘、重复调用、token与延迟。”

### `edge-01`

- 初始问题：固定REST并发应直接用普通工作流，不应激活多Agent专科。
- 独立裁决：`test_expectation_wrong`。用户正问是否给请求配 Agent，符合 description；调用 E1 建确定性并发基线并据 B 判停合理。
- 处理：允许激活该 Skill 做否决判断，验收重点改为最终采用普通并发工作流而非多 Agent。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
