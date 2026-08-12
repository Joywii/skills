# measure-capability-vs-reliability 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `measure-capability-vs-reliability` | 争议：action | 独立裁决通过 |
| `should-trigger-02` | 应调用 | `measure-capability-vs-reliability` | 通过 | 通过 |
| `should-trigger-03` | 应调用 | `measure-capability-vs-reliability` | 通过 | 通过 |
| `should-not-trigger-01` | 诱饵 | `build-reproducible-agent-evals` | 通过 | 通过 |
| `should-not-trigger-02` | 诱饵 | `design-verifiable-agent-rewards` | 通过 | 通过 |
| `edge-01` | 边界 | `none` | 通过 | 通过 |
| `edge-02` | 边界 | `measure-capability-vs-reliability` | 争议：action | 独立裁决通过 |

- 初始机械判卷：5/7（71.4%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-01`

- 初始问题：未分别计算解释Pass@5与连续Pass^5，首动作没有纠正指标误用
- 独立裁决：`grader_overstrict`。定义真实通过条件及安全、合规、副作用否决项正是 reliability Skill 的 E1。
- 处理：接受 E1；后续再按业务单位分别计算 Pass@5 与连续 Pass^5，并说明二者含义。

### `edge-02`

- 初始问题：未明确拒绝独立伯努利幂次公式，也未提出分组实测或相关模型
- 独立裁决：`grader_overstrict`。通过定义、否决项及重试业务单位覆盖 E1-E2，相关性审计与实测估计在 E3-E4。
- 处理：接受 E1-E2 先行；后续要求标记非独立，拒绝直接幂次并采用分组实测或相关模型。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
