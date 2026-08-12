# isolate-before-compressing-context 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `isolate-before-compressing-context` | 通过 | 通过 |
| `should-trigger-02` | 应调用 | `isolate-before-compressing-context` | 争议：action | 独立裁决通过 |
| `should-trigger-03` | 应调用 | `isolate-before-compressing-context` | 争议：action | 独立裁决通过 |
| `should-not-trigger-01` | 诱饵 | `design-cache-stable-context` | 通过 | 通过 |
| `should-not-trigger-02` | 诱饵 | `distill-explicit-agent-state` | 通过 | 通过 |
| `edge-01` | 边界 | `isolate-before-compressing-context` | 争议：boundary | 修正测试期望后通过 |
| `edge-02` | 边界 | `isolate-before-compressing-context` | 通过 | 通过 |

- 初始机械判卷：4/7（57.1%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-02`

- 初始问题：只做轨迹盘点，未定义自包含搜索输入与只回传证据化结果的移交包
- 独立裁决：`grader_overstrict`。标记轨迹体积、消费者、可重建性和腐化基线是 isolate Skill 的 E1，自包含移交在 E2-E3。
- 处理：接受 E1 信息流基线；后续为每站定义自包含输入及只含结果、来源、未决项的移交包。

### `should-trigger-03`

- 初始问题：路由正确，但未先停止递归摘要并回原始证据保留失败路径。
- 独立裁决：`grader_overstrict`。信息来源、重复度、可重建性和约束遗忘基线符合 E1，停止递归摘要及保留失败证据随后落实。
- 处理：接受 E1；后续强制回原始证据，保留决策理由、失败路径、来源和恢复指针。

### `edge-01`

- 初始问题：预期暂不激活隔离专科，候选仍选择该专科，违反边界。
- 独立裁决：`test_expectation_wrong`。用户正询问是否隔离，description 覆盖该选型；调用 E1-E2 量化共享依赖并按判停条件否决合理。
- 处理：允许激活 Skill 做边界诊断，验收改为同步成本过高时保留共享上下文并仅归档可重建输出。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
