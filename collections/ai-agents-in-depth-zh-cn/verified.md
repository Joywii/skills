# 阶段 1.5 三重验证结果

> 输入池：30 个框架候选与 100 条原则候选。语义聚类后保留 22 个独立方法单元；103 个候选被吸收，5 个候选未通过，原始候选通过率为 16.9%。每个保留单元均通过 V1/V2/V3。`source_quote` 每条均少于 150 字，案例、反例与术语只作为证据和边界。

---
id: v01
title: "观察-策略-动作-反馈四面诊断"
type: framework
suggested_slug: "diagnose-agent-boundaries"
source_candidates: [f01, f02]
scope: "诊断 Agent 是看不见、不会选、做不了，还是动作结果没有回到下一轮；不把所有失败笼统归因于模型能力。"
source_chapters: ["第 1 章 1.1-1.2", "第 9 章 9.2-9.3"]
source_quote: "没有通过观察通道进入上下文的信息，对模型来说就像不存在；没有被动作接口允许的操作，也只能停留在文字建议上。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 1 章 c001：搜索/工具任务分别移除定义、结果、思考和历史，暴露观察、策略与反馈断点。"
    - "第 9 章 c091：机器人同一任务按感知、规划、执行和复查分层定位故障，验证对象从文本工具换成物理控制。"
V2_predictive_power:
  passed: true
  novel_question: "采购 Agent 明知另一供应商更便宜却没有切换，应先换更强模型吗？"
  derived_answer: "先核对报价是否进入上下文、策略是否允许比较、切换接口及权限是否存在、切换结果是否回写；只有前三项完备而决策仍错时才把问题归到模型策略。"
V3_exclusivity:
  passed: true
  why_not_common: "常识只会说‘查日志或换模型’；本方法把可解性拆成观察空间、策略、动作空间和闭环反馈四个可独立证伪的因果槽。"
supporting_cases: [c001, c091]
supporting_counter_examples: [ce003, ce040, ce055]
supporting_terms: [g01, g02, g03, g04, g05, g07]
tags: [architecture, diagnosis, observation-space, action-space, feedback-loop]
status: verified

---
id: v02
title: "按动态性与可验证性分配自治"
type: decision-framework
suggested_slug: "choose-agent-autonomy"
source_candidates: [f03, f15, PR-006, PR-008]
scope: "在单次调用、确定性工作流和自主 Agent 间选型，并决定可授予的自治程度。"
source_chapters: ["第 1 章 1.2.3-1.2.5", "第 3 章 3.3.4", "第 5 章 5.1.4", "第 10 章 10.2"]
source_quote: "对于可以清晰分解为固定子任务的场景，考虑使用工作流；只有当需要动态决策和灵活的执行路径时，才使用自主 Agent。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 3 章 c021：司法问答只在复杂多跳检索中让 Agent 迭代探索，简单查询不支付自主循环成本。"
    - "第 6 章 c055：AndroidWorld 先诊断目标与验证缺口，再分阶段增加 Harness，而非直接提高自治。"
V2_predictive_power:
  passed: true
  novel_question: "月度报销流程规则固定，但偶尔遇到无法枚举的境外票据，应整体改成自主 Agent 吗？"
  derived_answer: "保留固定工作流处理常规路径，只把异常分类和材料补全交给受限 Agent；无法自动验真的报销决定仍交人工，因此动态性只扩大局部自治。"
V3_exclusivity:
  passed: true
  why_not_common: "不是泛泛的‘保持简单’，而是用执行路径动态性与结果验证自动化两轴决定架构和自治预算。"
supporting_cases: [c021, c055]
supporting_counter_examples: [ce001, ce054]
supporting_terms: [g01, g07, g14]
tags: [orchestration, autonomy, workflow, verification, complexity]
status: verified

---
id: v03
title: "稳定前缀-动态后缀上下文布局"
type: framework
suggested_slug: "design-cache-stable-context"
source_candidates: [f04, PR-011, PR-012, PR-013, PR-014]
scope: "按变化频率布局系统提示、工具定义、状态和新观察，同时优化注意力位置与 KV Cache。"
source_chapters: ["第 2 章 2.3", "第 4 章 4.8.1"]
source_quote: "动态信息永远追加到末尾——时间戳、用户状态等变化的内容，作为新消息追加到对话末尾，而不是修改已有的系统提示词。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 2 章 c006：时间戳、工具重排和滑窗分别破坏缓存与任务状态，证明布局具有系统效应。"
    - "第 4 章 c032：120+ 工具按需发现后把 schema 固定追加在原位置，兼顾能力发现和缓存稳定。"
V2_predictive_power:
  passed: true
  novel_question: "客服系统每轮都更新会员等级，怎样避免个性化信息让所有请求失去前缀缓存？"
  derived_answer: "稳定规则和确定性排序的工具 schema 保持字节不变；会员状态作为带版本的末尾消息追加，只在命中时追加临时能力定义。"
