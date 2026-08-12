# route-agent-updates 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `route-agent-updates` | 争议：action | 回炉复测通过 |
| `should-trigger-02` | 应调用 | `route-agent-updates` | 争议：action | 独立裁决通过 |
| `should-trigger-03` | 应调用 | `route-agent-updates` | 通过 | 通过 |
| `should-not-trigger-01` | 诱饵 | `choose-sft-or-rl` | 通过 | 通过 |
| `should-not-trigger-02` | 诱饵 | `govern-continuous-agent-evolution` | 通过 | 通过 |
| `edge-01` | 边界 | `build-evidence-backed-memory` | 争议：action | 独立裁决通过 |
| `edge-02` | 边界 | `route-agent-updates` | 通过 | 通过 |

- 初始机械判卷：4/7（57.1%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-01`

- 初始问题：路由正确，但先做载体分类，跳过带条件、例外和来源的原子化。
- 独立裁决：`true_action_failure`。路由正确，但首动作直接进入 E2 载体分类，跳过 E1 的原子能力、触发条件、例外、来源与证据。
- 处理：在 `route-agent-updates` 的 E 段增加执行硬门：更新原子化为触发条件、期望行为、例外和来源前，不得判断载体。
- 复测：路由到 `route-agent-updates`；首个动作是“先将新例外原子化为目标能力：写明触发条件、期望行为、例外、来源及要改变的可观察结果，并附成功、失败证据。”

### `should-trigger-02`

- 初始问题：未判断规则可形式化且不可绕过，也未将审批权限路由至程序门控
- 独立裁决：`grader_overstrict`。把审批经验改写成含条件、例外和证据的目标能力正是 route-agent-updates 的 E1。
- 处理：接受 E1 原子化先行；后续判断其可形式化且不可绕过，并路由到服务端程序门控。

### `edge-01`

- 初始问题：兄弟路由正确，但未先定义追加证据、冲突关系和时间作用域。
- 独立裁决：`grader_overstrict`。路由到 memory 正确，先定义用途、保留期、隐私、删除权和发布门槛是其正式 E1。
- 处理：接受 E1 生命周期边界；后续再定义追加证据、冲突关系、有效期和可重建当前视图。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
