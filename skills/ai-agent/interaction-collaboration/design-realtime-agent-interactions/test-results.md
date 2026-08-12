# design-realtime-agent-interactions 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `design-realtime-agent-interactions` | 通过 | 通过 |
| `should-trigger-02` | 应调用 | `design-realtime-agent-interactions` | 通过 | 通过 |
| `should-trigger-03` | 应调用 | `design-realtime-agent-interactions` | 通过 | 通过 |
| `should-not-trigger-01` | 诱饵 | `engineer-agent-failure-closure` | 争议：action | 独立裁决通过 |
| `should-not-trigger-02` | 诱饵 | `distill-explicit-agent-state` | 争议：action | 独立裁决通过 |
| `edge-01` | 边界 | `design-realtime-agent-interactions` | 通过 | 通过 |
| `edge-02` | 边界 | `build-multiscale-action-loops` | 争议：action | 独立裁决通过 |

- 初始机械判卷：4/7（57.1%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-not-trigger-01`

- 初始问题：状态机未包含未知提交状态、幂等查询及其有限恢复判定
- 独立裁决：`grader_overstrict`。engineer-agent-failure-closure 的 E1 先画含 pending、取消、升级的状态机，未知提交语义属 E2-E4。
- 处理：接受状态机为首动作；后续再检查未知提交分类、幂等查询及有限恢复。

### `should-not-trigger-02`

- 初始问题：兄弟路由正确，但未先定义权威事件、版本和幂等reducer。
- 独立裁决：`grader_overstrict`。筛选反复推导、影响动作且可确定计算的字段正是 explicit-state 的 E1。
- 处理：接受字段筛选先行；后续断言权威事件、版本化 schema 和幂等 reducer。

### `edge-02`

- 初始问题：路由正确，但未缩短动作块或规定每次有状态动作后重观察验收
- 独立裁决：`grader_overstrict`。抓取终态及碰撞、工作区、急停不变量是 multiscale Skill 的 E1，重观察和缩块在 E4-E5。
- 处理：接受安全契约首动作；后续检查每次有状态动作后新观察、偏差中断和 chunk 缩短。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