V3_exclusivity:
  passed: true
  why_not_common: "常识按语义组织提示；本方法把 token 前缀的字节一致性视为架构约束，并把注意力边缘与缓存边界统一设计。"
supporting_cases: [c006, c032]
supporting_counter_examples: [ce008, ce009, ce020]
supporting_terms: [g03, g08]
tags: [context-engineering, kv-cache, stable-prefix, latency, cost]
status: verified

---
id: v04
title: "能力缺口驱动的渐进式披露"
type: framework
suggested_slug: "progressively-disclose-capabilities"
source_candidates: [f05, f14, PR-017, PR-038]
scope: "为大型 Skill、工具和操作手册设计元数据常驻、核心流程命中加载、细节按需读取的能力路由。"
source_chapters: ["第 2 章 2.5", "第 4 章 4.8"]
source_quote: "先给 Agent 看一份目录摘要，需要时再加载完整内容。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 2 章 c009：PPTX Skill 只在任务命中后加载正文和参考资产。"
    - "第 4 章 c032：小模型面对 120+ 工具时先声明能力缺口，再分层匹配并注入 schema。"
V2_predictive_power:
  passed: true
  novel_question: "医院助理有 500 套科室规程，启动时应该把所有规程放入系统提示吗？"
  derived_answer: "常驻科室、触发条件和风险级别目录；命中后加载该规程主流程，执行到具体检查时再读表单与模板，未命中则显式返回能力缺口。"
V3_exclusivity:
  passed: true
  why_not_common: "不是普通懒加载；触发元数据本身属于决策上下文，且运行中的能力缺口可以反向驱动分层发现。"
supporting_cases: [c009, c032]
supporting_counter_examples: [ce016, ce017, ce038, ce052]
supporting_terms: [g04, g09]
tags: [progressive-disclosure, skills, tool-discovery, routing, context-budget]
status: verified

---
id: v05
title: "可审计的显式状态蒸馏"
type: framework
suggested_slug: "distill-explicit-agent-state"
source_candidates: [f06, PR-020]
scope: "用确定性代码把长轨迹中的进度、计数、锁、待办和异常蒸馏为末尾状态栏，同时保留原始证据。"
source_chapters: ["第 2 章 2.6", "第 4 章 4.7"]
source_quote: "这种机制的本质是把分散在上下文各处的隐式状态提炼为可直接使用的显式知识。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 2 章 c011：代码维护的状态栏让长客服轨迹中的统计变成常量查询，并显著提升弱模型准确率。"
    - "第 4 章 c031：可打断异步 Agent 必须显式记录 pending 任务与事件，防止占位符被当作真实完成。"
V2_predictive_power:
  passed: true
  novel_question: "数据迁移 Agent 需要跨数小时跟踪 300 个分片，怎样避免每轮重读日志？"
  derived_answer: "由运行时维护分片状态、重试数、锁和校验摘要并注入末尾；模型据此决策，异常时仍可回到不可变日志复核。"
V3_exclusivity:
  passed: true
  why_not_common: "状态栏不是摘要提示，而是确定性维护、模型高度信任但可回溯原轨迹的有损投影；其准确率本身是生产指标。"
supporting_cases: [c011, c031]
supporting_counter_examples: [ce018, ce019, ce020, ce050]
supporting_terms: [g03, g06, g10]
tags: [state-management, status-bar, context-distillation, auditability, async]
status: verified

---
id: v06
title: "隔离优先、压缩兜底的上下文治理"
type: framework
suggested_slug: "isolate-before-compressing-context"
source_candidates: [f07, PR-021, PR-022, PR-023, PR-045]
scope: "治理长任务上下文：先隔离高噪声子任务，仅在不能隔离时分层压缩，并保留决策、失败与原始证据。"
source_chapters: ["第 2 章 2.7", "第 10 章 10.4"]
source_quote: "压缩是有损的、需要额外 LLM 调用的事后补救；隔离则让噪声从一开始就与主上下文绝缘。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 2 章 c012：六种压缩策略显示逐轮或碎片化摘要会破坏缓存并累积失真。"
    - "第 10 章 c096：十个网站的搜索轨迹彼此隔离，只把带证据的结果交给管理者，并支持级联终止。"
V2_predictive_power:
  passed: true
  novel_question: "并购尽调要同时阅读法律、财务与安全材料，主 Agent 应把全部中间笔记合并后压缩吗？"
  derived_answer: "按权限和主题隔离三个工作上下文，要求自包含的证据移交包；主上下文只保留决策与未决冲突，接近阈值时再批量压缩。"
V3_exclusivity:
  passed: true
  why_not_common: "常见做法先追求更好的摘要；本方法认为噪声未进入主上下文优于事后有损修复，并要求失败路径也作为高价值信息保留。"
