# 框架候选

- id: f01
  title: "Agent 三层边界诊断"
  type: framework
  source_chapter: "第 1 章 1.1、1.1.1；第 1 章 1.2"
  source_quote: |
    "没有通过观察通道进入上下文的信息，对模型来说就像不存在；没有被动作接口允许的操作，模型即使知道该怎么做，也只能停留在文字建议上。"
  summary: |
    把 Agent 拆成模型策略、上下文观察和工具动作三个基本面。
    先判断失败源于模型不会决策，还是必要信息根本没有进入上下文。
    再检查系统是否缺少完成任务所需的动作接口或权限。
    对生产问题继续沿 Harness 的约束、验证、纠正三层寻找可靠性缺口。
    该框架把笼统的“模型不够聪明”转化为可定位、可改造的系统边界问题。
  tags: [architecture, diagnosis, observation-space, action-space, harness]

- id: f02
  title: "ReAct 思考-行动-观察循环"
  type: framework
  source_chapter: "第 1 章 1.1.5 ReAct 循环"
  source_quote: |
    "模型先思考当前应该做什么，然后调用工具行动，再观察工具返回的结果并继续思考下一步。这个“想 → 做 → 看 → 想 → 做 → 看”的循环不断重复，直到任务完成。"
  summary: |
    每一轮先根据当前上下文选择下一步，而不是一次生成完整答案。
    行动通过工具作用于环境，真实结果作为观察追加到轨迹。
    下一轮决策必须消费新观察，从而校正原有计划和假设。
    循环持续到外部验收条件成立，而不是只到模型声称完成。
    它适用于搜索、编码、办事和其他需要环境反馈的开放式任务。
  tags: [reasoning, react, feedback-loop, tool-use, trajectory]

- id: f03
  title: "从调用到工作流再到自主 Agent 的编排选择"
  type: framework
  source_chapter: "第 1 章 1.2.5 编排模式：工作流与自主"
  source_quote: |
    "对于可以清晰分解为固定子任务的场景，考虑使用工作流；只有当需要动态决策和灵活的执行路径时，才使用自主 Agent。"
  summary: |
    先用最简单的单次调用验证任务能否由提示与上下文直接解决。
    若步骤固定、顺序明确且风险较高，升级为确定性工作流。
    只有路径依赖环境反馈、无法预先枚举时，才使用自主 Agent。
    每次升级都要把性能增益与新增延迟、成本和失控风险对照。
    这是避免把所有 LLM 应用过度 Agent 化的递进决策框架。
  tags: [orchestration, decision, workflow, autonomy, complexity]

- id: f04
  title: "稳定前缀-动态后缀上下文布局"
  type: framework
  source_chapter: "第 2 章 2.3 KV Cache 友好的上下文设计；2.3.4 缓存作为架构约束"
  source_quote: |
    "动态信息永远追加到末尾——时间戳、用户状态等变化的内容，作为新消息追加到对话末尾，而不是修改已有的系统提示词。"
  summary: |
    先按变化频率把上下文分为稳定前缀和动态后缀。
    系统规则、稳定工具定义放在前部，保持字节级一致以复用缓存。
    时间、状态、临时技能和新观察只追加到轨迹末尾。
    设计时同时衡量语义可读性、缓存命中率、延迟和推理成本。
    缓存因此不是事后性能优化，而是信息布局的前置架构约束。
  tags: [context-engineering, kv-cache, prompt-cache, architecture, latency]

- id: f05
  title: "渐进式披露的三层能力加载"
  type: framework
  source_chapter: "第 2 章 2.5.1 Skills：领域能力的可组合单元；2.5.3 Skills 在上下文中的位置"
  source_quote: |
    "先给 Agent 看一份目录摘要，需要时再加载完整内容。"
  summary: |
    第一层常驻少量元数据，让 Agent 知道有哪些能力以及何时触发。
    第二层在命中任务后加载核心流程，而不是启动时加载所有正文。
    第三层按实际步骤继续读取脚本、模板或详细参考文档。
    每一层都只提供当前决策所需的信息，控制注意力与上下文成本。
    该模式可迁移到工具发现、知识库导航和大型操作手册的组织。
  tags: [progressive-disclosure, skills, routing, context-budget, modularity]

