# attribute-first-errors 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `attribute-first-errors` | 通过 | 通过 |
| `should-trigger-02` | 应调用 | `attribute-first-errors` | 争议：action | 独立裁决通过 |
| `should-trigger-03` | 应调用 | `attribute-first-errors` | 争议：action | 独立裁决通过 |
| `should-not-trigger-01` | 诱饵 | `engineer-agent-failure-closure` | 通过 | 通过 |
| `should-not-trigger-02` | 诱饵 | `diagnose-agent-boundaries` | 争议：action | 独立裁决通过 |
| `edge-01` | 边界 | `none` | 通过 | 通过 |
| `edge-02` | 边界 | `attribute-first-errors` | 通过 | 通过 |

- 初始机械判卷：4/7（57.1%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-02`

- 初始问题：路由正确，但只冻结证据，未按失败簇定位首错并提出单变量因果假设
- 独立裁决：`grader_overstrict`。首动作正是 attribute-first-errors 的 E1 冻结可重放证据包，定位首错与单变量假设应在其后。
- 处理：放宽首动作判定，接受先执行 E1；另在后续动作断言首错定位、因果假设与配对回归。

### `should-trigger-03`

- 初始问题：路由正确，但未定位首错、冻结首错前状态并定义动作集合。
- 独立裁决：`grader_overstrict`。正式 E1 要先冻结目标、完整轨迹、状态和版本，之后才定位首错并构造前缀动作集。
- 处理：将首动作预期改为允许 E1 证据冻结，把首错前状态和动作集合放到后续步骤检查。

### `should-not-trigger-02`

- 初始问题：路由正确，但首动作仅保存材料，未按观察、策略、动作、反馈逐面定位
- 独立裁决：`grader_overstrict`。diagnose-agent-boundaries 的 E1 就是保存输入、轨迹、工具日志、最终状态并建立外部验收。
- 处理：接受 E1 为合法首动作，后续再检查 observation、policy、action、feedback 四面审计。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