supporting_cases: [c012, c096]
supporting_counter_examples: [ce010, ce021, ce022, ce023, ce024, ce025]
supporting_terms: [g06, g08, g27]
tags: [context-isolation, compression, provenance, handoff, context-rot]
status: verified

---
id: v07
title: "追加证据-派生视图的记忆与知识生命周期"
type: framework
suggested_slug: "build-evidence-backed-memory"
source_candidates: [f11, f08, PR-024, PR-025, PR-028, PR-031, PR-032, PR-083]
scope: "构建跨会话记忆和持续知识：原始事实追加且可追溯，结构化概览、摘要和索引均可重建。"
source_chapters: ["第 3 章 3.1-3.3", "第 8 章 8.2.1"]
source_quote: "事实追加到不可变日志，再周期性重建结构化用户模型"
V1_cross_domain:
  passed: true
  evidence:
    - "第 3 章 c022：少量结构化概览常驻，原始对话按需检索，兼顾跨会话关联与来源复核。"
    - "第 8 章 c075：多条 GAIA 轨迹交叉支持后才形成经验文档，知识视图不由单条总结直接发布。"
V2_predictive_power:
  passed: true
  novel_question: "医疗助理发现用户的新饮食偏好与半年前记录冲突，应直接覆盖旧记忆吗？"
  derived_answer: "追加带时间、主体和来源的新证据；在当前偏好视图中标记有效范围，保留旧版本供历史问题与冲突复核，索引可随时从证据重建。"
V3_exclusivity:
  passed: true
  why_not_common: "不是‘记住重要信息’，而是把不可变证据与可变检查点、概览和索引分层，避免摘要更新摘要造成代际漂移。"
supporting_cases: [c022, c075]
supporting_counter_examples: [ce026, ce027, ce028, ce034, ce035]
supporting_terms: [g06, g11, g21]
tags: [memory, knowledge-base, append-only, provenance, versioning]
status: verified

---
id: v08
title: "按问题几何选择固定检索或迭代探索"
type: decision-framework
suggested_slug: "choose-rag-retrieval-mode"
source_candidates: [f10, f09, PR-026, PR-027]
scope: "根据单跳、多跳、全库聚合和证据充分性，选择混合检索流水线、Agentic RAG 或结构化统计。"
source_chapters: ["第 1 章 1.1.5", "第 3 章 3.2-3.3"]
source_quote: "在“观察”到初步结果后不会立即生成答案。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 1 章 c003：Deep Research 在搜索结果不足时继续搜索并调用计算，行动由证据缺口驱动。"
    - "第 3 章 c018、c021：混合召回-重排解决单轮覆盖，司法多跳问题则需要 Agentic RAG 迭代补证。"
V2_predictive_power:
  passed: true
  novel_question: "审计员问‘所有子公司中有多少违反新政策’，能否直接向量 Top-k 后让模型计数？"
  derived_answer: "这是全库聚合而非相关文档检索；应先枚举或结构化统计全集，再对异常项用混合检索取证，Agent 只围绕证据缺口迭代并显式判断停止。"
V3_exclusivity:
  passed: true
  why_not_common: "不是‘多搜几次’，而是用查询几何决定控制权：Top-k 相关性、全集覆盖和多跳探索是三种不同问题，不能共享默认流水线。"
supporting_cases: [c003, c018, c021]
supporting_counter_examples: [ce029, ce030, ce031, ce032, ce033, ce037]
supporting_terms: [g03, g12]
tags: [rag, hybrid-retrieval, agentic-rag, aggregation, evidence-sufficiency]
status: verified

---
id: v09
title: "能力表达与执行信任边界"
type: framework
suggested_slug: "design-trusted-agent-tools"
source_candidates: [f12, PR-001, PR-002, PR-003, PR-004, PR-018, PR-019, PR-033, PR-034, PR-035, PR-036, PR-037, PR-039, PR-040, PR-052, PR-058, PR-060]
scope: "在 Skill、专用工具、通用执行器与代码之间分配能力，并把权限、参数、沙盒、供应链和副作用约束放到不可绕过的执行边界。"
source_chapters: ["第 1 章 1.1.2-1.2.6", "第 2 章 2.4-2.5", "第 4 章 4.2-4.5", "第 5 章 5.2"]
source_quote: "支付、删除数据、发送邮件和生产部署等高风险或强业务约束操作，仍应封装为参数明确、权限受限且全程可审计的专用工具，必要时再加上预览和人工确认。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 2 章 c008：外部内容、Skill 和系统指令分通道处理，组合防御把注入限制在数据域。"
    - "第 4 章 c028：执行服务器以专用接口、沙盒和自动验证约束真实副作用。"
    - "第 5 章 c043：权限内嵌到数据对象，动态代码也无法越权。"