- id: f06
  title: "显式状态蒸馏"
  type: framework
  source_chapter: "第 2 章 2.6 Agent 状态栏；2.6.1 Agent 状态栏的理论基础"
  source_quote: |
    "这种机制的本质是把分散在上下文各处的隐式状态提炼为可直接使用的显式知识。"
  summary: |
    不要求模型每轮从长轨迹重新统计计数、进度和约束状态。
    由代码持续维护任务清单、工具次数、环境状态与异常提醒。
    将结构化状态摘要放在上下文末尾，使当前决策能直接检索。
    原始轨迹仍保留作证据，状态栏只作为可审计的有损投影。
    状态准确率本身必须监控，因为模型会高度信任显式状态。
  tags: [context-distillation, state-management, status-bar, attention, reliability]

- id: f07
  title: "隔离优先、压缩兜底的上下文治理"
  type: framework
  source_chapter: "第 2 章 2.7.4 生产级的分层压缩机制；2.7.7 隔离优于压缩"
  source_quote: |
    "压缩是有损的、需要额外 LLM 调用的事后补救；隔离则让噪声从一开始就与主上下文绝缘。"
  summary: |
    先识别会产生大量中间信息、但主任务只需要结论的子任务。
    优先把这类探索放入隔离上下文，只回传自包含的结果摘要。
    无法隔离时，再按工具预算、删噪、归档摘要、全量压缩分层处理。
    压缩时优先保留决策、约束、验证状态、未决事项和来源引用。
    该顺序减少信息损失、缓存破坏和主上下文的长期污染。
  tags: [context-isolation, compression, sub-agent, information-value, context-rot]

- id: f08
  title: "用户记忆能力三层评估"
  type: framework
  source_chapter: "第 3 章 3.1.1 记忆能力的评估：三层次框架"
  source_quote: |
    "在此基础上，我们设计了更贴合 Agent 场景的三层次评估框架，将记忆能力分解为递进级别。"
  summary: |
    第一层检查系统能否准确保存并取回直接、明确的事实。
    第二层检查能否跨对象与时间检索多段记忆并解决冲突和歧义。
    第三层检查能否发现隐含关联，提前预警并提供主动帮助。
    设计记忆系统时应先确定目标层级，再选择表示、检索和评估方法。
    递进标尺避免用简单事实召回来代表真正的长期助理能力。
  tags: [memory, evaluation, retrieval, proactive-service, capability-levels]

- id: f09
  title: "混合召回-融合-重排流水线"
  type: framework
  source_chapter: "第 3 章 3.2.4 混合检索：两全其美的艺术"
  source_quote: |
    "典型的混合检索流水线包含三个阶段，三者各司其职、层层递进。"
  summary: |
    先并行运行稠密检索与稀疏检索，分别覆盖语义和精确词项。
    再用归一化加权或倒数排名融合构造统一候选池。
    最后用跨编码器对少量高位候选进行更昂贵的深度重排。
    用 recall@k 等指标分别诊断召回、融合和精排阶段的瓶颈。
    该框架用分级成本换取大规模检索的覆盖率与最终精度。
  tags: [rag, hybrid-retrieval, rrf, reranking, information-retrieval]

- id: f10
  title: "智能体化 RAG 的迭代探索"
  type: framework
  source_chapter: "第 3 章 3.3.4 智能体化 RAG：将知识检索工具化的范式转变"
  source_quote: |
    "在“观察”到初步结果后不会立即生成答案。"
  summary: |
    把检索从固定前置步骤改造成 Agent 可自主调用的工具。
    先分解问题并形成查询，再观察结果是否覆盖所需证据。
    若信息不足，定位缺口、改写查询、交叉检索或调用其他工具。
    只有证据充分时才综合回答，并保留来源以支持复核。
    简单单跳问题仍可用一次检索，复杂多跳问题才支付迭代成本。
  tags: [agentic-rag, iterative-search, evidence, react, knowledge]

