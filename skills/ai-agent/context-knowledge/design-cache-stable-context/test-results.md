# design-cache-stable-context 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `design-cache-stable-context` | 通过 | 通过 |
| `should-trigger-02` | 应调用 | `design-cache-stable-context` | 通过 | 通过 |
| `should-trigger-03` | 应调用 | `design-cache-stable-context` | 争议：action | 独立裁决通过 |
| `should-not-trigger-01` | 诱饵 | `isolate-before-compressing-context` | 争议：action | 独立裁决通过 |
| `should-not-trigger-02` | 诱饵 | `distill-explicit-agent-state` | 通过 | 通过 |
| `edge-01` | 边界 | `none` | 争议：action | 修正测试期望后通过 |
| `edge-02` | 边界 | `design-cache-stable-context` | 通过 | 通过 |

- 初始机械判卷：4/7（57.1%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-03`

- 初始问题：只收集缓存基线，未设计稳定目录前缀和按需详情动态后缀
- 独立裁决：`grader_overstrict`。保存连续消息、前缀哈希、命中率、TTFT和成本是 cache Skill 的完整 E1。
- 处理：接受序列化基线先行；后续再要求稳定目录前缀、动态后缀及禁止中部插入。

### `should-not-trigger-01`

- 初始问题：兄弟路由正确，但未先识别可隔离噪声和必须保留的失败证据。
- 独立裁决：`grader_overstrict`。记录来源体积、重复度、消费者和行为退化基线正是 isolate-before-compressing-context 的 E1。
- 处理：接受信息流基线为首动作；后续再识别隔离候选、强制保留失败证据并验收可继续性。

### `edge-01`

- 初始问题：边界选择正确，但未按预期先测量可复用比例、命中能力和实际收益
- 独立裁决：`test_expectation_wrong`。短请求、低频且供应商无缓存收益已满足 description/B 的不调用条件，无须再以专科流程测缓存收益。
- 处理：删去强制测量的首动作预期；保留不激活专科、维持简单清晰布局即可。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