V2_predictive_power:
  passed: true
  novel_question: "薪资 Agent 要解释规则、批量计算并更正一条工资记录，三种能力应如何表达？"
  derived_answer: "易变解释流程写 Skill，批量计算在受限代码沙盒执行，工资更正只能走最小权限专用工具并预览确认；读取时先按调用者权限过滤。"
V3_exclusivity:
  passed: true
  why_not_common: "独特处是拆开‘如何做’与‘能做什么’，并认定提示词、Skill 和第三方元数据都不是安全边界；高风险约束必须固化到动作接口。"
supporting_cases: [c008, c028, c035, c043]
supporting_counter_examples: [ce002, ce015, ce036, ce038, ce039, ce040, ce041, ce042, ce044, ce046, ce047, ce049, ce060, ce062]
supporting_terms: [g04, g07, g09, g13]
tags: [tool-design, skills, least-privilege, sandbox, supply-chain]
status: verified

---
id: v10
title: "异源提议者-审核者闭环"
type: framework
suggested_slug: "build-independent-review-loops"
source_candidates: [f13, PR-005, PR-029, PR-030, PR-042, PR-043, PR-098]
scope: "为高风险行动、知识更新和开放式产物建立读取独立证据、结构化退回并有预算上限的审核闭环。"
source_chapters: ["第 3 章 3.3.3", "第 4 章 4.5", "第 5 章 5.2.3", "第 8 章 8.2.5", "第 10 章 10.5.2"]
source_quote: "第一种机制是事前审批：在工具执行前，一个模型负责提议行动（Proposer），另一个独立的模型负责审查批准（Reviewer）。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 4 章 c027：Claude Code 的 Sidecar 只读结构化动作与权限元数据，在执行前独立审查。"
    - "第 5 章 c036：PPT 与讲解视频用渲染后的异模态产物复核，而非只审提议者文本。"
    - "第 8 章 c082：Hermes 的自更新必须经过外部审查才可发布。"
V2_predictive_power:
  passed: true
  novel_question: "同一模型连续两次认为财务预测表正确，能否视为双重验证？"
  derived_answer: "不能；Reviewer 应使用另一模型家族或公式执行器，从原始数据重算关键单元格，并把失败位置和修复条件结构化退回。"
V3_exclusivity:
  passed: true
  why_not_common: "常识是‘再检查一次’；本方法要求审核引入异源模型、异模态或环境真值，避免相关错误制造虚假共识。"
supporting_cases: [c027, c036, c082]
supporting_counter_examples: [ce045, ce046, ce066]
supporting_terms: [g06, g07, g14]
tags: [proposer-reviewer, independent-evidence, sidecar, safety, iteration]
status: verified

---
id: v11
title: "检测-恢复-终止故障闭环"
type: framework
suggested_slug: "engineer-agent-failure-closure"
source_candidates: [f16, PR-009, PR-044, PR-046, PR-053, PR-055, PR-056]
scope: "把 API、工具、上下文和控制流故障建模为可分类、可恢复且必有终止出口的状态机。"
source_chapters: ["第 4 章 4.5-4.7", "第 5 章 5.1.5", "第 10 章 10.4-10.5"]
source_quote: "检测靠‘错误分类 + 模式识别’，恢复靠‘分级升级’，终止靠‘熔断器 + 全局上限 + 人工升级’。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 5 章 c038：日志解析与生产轨迹按错误层级定位，并根据反馈改变恢复动作。"
    - "第 10 章 c096：并行网站搜索以首个已验证成功结算，并把取消沿子任务级联。"
    - "第 4 章 c031：异步邮件任务用事件与 pending 状态处理打断，而非盲重试。"
V2_predictive_power:
  passed: true
  novel_question: "下单接口超时但可能已扣款，Agent 是否应立即重试？"
  derived_answer: "先分类为提交状态不明；用幂等键或状态查询恢复，不能原样重放；重复指纹触发熔断，最终转人工并保留任务状态。"
V3_exclusivity:
  passed: true
  why_not_common: "不是一般的重试建议；它把错误分类、改变请求、幂等语义、进展检测、预算和取消传播组成闭合状态机。"
supporting_cases: [c031, c038, c096]
supporting_counter_examples: [ce005, ce048, ce050, ce051, ce055, ce056, ce058, ce059, ce080]
supporting_terms: [g05, g06, g26]
tags: [fault-tolerance, retry, idempotency, circuit-breaker, termination]
status: verified

