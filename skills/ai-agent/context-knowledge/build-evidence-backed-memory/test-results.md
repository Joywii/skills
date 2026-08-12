# build-evidence-backed-memory 压力测试结果

> 测试日期：2026-08-12｜格式：darwin-compatible｜最终结论：通过

## 方法

- 全包 22 个 Skills 共 154 条 prompt；本 Skill 7 条：3 条应调用、2 条诱饵、2 条边界。
- 全新盲测 Agent 只先读取全包的 `name + description`，选择路由后才读取所选 `SKILL.md` 并给出首个动作；测试类型、期望和备注全程隐藏。
- 三名独立判卷 Agent 交叉判卷；51 条争议另由未参与生成和判卷的 Agent 裁决。真实动作失败修改 E/B 执行约束后，再由新的盲测 Agent 复测。

## 结果

| 用例 | 类型 | 盲测路由 | 初始判定 | 最终判定 |
|---|---|---|---|---|
| `should-trigger-01` | 应调用 | `build-evidence-backed-memory` | 争议：action | 独立裁决通过 |
| `should-trigger-02` | 应调用 | `build-evidence-backed-memory` | 争议：action | 独立裁决通过 |
| `should-trigger-03` | 应调用 | `build-evidence-backed-memory` | 通过 | 通过 |
| `should-not-trigger-01` | 诱饵 | `distill-explicit-agent-state` | 通过 | 通过 |
| `should-not-trigger-02` | 诱饵 | `choose-rag-retrieval-mode` | 通过 | 通过 |
| `edge-01` | 边界 | `build-evidence-backed-memory` | 通过 | 通过 |
| `edge-02` | 边界 | `build-evidence-backed-memory` | 争议：action | 独立裁决通过 |

- 初始机械判卷：4/7（57.1%）。
- 最终有效通过：7/7（100%）；诱饵测试：2/2。
- 全包路由选择在初测即 154/154 合理；本报告的回炉只处理执行顺序与测试边界，不通过扩大 `description` 掩盖失败。

## 争议与回炉

### `should-trigger-01`

- 初始问题：未先保存两条带来源、时间和范围的证据，也未明确暂不覆盖
- 独立裁决：`grader_overstrict`。记忆 Skill 的 E1 明确先定义用途、保留期、隐私和删除权，追加原子证据是 E2。
- 处理：首动作允许先完成记忆对象和保留边界；后续断言两条证据追加且不破坏性覆盖。

### `should-trigger-02`

- 初始问题：路由正确，但未先恢复原始证据并把现有摘要标为派生视图。
- 独立裁决：`grader_overstrict`。先定义知识对象及保留、隐私、删除边界符合正式 E1，恢复真源和派生视图应随后实施。
- 处理：按正式顺序接受 E1；将原始证据登记和派生视图可重建性列为后续必检项。

### `edge-02`

- 初始问题：未比较地域、主体和有效范围，也未提出分别追加与范围化当前视图
- 独立裁决：`grader_overstrict`。首动作覆盖记忆对象、适用范围、来源和保留边界，符合 E1，冲突与时间建模在 E4。
- 处理：接受 E1 先行；后续要求判定并存或替代关系，并按地域、主体生成范围化视图。

## 验收

该 Skill 达到 `minimum_pass_rate: 0.8`，且全部诱饵测试通过，可进入交付阶段。
