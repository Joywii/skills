# diagnose-agent-boundaries 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `diagnose-agent-boundaries` | 争议：action | 独立裁决通过 |
| `should-trigger-02` | 应调用 | `diagnose-agent-boundaries` | 争议：action | 独立裁决通过 |
| `should-trigger-03` | 应调用 | `diagnose-agent-boundaries` | 通过 | 通过 |
| `should-not-trigger-01` | 诱饵 | `choose-agent-autonomy` | 通过 | 通过 |
| `should-not-trigger-02` | 诱饵 | `attribute-first-errors` | 争议：action | 独立裁决通过 |
| `edge-01` | 边界 | `none` | 通过 | 通过 |
| `edge-02` | 边界 | `none` | 通过 | 通过 |

- 初始机械判卷：4/7（57.1%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-01`

- 初始问题：仅冻结材料，未按观察、策略、动作、反馈核对首个断点
- 独立裁决：`grader_overstrict`。冻结失败样本、工具日志、最终状态和外部完成断言正是 diagnose-agent-boundaries 的 E1。
- 处理：接受 E1 证据冻结；后续再逐面定位 observation、policy、action、feedback 的首断点。

### `should-trigger-02`

- 初始问题：路由正确，但未先对齐服务端结果与模型下一轮可见反馈。
- 独立裁决：`grader_overstrict`。完整轨迹、工具日志、最终状态和完成断言构成正式 E1；反馈对齐是后续 E5 的针对性审计。
- 处理：接受 E1 为首动作，后续优先对齐服务端日志、task_id 与模型下一轮可见内容。

### `should-not-trigger-02`

- 初始问题：兄弟路由正确，但未冻结第7步前缀并仅替换首错候选。
- 独立裁决：`grader_overstrict`。attribute-first-errors 的 E1 要先冻结完整轨迹、环境、工具状态与版本，前缀配对是 E5-E6。
- 处理：接受证据包先行；后续断言冻结第 7 步前缀并只替换首错候选。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