---
id: v12
title: "自然语言理解-形式化-执行验证分工"
type: framework
suggested_slug: "formalize-and-verify-agent-work"
source_candidates: [f17, PR-015, PR-051, PR-059, PR-085]
scope: "让 LLM 负责语义理解和结构抽取，把精确规则转成代码或约束，由确定性执行器计算并用外部结果验收。"
source_chapters: ["第 3 章 3.3", "第 5 章 5.1-5.2", "第 8 章 8.2.3"]
source_quote: "让 LLM 负责理解用户的自然语言问题，识别其中的数学或逻辑结构，并转化为形式化语言。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 3 章 c019：自然语言知识被抽象为可复用统计与业务规则，而不是交给模型临场猜测。"
    - "第 5 章 c034：模型把数学和逻辑问题转成代码，由运行结果纠正口头推导。"
    - "第 8 章 c078：PreAct 把浏览器轨迹编译成含前后状态检查的可验证工作流。"
V2_predictive_power:
  passed: true
  novel_question: "跨地区税务条款互相引用，如何让 Agent 计算最终应缴额而不靠口算？"
  derived_answer: "LLM 提取主体、时段、变量和例外，生成可审查的约束或代码；执行器求值并验证守恒与边界，失败信息再回到模型修正规则映射。"
V3_exclusivity:
  passed: true
  why_not_common: "关键不是‘让 AI 写代码’，而是把语义歧义和确定性求值分给不同组件，模型负责表示转换但不充当最终真值。"
supporting_cases: [c019, c034, c078]
supporting_counter_examples: [ce012, ce013, ce055, ce061, ce062]
supporting_terms: [g07, g13]
tags: [formalization, code-as-reasoning, deterministic-verification, workflow]
status: verified

---
id: v13
title: "能力上限与连续可靠性双指标"
type: evaluation-framework
suggested_slug: "measure-capability-vs-reliability"
source_candidates: [f18, PR-062]
scope: "区分多次尝试至少一次成功的能力上限与连续多次均成功的业务可靠性，并按风险选择指标。"
source_chapters: ["第 6 章 6.2", "第 8 章 8.3.3"]
source_quote: "前一个数字适合衡量探索时的能力天花板，后一个数字才接近支付、退款、权限变更、生产部署等场景的可靠性要求。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 6 章 c047：六类 Agent 基准揭示重复采样的能力上限与单次任务稳定性不是同一结论。"
    - "第 8 章 c085：四次自主科研只有一次走完全流程，证明偶尔成功不能代表可持续闭环。"
V2_predictive_power:
  passed: true
  novel_question: "欺诈申诉 Agent 单次成功率 80%，Pass@5 已接近 100%，是否可连续处理十个账户？"
  derived_answer: "不能；Pass@5 说明允许重试时容易至少成功一次，但连续十次全成功约为 0.8^10=10.7%，生产风险应按 Pass^k 判断。"
V3_exclusivity:
  passed: true
  why_not_common: "普通准确率把探索与可靠性混为一谈；本方法用相反方向的指数聚合揭示同一单次成功率在两类业务中的相反含义。"
supporting_cases: [c047, c085]
supporting_counter_examples: [ce064, ce070, ce072]
supporting_terms: [g14, g15, g16]
tags: [evaluation, pass-at-k, pass-power-k, reliability, risk]
status: verified

---
id: v14
title: "可重置环境中的结果-过程-质量三层评估"
type: evaluation-framework
suggested_slug: "build-reproducible-agent-evals"
source_candidates: [f19, f24, PR-010, PR-061, PR-063, PR-064, PR-065, PR-066, PR-067, PR-078, PR-080, PR-081]
scope: "构建包含数据集、可重置环境、原子工具、验证器和交互协议的评估循环，并依次验证真实结果、允许路径与软质量。"
source_chapters: ["第 6 章 6.1-6.5", "第 7 章 7.11", "第 8 章 8.1"]
source_quote: "结果与过程是硬门，只有都通过时，语言质量才有资格决定候选是否值得学习。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 6 章 c046：τ²-bench 同时控制用户与工具环境，以可重置隐藏状态验证任务结果。"
    - "第 8 章 c074：客服轨迹验证器分别输出结果、过程和质量证据，而不是压成单一总分。"
V2_predictive_power:
  passed: true
  novel_question: "邮件分拣 Agent 回复语气很好但把附件发错人，LLM Judge 给高分时应如何处理？"
  derived_answer: "在可重置邮箱中用隐藏收件人状态验证结果，用权限与动作序列作过程 veto；两项通过后才让 Judge 评价语气，并用人工金标校准。"
V3_exclusivity:
  passed: true
  why_not_common: "不是‘多测几个指标’，而是把环境真值和允许路径设为不可被平均分抵消的硬门，软质量只能在其上层评分。"
supporting_cases: [c045, c046, c074]
supporting_counter_examples: [ce006, ce007, ce055, ce065, ce066, ce067, ce068, ce073, ce079, ce083, ce084]
supporting_terms: [g06, g14, g20]
tags: [evaluation-environment, outcome, process, quality, veto]
status: verified