- id: f11
  title: "概览常驻、细节按需的双层记忆"
  type: framework
  source_chapter: "第 3 章 3.3.5 实验 3-11：利用上下文感知检索增强用户记忆"
  source_quote: |
    "用 Advanced JSON Cards 把少量关键事实结构化后常驻上下文、提供随时可见的‘概览’，用上下文感知检索按需从海量原始对话中取回‘细节’。"
  summary: |
    将少量关键事实、实体关系和时间状态结构化并常驻上下文。
    将完整原始对话保存在可追溯知识库，而不是全部塞入窗口。
    当前任务先从概览发现跨会话关联，再按需检索具体证据。
    检索结果用于验证和补足细节，不能替代全局概览的导航作用。
    两层视角共同支持基础回忆、多会话判断和主动服务。
  tags: [memory, two-layer-architecture, structured-knowledge, contextual-retrieval, provenance]

- id: f12
  title: "专用工具与 Skill 的三维选择"
  type: framework
  source_chapter: "第 4 章 4.2.1 能力表达形式的选择"
  source_quote: |
    "选择哪种形态取决于三个维度。"
  summary: |
    参数嵌套复杂、联合校验多时，优先用结构化专用工具。
    流程变化频繁且参数简单时，优先用 Skill 加通用执行器。
    较弱模型依赖 schema 引导，较强模型能承担更多自然语言流程。
    高风险、权限敏感和强审计场景即使稳定，也应保留专用接口。
    决策目标是在可靠调用、维护成本、工具数量和上下文成本间平衡。
  tags: [tool-design, skills, decision, schema, capability-expression]

- id: f13
  title: "异源提议者-审核者闭环"
  type: framework
  source_chapter: "第 3 章 3.3.3；第 4 章 4.5；第 5 章 5.2.3；第 10 章 10.5.2"
  source_quote: |
    "第一种机制是事前审批：在工具执行前，一个模型负责提议行动（Proposer），另一个独立的模型负责审查批准（Reviewer）。"
  summary: |
    Proposer 负责提出最小、完整、可执行的行动或变更。
    Reviewer 独立读取原始证据、实际执行结果或异模态产物进行复核。
    两者优先使用能力相近但模型家族不同的实现，降低同源盲区。
    拒绝理由必须结构化回传，驱动修订，直到通过或触及预算上限。
    该闭环可用于安全审批、知识更新、内容质量和高风险结论验证。
  tags: [proposer-reviewer, independent-verification, cross-model, safety, iteration]

- id: f14
  title: "能力缺口驱动的主动工具发现"
  type: framework
  source_chapter: "第 4 章 4.8.1 模型原生工具发现方法"
  source_quote: |
    "在执行过程中意识到能力缺口时，主动用自然语言声明‘我需要什么能力’，系统再动态匹配并注入。"
  summary: |
    启动时只暴露基础工具和工具搜索入口，不平铺全部 schema。
    Agent 在行动中识别能力缺口，用自然语言描述所需操作。
    系统先匹配服务器或能力域，再在域内匹配具体工具。
    未命中时改写请求、用基础工具实现、创建能力或升级人工。
    命中的 schema 固定追加在轨迹原位置，以兼顾发现能力与缓存稳定。
  tags: [tool-discovery, capability-gap, hierarchical-routing, dynamic-loading, mcp]

- id: f15
  title: "任务清晰度-验证自动化四象限"
  type: framework
  source_chapter: "第 5 章 5.1.4 Harness 工程在 Coding Agent 中的实践"
  source_quote: |
    "可以用任务清晰度和验证自动化程度两个维度，将任务分成四种状态。"
  summary: |
    用目标是否明确和结果能否自动验证两条轴评估任务适配度。
    目标明确且可自动验证的任务可给予更高自治和更大执行规模。
    目标明确但需人工验收时，吞吐量受制于审查资源。
    目标模糊时先澄清与定义标准，否则自动反馈只会加速跑偏。
    Harness 的改造目标是把任务推向“目标明确、验证自动化”象限。
  tags: [task-selection, verification, four-quadrant, autonomy, harness]

