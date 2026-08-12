# engineer-agent-failure-closure 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `engineer-agent-failure-closure` | 通过 | 通过 |
| `should-trigger-02` | 应调用 | `engineer-agent-failure-closure` | 通过 | 通过 |
| `should-trigger-03` | 应调用 | `engineer-agent-failure-closure` | 争议：action | 独立裁决通过 |
| `should-not-trigger-01` | 诱饵 | `attribute-first-errors` | 通过 | 通过 |
| `should-not-trigger-02` | 诱饵 | `diagnose-agent-boundaries` | 争议：action | 独立裁决通过 |
| `edge-01` | 边界 | `none` | 通过 | 通过 |
| `edge-02` | 边界 | `engineer-agent-failure-closure` | 通过 | 通过 |

- 初始机械判卷：5/7（71.4%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-03`

- 初始问题：路由正确，但未先按错误指纹和可重试性分类并设置熔断。
- 独立裁决：`grader_overstrict`。先画正常、失败、取消、升级和退出路径符合 failure-closure 的 E1，错误分类和熔断是 E2、E5。
- 处理：接受状态机首动作；后续检查错误指纹、可重试性、变化恢复、独立预算和熔断。

### `should-not-trigger-02`

- 初始问题：路由正确但仅保存材料，未按四个故障面补证据并确定故障槽
- 独立裁决：`grader_overstrict`。diagnose-agent-boundaries 的正式 E1 就是保存输入、完整轨迹、工具日志和最终环境状态。
- 处理：接受 E1 取证；后续再检查四面证据表及首个明确故障槽。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