---
id: v15
title: "首个因果错误驱动的配对改进"
type: framework
suggested_slug: "attribute-first-errors"
source_candidates: [f20, f21, PR-007, PR-068, PR-069, PR-070]
scope: "从失败轨迹定位首个致偏动作，冻结其前缀形成局部回归，每轮只改一个变量并保留端到端回归。"
source_chapters: ["第 5 章 5.2.4", "第 6 章 6.5-6.10", "第 7 章 7.13"]
source_quote: "归因对象是轨迹中的首个导致任务偏离的错误，后续错误往往只是连锁反应。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 5 章 c038：生产轨迹诊断从日志中还原最早异常，而非把最终报错当根因。"
    - "第 6 章 c055：AndroidWorld 按失败簇提出假设、单变量修改并以固定任务做分阶段回归。"
    - "第 7 章 c073：生产 bad case 被定位到具体决策边界后再选择后训练样本。"
V2_predictive_power:
  passed: true
  novel_question: "订票 Agent 最终因 API 限流失败，但用户被重复扣款，根因是否是限流？"
  derived_answer: "回放寻找首个不可接受分叉，通常是第一次超时后无幂等核查就重试；冻结此前轨迹做前缀回归，只修改恢复策略，再跑端到端检查副作用。"
V3_exclusivity:
  passed: true
  why_not_common: "常规调试追最后异常；本方法把首个因果分叉作为归因对象，并用轨迹前缀与端到端两层回归分离定位精度和系统保护。"
supporting_cases: [c038, c055, c073]
supporting_counter_examples: [ce069, ce070, ce071, ce072, ce080, ce085, ce089]
supporting_terms: [g06, g17, g18]
tags: [failure-attribution, first-error, trajectory-prefix, paired-experiment, regression]
status: verified

---
id: v16
title: "先外部修复、再 SFT 固形、后 RL 塑策"
type: decision-framework
suggested_slug: "choose-sft-or-rl"
source_candidates: [f22, PR-071, PR-072, PR-073, PR-074, PR-075, PR-076]
scope: "在 Prompt、上下文、工具、SFT 与 RL 之间选择最小修复；需要训练时按格式稳定性、探索需求和奖励可靠性排序。"
source_chapters: ["第 2 章 2.4", "第 7 章 7.4-7.10", "第 8 章 8.2.2"]
source_quote: "SFT 先把‘形’（格式、结构）立起来，RL 再追求‘神’（策略、泛化），即先形后神。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 2 章 c007：航空客服先通过提示流程与规则消融修复外部 Harness，不需要立刻训练模型。"
    - "第 7 章 c066：GeneralPoints 对照显示 SFT 更易记住示范表面，RL 才在可验证反馈下获得策略泛化。"
    - "第 8 章 c076：生产失败先生成带来源的最小 Prompt 补丁，而非默认写入参数。"
V2_predictive_power:
  passed: true
  novel_question: "模型已稳定输出合法 JSON，但陌生任务中的行动选择差，应继续追加 SFT 示例吗？"
  derived_answer: "先验证工具和上下文能否修复；若问题确属隐式策略且奖励可信，格式已稳定可跳过冷启动 SFT，直接小规模 RL 并用独立保留集验证泛化。"
V3_exclusivity:
  passed: true
  why_not_common: "不是笼统的训练选型，而是先问能力能否在模型外表达，再用可解析性作为 SFT/RL 顺序门槛，避免用训练吸收工程问题。"
supporting_cases: [c007, c066, c076]
supporting_counter_examples: [ce074, ce075, ce076, ce077, ce078]
supporting_terms: [g07, g19, g20]
tags: [post-training, harness-first, sft, reinforcement-learning, generalization]
status: verified

---
id: v17
title: "可验证奖励与违规路径联合门控"
type: framework
suggested_slug: "design-verifiable-agent-rewards"
source_candidates: [f23, PR-077, PR-079]
scope: "按来源、时机、信息量和路径四问设计奖励；先可靠结果奖励，只给可验证中间事件加过程信号，并独立惩罚违规捷径。"
source_chapters: ["第 5 章 5.1.4", "第 7 章 7.11", "第 8 章 8.1"]
source_quote: "工程上可以先用结果奖励建立可靠基线，再只为真正可验证的中间事件加入过程信号。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 5 章 c035：航空政策被代码化为可执行约束，小模型不能靠口头解释绕过规则。"
    - "第 7 章 c071：RL VP 同时奖励结果并惩罚可验证的违规路径，堵住破坏性捷径。"
    - "第 8 章 c074：轨迹验证器把环境结果和过程证据分层输出，供学习信号筛选。"
V2_predictive_power:
  passed: true
  novel_question: "仓储 Agent 为缩短时长绕过安全扫描仍按时出库，应得到高奖励吗？"
  derived_answer: "出库隐藏状态只能给结果分；安全扫描记录是独立路径硬门，违规即否决。只有可确定验证的中间扫描事件才提供稠密过程信号。"