- id: f16
  title: "检测-恢复-终止故障闭环"
  type: framework
  source_chapter: "第 5 章 5.1.5 故障与错误恢复"
  source_quote: |
    "检测靠‘错误分类 + 模式识别’，恢复靠‘分级升级’，终止靠‘熔断器 + 全局上限 + 人工升级’。"
  summary: |
    先按 API、工具、上下文和控制流定位故障发生层级。
    再区分可重试与不可重试错误，并监控重复指纹和连续失败。
    恢复从静默重试、改变请求和降级接续，逐级升级到用户。
    每条恢复路径设置熔断阈值、全局预算和递归深度上限。
    可靠性不要求永不犯错，而要求每类错误都有完整处置路径。
  tags: [fault-tolerance, recovery, circuit-breaker, retry, termination]

- id: f17
  title: "自然语言理解-形式化-执行验证分工"
  type: framework
  source_chapter: "第 5 章 5.2.1 代码作为思考工具"
  source_quote: |
    "让 LLM 负责理解用户的自然语言问题，识别其中的数学或逻辑结构，并转化为形式化语言。"
  summary: |
    让 LLM 处理开放式语言理解、变量识别和问题结构抽取。
    将需要精确性的部分转写为代码、约束或符号表达式。
    交给确定性执行器求值，并用运行结果而非口头推导作证据。
    若执行失败，错误反馈回到模型修正形式化表达再运行。
    该分工适合计算、逻辑、数据处理和可编码业务规则。
  tags: [formalization, code-as-reasoning, symbolic-computation, verification, division-of-labor]

- id: f18
  title: "能力上限与连续可靠性的双指标"
  type: framework
  source_chapter: "第 6 章 6.2.1 Pass@k；6.2.2 Pass^k"
  source_quote: |
    "前一个数字适合衡量探索时的能力天花板，后一个数字才接近支付、退款、权限变更、生产部署等场景的可靠性要求。"
  summary: |
    探索、科研与创作任务用 Pass@k 衡量充足预算下的能力上限。
    支付、退款、权限和部署等业务用连续通过率衡量稳定性。
    同一单次成功率在两类指标下可能给出完全相反的结论。
    有副作用的重复采样必须放在沙盒或可回滚环境中完成。
    指标选择应先由业务容错目标决定，而不是由更好看的数字决定。
  tags: [evaluation, pass-at-k, reliability, metrics, risk]

- id: f19
  title: "五要素可重复评估循环"
  type: framework
  source_chapter: "第 6 章 6.3.1 评估环境的基本组成"
  source_quote: |
    "五个要素合起来，就是一个可重复的评估循环。"
  summary: |
    数据集给出初始状态、任务目标与覆盖分布。
    可重置环境维护真实状态变化，工具定义可采取的原子行动。
    Rubric 或验证器度量结果、过程与安全，协议规定交互和终止。
    每次运行都保存完整轨迹和最终环境快照，再统一评分。
    reset、轨迹与 outcome 共同保证公平复跑、结果验证和失败定位。
  tags: [evaluation-environment, reproducibility, dataset, rubric, protocol]

- id: f20
  title: "首错归因与双层回归"
  type: framework
  source_chapter: "第 6 章 6.5.2 失败归因；6.5.3 端到端与轨迹前缀回归"
  source_quote: |
    "归因对象是轨迹中的首个导致任务偏离的错误，后续错误往往只是连锁反应。"
  summary: |
    对失败轨迹定位最早的不可接受动作、输出和可复核证据。
    将后续重试、报错和连锁反应区分为后果，而不是重复根因。
    把首错之前的状态冻结成轨迹前缀回归，隔离决策边界。
    同时保留端到端回归，检查完整工作流、最终状态和安全条件。
    两层测试分别提高定位精度与系统级回归保护能力。
  tags: [failure-attribution, first-error, regression, trajectory-prefix, debugging]

