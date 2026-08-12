# build-reproducible-agent-evals 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `build-reproducible-agent-evals` | 通过 | 通过 |
| `should-trigger-02` | 应调用 | `build-reproducible-agent-evals` | 通过 | 通过 |
| `should-trigger-03` | 应调用 | `build-reproducible-agent-evals` | 通过 | 通过 |
| `should-not-trigger-01` | 诱饵 | `formalize-and-verify-agent-work` | 通过 | 通过 |
| `should-not-trigger-02` | 诱饵 | `design-verifiable-agent-rewards` | 通过 | 通过 |
| `edge-01` | 边界 | `measure-capability-vs-reliability` | 通过 | 通过 |
| `edge-02` | 边界 | `none` | 通过 | 通过 |

- 初始机械判卷：7/7（100.0%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

本 Skill 无初始争议，无需回炉。
## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