V3_exclusivity:
  passed: true
  why_not_common: "常识说‘奖励正确行为’；本方法明确奖励的可验证来源、时间密度与路径 veto，承认成功代理指标会被策略主动钻空子。"
supporting_cases: [c035, c071, c074]
supporting_counter_examples: [ce055, ce078, ce079]
supporting_terms: [g06, g20]
tags: [reward-design, verifiable-reward, process-signal, reward-hacking, veto]
status: verified

---
id: v18
title: "知识-指令-程序-参数四载体路由"
type: decision-framework
suggested_slug: "route-agent-updates"
source_candidates: [f25, PR-082, PR-084]
scope: "按经验的表示、编辑、验证和撤销性质，把生产改进写入知识、Prompt/Skill、程序/Harness 或模型参数。"
source_chapters: ["第 3 章 3.3.6", "第 5 章 5.2.2", "第 7 章 7.4", "第 8 章 8.2"]
source_quote: "选择更新方式的首要依据不是经验出现了多久，而是目标能力能否被某种载体自然表达。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 3 章 c024：司法判例中的可追溯经验被提炼为知识。"
    - "第 5 章 c035：确定性航空政策被固化为程序约束。"
    - "第 7 章 c061：难以用外部规则表达的音色与副语言协议通过 SFT 写入参数。"
    - "第 8 章 c076：可语言化的客服判断只生成最小 Prompt 补丁。"
V2_predictive_power:
  passed: true
  novel_question: "税率更新、审批惯例、安全上限和口音识别退化，应否都通过微调修复？"
  derived_answer: "税率进可版本化知识，审批惯例进 Skill，安全上限进不可绕过程序，口音感知才考虑参数；每项分别验证和回滚。"
V3_exclusivity:
  passed: true
  why_not_common: "不是按数据多少选技术，而是按载体能否引用、局部编辑、强制执行和精确撤销路由；参数只是最后一种分布式存储。"
supporting_cases: [c024, c035, c061, c076]
supporting_counter_examples: [ce034, ce063, ce076, ce086, ce090]
supporting_terms: [g09, g13, g21, g22]
tags: [continuous-learning, knowledge, skill, harness, parameters]
status: verified

---
id: v19
title: "在线执行-离线进化与可信根"
type: framework
suggested_slug: "govern-continuous-agent-evolution"
source_candidates: [f26, PR-086, PR-087, PR-088]
scope: "把真实任务执行与系统修改分成双循环，用边界、保留、安全三类 veto、灰度和回滚治理更新，并禁止修改审批自身的可信根。"
source_chapters: ["第 3 章 3.3.3", "第 6 章 6.5-6.9", "第 8 章 8.3"]
source_quote: "在线执行循环只完成任务并记录证据，不直接改写正式 Agent；离线进化循环聚合轨迹、诊断根因、生成更新提案，再通过验证门槛发布新版本。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 3 章知识更新：模型不得绕过审核直接改主分支或线上索引，派生物可由已审核来源重建。"
    - "第 8 章 c082：Hermes 只能在外部审查下升级自己；验证器与稳定版本不属于可修改对象。"
    - "第 8 章 c084：只保存反馈不等于持续进化，更新必须经过验证、发布和回滚。"
V2_predictive_power:
  passed: true
  novel_question: "客服 Agent 收到一条愤怒反馈后，能否立即重写自己的退款 Skill 并继续服务？"
  derived_answer: "在线只追加轨迹与反馈；离线聚合同类根因并生成最小补丁，分别通过触发边界、旧能力保留和安全集，再灰度发布，退化即回滚。"
V3_exclusivity:
  passed: true
  why_not_common: "常识是‘从反馈学习’；本方法禁止生产执行器直接改正式版本，并把批准器、测试、日志和备份定义为不可自改的可信根。"
supporting_cases: [c082, c084]
supporting_counter_examples: [ce081, ce082, ce083, ce085, ce086, ce087, ce089, ce090, ce091]
supporting_terms: [g06, g21, g22]
tags: [continuous-evolution, online-offline, trusted-root, canary, rollback]
status: verified

---
id: v20
title: "实时交互架构与可撤销提交边界"
type: decision-framework
suggested_slug: "design-realtime-agent-interactions"
source_candidates: [f27, PR-047, PR-048, PR-050, PR-089]
scope: "在级联、端到端和全双工架构间取舍，并为 partial、final、异步事件和副作用定义安全消费点、提交与取消语义。"
source_chapters: ["第 4 章 4.7", "第 9 章 9.1"]
source_quote: "它们不是简单的新旧替代，而是不同延迟、成本和可观测性约束下的取舍。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 4 章 c031：邮件事件从串行轮询改成可打断异步运行，启动、pending、完成和取消必须分离。"
    - "第 9 章 c086-c088：语音级联、端到端和自级联各有延迟、模态信息与可观测性边界，不存在单向替代。"