- id: f21
  title: "观察-假设-实验-决策-迭代改进"
  type: framework
  source_chapter: "第 6 章 6.9 从 Benchmark 报告到系统改进"
  source_quote: |
    "上一轮暴露的问题，恰好成为下一轮唯一要验证的改动。"
  summary: |
    先确认评测系统可信，再按任务和能力标签寻找失败聚集区。
    回放轨迹区分问题出在看、想、做还是验，并提出可证伪假设。
    每轮只改变一个变量，在固定环境与基线下做配对实验。
    同时比较成功率、成本、延迟和护栏指标，再决定扩大或放弃。
    一轮证据只支持与样本规模相称的下一步，不直接外推到全系统。
  tags: [scientific-method, benchmark, hypothesis, ablation, iteration]

- id: f22
  title: "先 SFT 固形、再 RL 塑策的训练选择"
  type: framework
  source_chapter: "第 7 章 7.1.3；7.6 何时选择 SFT，何时选择 RL"
  source_quote: |
    "SFT 先把‘形’（格式、结构）立起来，RL 再追求‘神’（策略、泛化），即先形后神。"
  summary: |
    有高质量示范、目标是格式风格或稳定协议时，优先选择 SFT。
    输出尚不可解析时，先用少量 SFT 建立可靠奖励计算的起点。
    当部署分布变化、需要探索或示范并非最优时，再考虑 RL。
    若强基模已稳定输出且奖励可靠，可以跳过或缩短冷启动 SFT。
    选择还要比较泛化收益与 RL 高出数十倍以上的计算成本。
  tags: [post-training, sft, reinforcement-learning, decision, generalization]

- id: f23
  title: "奖励来源-时机-信息量-路径四问"
  type: framework
  source_chapter: "第 7 章 7.11 奖励设计"
  source_quote: |
    "工程上可以先用结果奖励建立可靠基线，再只为真正可验证的中间事件加入过程信号。"
  summary: |
    先决定奖励依据来自确定性规则、人类偏好还是模型评判。
    再决定只在结果给奖励，还是为可验证的关键过程补充信号。
    按任务选择二元标量、多维向量或带事实校验的生成式诊断。
    最后独立检查路径约束，防止用破坏性捷径取得表面成功。
    每增加一种信号都要验证其区分度和被策略钻空子的风险。
  tags: [reward-design, outcome-reward, process-reward, rl-vp, reward-hacking]

- id: f24
  title: "结果-过程-质量三层轨迹验证"
  type: framework
  source_chapter: "第 8 章 8.1 从运行轨迹中获得学习信号"
  source_quote: |
    "底层的结果验证器读取测试结果、数据库状态和工具返回，回答“事情是否真的办成”；中间的过程验证器检查业务规则、权限和动作序列，回答“是否以允许的方式办成”；上层的质量验证器依据 Rubric 评价语言与策略，回答“是否办得合适”。"
  summary: |
    底层优先读取测试、数据库和环境真值，验证实际结果。
    中层检查权限、政策、动作序列和承诺是否合规一致。
    上层才用 Rubric 与 LLM 判断自然度、策略和服务质量。
    结果与过程是硬门，未通过的轨迹不能作为正向学习样本。
    输出保留逐维度结论、证据位置和置信度，而不是压成总分。
  tags: [trajectory-evaluation, outcome, process, quality, evidence]

- id: f25
  title: "知识-指令-程序-参数四载体路由"
  type: framework
  source_chapter: "第 8 章 8.2 Agent 持续进化的四种方法"
  source_quote: |
    "选择更新方式的首要依据不是经验出现了多久，而是目标能力能否被某种载体自然表达。"
  summary: |
    先判断经验最自然的表示性质，而不是默认修改模型参数。
    有来源的事实进入知识，可语言化的判断进入 Prompt 或 Skill。
    确定性流程和不可绕过的安全约束进入程序或 Harness。
    难以显式表达的感知、风格和隐式策略才进入模型参数。
    同一能力可以拆到多个载体，但每项更新仍需独立验证和发布。
  tags: [continuous-learning, routing, knowledge, skill, harness, parameters]

