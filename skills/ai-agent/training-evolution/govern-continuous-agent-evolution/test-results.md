# govern-continuous-agent-evolution 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `govern-continuous-agent-evolution` | 通过 | 通过 |
| `should-trigger-02` | 应调用 | `govern-continuous-agent-evolution` | 通过 | 通过 |
| `should-trigger-03` | 应调用 | `govern-continuous-agent-evolution` | 争议：action | 独立裁决通过 |
| `should-not-trigger-01` | 诱饵 | `route-agent-updates` | 通过 | 通过 |
| `should-not-trigger-02` | 诱饵 | `choose-sft-or-rl` | 通过 | 通过 |
| `edge-01` | 边界 | `govern-continuous-agent-evolution` | 争议：action | 独立裁决通过 |
| `edge-02` | 边界 | `none` | 通过 | 通过 |

- 初始机械判卷：5/7（71.4%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-03`

- 初始问题：未建立记忆、迁移、冲突更新和旧能力保留四类发布门
- 独立裁决：`grader_overstrict`。画正式版本、测试、日志、审批和回滚指针的可信根正是 evolution Skill 的 E1。
- 处理：接受可信根先行；后续在联合发布门检查记忆、迁移、冲突更新和旧能力保留。

### `edge-01`

- 初始问题：未先区分轨迹存储、检索记忆与正式行为更新并纠正持续学习表述
- 独立裁决：`grader_overstrict`。画生产 Agent、学习池、正式版本和不可修改验证门权限符合 E1，可先阻断伪持续学习的发布权。
- 处理：接受权限可信根首动作；后续明确区分日志存储、检索记忆与经验证的正式行为更新。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