V2_predictive_power:
  passed: true
  novel_question: "实时口译 Agent 收到半句识别结果时，可以先发出会议邀请吗？"
  derived_answer: "partial 只可触发可撤销的联系人预取；邀请属于外部副作用，必须等待 final 转录和明确提交点，修订时取消未提交后台任务。"
V3_exclusivity:
  passed: true
  why_not_common: "不是单纯追求低延迟；本方法把流式 token 的认识状态与动作可撤销性绑定，并用提交边界管理前台、后台和外部世界。"
supporting_cases: [c031, c086, c087, c088]
supporting_counter_examples: [ce050, ce051, ce057, ce092, ce093, ce094, ce095, ce096]
supporting_terms: [g05, g23]
tags: [realtime, async, streaming, commit-boundary, cancellation]
status: verified

---
id: v21
title: "多时间尺度的感知-规划-技能-控制闭环"
type: framework
suggested_slug: "build-multiscale-action-loops"
source_candidates: [f28, PR-090, PR-091, PR-092, PR-093, PR-094]
scope: "为 GUI、机器人和其他持续环境分离高层目标、长程规划、原子技能与低层控制；每个动作块后重新观察和验证。"
source_chapters: ["第 1 章 1.1.5", "第 5 章 5.1", "第 9 章 9.2-9.3"]
source_quote: "无论采用哪种实现，都应该把“任务顺序”和“眼前动作”分开。"
V1_cross_domain:
  passed: true
  evidence:
    - "第 5 章 c033：Coding Agent 的编辑只是候选动作，测试通过而非代码写完才是完成。"
    - "第 9 章 c090：Computer Use 遇验证码后重新观察并改道，不能按旧画面盲执行。"
    - "第 9 章 c091：机器人用五阶段闭环区分任务规划、技能和高频控制。"
V2_predictive_power:
  passed: true
  novel_question: "仓库盘点无人机应让一个 LLM 一次生成整段飞行轨迹吗？"
  derived_answer: "高层只排货架顺序，技能层执行固定范围扫描，低层控制保持稳定；每个动作块后用新传感器观察验收，局部失败只重规划受影响段。"
V3_exclusivity:
  passed: true
  why_not_common: "不是泛泛的‘边做边看’，而是按时间尺度限制每层动作空间，并把动作块视为等待真实环境证伪的假设。"
supporting_cases: [c033, c090, c091]
supporting_counter_examples: [ce003, ce043, ce055, ce097, ce098, ce099, ce100, ce101, ce102, ce103, ce104]
supporting_terms: [g05, g23, g24]
tags: [interaction, robotics, computer-use, hierarchical-control, closed-loop]
status: verified

---
id: v22
title: "信息增量优先的多 Agent 协作设计"
type: decision-framework
suggested_slug: "design-multi-agent-collaboration"
source_candidates: [f30, f29, PR-095, PR-096, PR-097, PR-099, PR-100]
scope: "先证明多 Agent 带来独立观察、验证、权限或并行结果，再选择共享/隔离上下文与对等/管理者/移交拓扑。"
source_chapters: ["第 2 章 2.7.7", "第 5 章 5.2.3", "第 10 章 10.1-10.5"]
source_quote: "核心判据只有一条：协作过程是否引入了单个 Agent 在生成时无法获得的新信息？"
V1_cross_domain:
  passed: true
  evidence:
    - "第 5 章 c036：视频审核者看到渲染产物这一新模态，协作不是围绕同一文本重复思考。"
    - "第 10 章 c095：电话与电脑 Agent 通过不同通道并行取得表单所需信息，再由管理者汇合。"
    - "第 10 章 c100：狼人杀按角色隔离信息和权限，证明上下文边界会改变协作正确性。"
V2_predictive_power:
  passed: true
  novel_question: "让三个 Agent 阅读同一政策并投票，是否天然优于一个 Agent？"
  derived_answer: "若三者没有独立工具、数据或验证信号，投票只是相关误差的重复计算，应保留单 Agent；若财务数据需独立权限获取，再用管理者和结构化证据包汇合。"
V3_exclusivity:
  passed: true
  why_not_common: "常识把角色数量当协作强度；本方法先核算不可由单 Agent 获得的信息增量，再由上下文共享度和控制拓扑决定通信、权限与终止。"
supporting_cases: [c036, c095, c096, c100]
supporting_counter_examples: [ce025, ce045, ce055, ce105, ce106, ce107, ce108, ce109, ce110, ce111, ce112, ce113, ce114]
supporting_terms: [g25, g26, g27]
tags: [multi-agent, information-gain, topology, context-isolation, handoff]
status: verified