- id: f26
  title: "在线执行-离线进化双循环"
  type: framework
  source_chapter: "第 8 章 8.3；8.3.2 验证、发布与回滚"
  source_quote: |
    "在线执行循环只完成任务并记录证据，不直接改写正式 Agent；离线进化循环聚合轨迹、诊断根因、生成更新提案，再通过验证门槛发布新版本。"
  summary: |
    在线稳定版只处理真实任务并追加不可变轨迹与反馈证据。
    离线流程聚合同类运行、诊断根因并选择最小更新载体。
    候选依次通过边界集、保留集和安全集，任何硬门失败即拒绝。
    通过后先灰度发布、监控真实指标，退化时回滚到稳定版本。
    验证器、权限、审计日志和备份构成不可由普通进化修改的可信根。
  tags: [continuous-evolution, online-offline, canary, rollback, trusted-root]

- id: f27
  title: "级联-端到端-全双工交互架构选择"
  type: framework
  source_chapter: "第 9 章 9.1.1 交互时序；9.1.5 认知时序"
  source_quote: |
    "它们不是简单的新旧替代，而是不同延迟、成本和可观测性约束下的取舍。"
  summary: |
    需要模块可替换、易调试时，选择 VAD-ASR-LLM-TTS 级联。
    任务依赖语气、情绪和环境声时，考虑端到端全模态模型。
    需要重叠说话、自然打断和持续决策时，才采用全双工架构。
    实时前台与深度后台可分工，但必须管理提交、取消和矛盾风险。
    选择依据是任务信息载体与交互时序，而不是追逐更新的模型形态。
  tags: [multimodal, realtime, cascade, omni, full-duplex]

- id: f28
  title: "多时间尺度的感知-规划-技能-控制闭环"
  type: framework
  source_chapter: "第 9 章 9.3.2 机器人控制的基本结构；9.3.3 长程规划与任务分解"
  source_quote: |
    "无论采用哪种实现，都应该把“任务顺序”和“眼前动作”分开。"
  summary: |
    分离分钟级任务目标、秒级长程规划、技能状态变化与高频控制。
    高层只决定做什么和先后顺序，不直接输出任意底层关节动作。
    每个技能写明前置条件、完成条件、风险边界、超时和停止方式。
    执行后必须重新观察并验证；局部失败只重试或重规划受影响部分。
    世界模型可比较候选后果，但真实环境新观察始终是最终验收依据。
  tags: [robotics, hierarchical-control, planning, closed-loop, verification]

- id: f29
  title: "上下文共享度-协作拓扑双维分类"
  type: framework
  source_chapter: "第 10 章 10.1 多 Agent 协作的分类框架"
  source_quote: |
    "要构建多 Agent 系统，首先需要理解两个核心设计维度，它们共同决定了系统的基本架构和实现方式。"
  summary: |
    第一维决定共享完整轨迹，还是用结构化产物与消息显式移交。
    共享上下文保留细节但易膨胀，隔离上下文利于并发、权限和模块化。
    第二维在对等迭代、中心管理者和去中心化移交之间选择控制流。
    组合两个维度后，再设计工具参数、文件系统或消息总线通信。
    每种组合都应明确状态所有权、权限边界、终止条件和验收接口。
  tags: [multi-agent, taxonomy, context-sharing, topology, coordination]

- id: f30
  title: "多 Agent 信息增量判据"
  type: framework
  source_chapter: "第 10 章 10.2 多 Agent 何时真正优于单 Agent"
  source_quote: |
    "核心判据只有一条：协作过程是否引入了单个 Agent 在生成时无法获得的新信息？"
  summary: |
    采用多 Agent 前，先列出每个参与者能新增的独立观察或验证信号。
    代码执行、视觉渲染、外部工具和专有上下文都属于真实信息增量。
    多个模型仅围绕同一文本辩论，通常只是重复计算而非增加证据。
    即使存在增量，也要比较质量收益与 token、延迟和协调成本。
    若增量不足以覆盖额外开销，应回到调校良好的单 Agent 方案。
  tags: [multi-agent, information-gain, decision, cost-benefit, verification]
