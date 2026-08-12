# choose-agent-autonomy 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `choose-agent-autonomy` | 争议：action | 独立裁决通过 |
| `should-trigger-02` | 应调用 | `choose-agent-autonomy` | 通过 | 通过 |
| `should-trigger-03` | 应调用 | `choose-agent-autonomy` | 通过 | 通过 |
| `should-not-trigger-01` | 诱饵 | `diagnose-agent-boundaries` | 争议：action | 独立裁决通过 |
| `should-not-trigger-02` | 诱饵 | `choose-rag-retrieval-mode` | 通过 | 通过 |
| `edge-01` | 边界 | `choose-agent-autonomy` | 通过 | 通过 |
| `edge-02` | 边界 | `none` | 通过 | 通过 |

- 初始机械判卷：5/7（71.4%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-01`

- 初始问题：路由正确，但未按路径动态性、可验证性和风险先行分区。
- 独立裁决：`grader_overstrict`。choose-agent-autonomy 的 E1 就是写清输入、终态、不可逆动作与人工责任，三轴评估随后展开。
- 处理：接受 E1 任务与副作用边界；后续检查路径动态性、验证自动化和风险分区。

### `should-not-trigger-01`

- 初始问题：兄弟路由正确，但首动作只冻结证据，未核对工具结果反馈链。
- 独立裁决：`grader_overstrict`。路由到 diagnose-agent-boundaries 正确，冻结轨迹、日志、版本和完成断言是其正式 E1。
- 处理：放宽首动作，接受 E1；在下一步优先核对服务端工具结果与模型可见反馈。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
