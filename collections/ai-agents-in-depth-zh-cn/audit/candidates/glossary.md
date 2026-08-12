# 关键概念词典候选

- id: g01
  term: Agent
  type: term
  source_chapter: 第 1 章 1.1「现代 Agent = LLM + 上下文 + 工具」
  author_definition: |
    “现代 Agent 的最小工程实现可以用一个简洁的公式来表达：Agent = LLM（大语言模型，Large Language Model）+ 上下文 + 工具。”
  key_distinction: |
    ≠ 单独的聊天模型或一段提示词
    ≠ Agent 所交互的 Environment；文件、数据库、用户和物理世界仍在 Agent 边界之外
    = 决策内核、可见信息与行动接口的工程组合
  why_it_matters: |
    这是全书统一模型。下游方法必须同时诊断模型策略、上下文和工具，不能把所有失败都归因于“模型不够强”。
  tags: [agent, architecture, core-concept]

- id: g02
  term: 观察空间与动作空间
  type: term
  source_chapter: 第 1 章 1.1.1「观察空间与动作空间：模型与世界的接口」
  author_definition: |
    “观察通道与动作接口共同构成了 Agent 与外部环境之间的边界。没有通过观察通道进入上下文的信息，对模型来说就像不存在；没有被动作接口允许的操作，也只能停留在文字建议上。”
  key_distinction: |
    ≠ 模型已经知道或理论上能够生成的全部内容
    = 系统实际允许 Agent 观察和执行的范围；在本书工程术语中分别落为上下文和工具
  why_it_matters: |
    它把许多表面上的模型能力问题改写为接口问题，指导下游先检查缺失的信息通道或动作接口。
  tags: [observation-space, action-space, environment, architecture]

- id: g03
  term: 上下文
  type: term
  source_chapter: 第 1 章 1.1.4「上下文：Agent 的眼睛」；第 2 章 2.2.5「从 API 视角看上下文的构成」
  author_definition: |
    “上下文是 Agent 在每个决策点能看到的全部信息。”
  key_distinction: |
    ≠ 仅指聊天历史或用户当前输入
    ≠ 外部环境本身
    = 静态前缀（系统提示词、工具定义）与动态轨迹（用户消息、模型回复、工具结果）的组合
  why_it_matters: |
    上下文决定每一步决策可用的证据。遗漏工具结果、历史、状态或来源信息，会制造重复操作、失忆和盲目循环。
  tags: [context, static-prefix, trajectory, core-concept]

- id: g04
  term: 工具
  type: term
  source_chapter: 第 1 章 1.1「现代 Agent = LLM + 上下文 + 工具」；第 4 章 4.1「工具的分类」
  author_definition: |
    “这里的‘工具’指 Agent 用来感知或改变外部世界的接口，包括工具定义、调用协议和适配器。”
  key_distinction: |
    ≠ 只指函数调用、API 或执行型操作
    = 广义的观察与行动接口；感知、执行、协作、事件触发和用户沟通均可属于工具
    ≠ 工具背后的文件系统、数据库、网页、用户或物理世界；这些属于环境
  why_it_matters: |
    这个边界决定工具分类、权限模型和验证方式，也防止把环境状态错误地算入 Agent 或 Harness。
  tags: [tools, interface, environment, action]

- id: g05
  term: ReAct 循环
  type: term
  source_chapter: 第 1 章 1.1.5「ReAct 循环」
  author_definition: |
    “实际循环包含三个环节：模型先思考当前应该做什么，然后调用工具行动，再观察工具返回的结果并继续思考下一步。”
  key_distinction: |
    ≠ 只生成一段显式思维链
    ≠ 一次性计划后盲目执行到底
    = 思考、行动、观察反馈的闭环，且观察结果会追加回轨迹
  why_it_matters: |
    下游实现需要把工具结果可靠地送回上下文，并定义继续、纠错和终止条件，否则并未形成真正的 Agent 循环。
  tags: [react, loop, feedback, tool-use]

- id: g06
  term: 轨迹（trajectory）
  type: term
  source_chapter: 第 1 章 1.1.5「ReAct 循环」；第 6 章 6.2.4「安全、鲁棒性与轨迹覆盖」
  author_definition: |
    “轨迹是 Agent 在执行任务过程中不断积累的消息历史——用户消息、模型回复（包括思考过程和工具调用）、工具执行结果。”
  key_distinction: |
    ≠ 静态系统提示词和工具定义
    ≠ 最终结果（outcome）；Agent 声称完成属于轨迹，环境是否真的改变属于结果
    = 运行历史，也是调试、评估、失败归因和学习的数据来源
  why_it_matters: |
    只看最终回复会漏掉危险路径，只看轨迹又会漏掉“说了但没做到”。下游评估必须同时保存轨迹与环境结果。
  tags: [trajectory, history, evaluation, learning-signal]

- id: g07
  term: Harness
  type: term
  source_chapter: 第 1 章 1.2「Harness 工程：模型之外的竞争力」；第 5 章 5.1.4「Harness 工程在 Coding Agent 中的实践」
  author_definition: |
    “Harness 不是模型之外的一切，而是 Agent 边界内、模型之外的运行与治理层。”
  key_distinction: |
    ≠ 对模型 API 的薄封装
    ≠ Environment；即使仿真环境与 Agent 同进程运行，环境状态仍不属于 Harness
    = 中介 Model 与 Environment，并承担运行、治理、验证和恢复的工程层
  why_it_matters: |
    生产可靠性主要由这一层把模型错误变成可检测、可恢复、可验证的流程。下游不能把更换模型当作唯一改进手段。
  tags: [harness, runtime, governance, reliability, core-concept]

- id: g08
  term: 上下文工程
  type: term
  source_chapter: 第 2 章开篇；第 2 章 2.8「本章小结」
  author_definition: |
    “上下文的设计和管理称为上下文工程（Context Engineering）。”
  key_distinction: |
    ≠ 提示词润色或向 prompt 塞入更多文本
    = 对信息进行选择、布局、缓存、显式化、按需加载、压缩和隔离
    ⊂ Harness 工程，而提示工程只是上下文工程的一部分
  why_it_matters: |
    下游长任务方法需要同时处理稳定前缀、动态轨迹、状态栏、Skills、压缩和隔离，而不是只修改系统提示词。
  tags: [context-engineering, prompt, cache, compression]

- id: g09
  term: Agent Skill
  type: term
  source_chapter: 第 2 章 2.5.1「Skills：领域能力的可组合单元」；第 2 章 2.5.4「Skills 与工具的关系」
  author_definition: |
    “每个 Skill 本质上是一套包含专业领域指导的提示词集合，就像为新员工准备的某个专项任务的操作手册。”
  key_distinction: |
    ≠ 工具；Skill 主要说明“如何做”，工具提供“能做什么”的执行接口
    ≠ 背景知识堆积或一次成功对话的摘要
    = 带触发元数据、核心流程，并可捆绑参考资料、脚本和模板的领域方法单元
  why_it_matters: |
    下游沉淀经验时需要判断应写成可加载指令还是可执行工具，错误归类会导致工具爆炸或不可执行的知识堆积。
  tags: [skill, instructions, modularity, context]

- id: g10
  term: Agent 状态栏
  type: term
  source_chapter: 第 2 章 2.6「Agent 状态栏：通过元信息增强 Agent 轨迹管理」
  author_definition: |
    “Agent 框架把这些动态信息整理成结构化摘要并注入上下文，这种机制称为 Agent 状态栏（Agent Status Bar）。”
  key_distinction: |
    ≠ 对话主体内容或随意的历史摘要
    ≠ 原始轨迹的替代品；它是有损投影
    = 由框架维护、置于上下文末尾、让隐式状态显式化的动态元信息
  why_it_matters: |
    它能降低长轨迹中的状态检索成本，但模型会高度信任它，因此准确率、来源防污染和更新方式必须作为生产指标管理。
  tags: [status-bar, state, metadata, attention]

- id: g11
  term: 用户记忆
  type: term
  source_chapter: 第 3 章开篇；第 3 章 3.1「用户记忆系统」
  author_definition: |
    “要让 Agent 跨会话提供个性化服务，需要一层持久的用户记忆。它不保存每句对话，而是用额外的 LLM 调用提取、压缩并审查对未来有用的事实。”
  key_distinction: |
    ≠ 当前会话的完整轨迹
    ≠ 面向所有用户共享的知识库
    ≠ 无差别永久保存聊天记录
    = 与用户绑定、跨会话持久化，并需要来源、时间、冲突和隐私治理的信息
  why_it_matters: |
    下游记忆系统必须设计读写、审核、冲突更新和删除机制；简单累积历史既不等于记忆，也会扩大隐私和检索风险。
  tags: [memory, personalization, persistence, privacy]

- id: g12
  term: 智能体化 RAG（Agentic RAG）
  type: term
  source_chapter: 第 3 章 3.3.4「智能体化 RAG：将知识检索工具化的范式转变」
  author_definition: |
    “知识库检索不再是自动化的前置步骤，而是被封装成一个可供 Agent 随时调用的工具；Agent 通过‘思考→行动→观察’循环主导整个过程。”
  key_distinction: |
    ≠ 每次回答前固定做一次检索的单向流水线
    = Agent 自主决定是否检索、查询什么、如何改写查询、是否继续和何时停止
    ≠ 所有问题都必须多轮检索；明确单一的信息需求仍可能适合传统 RAG
  why_it_matters: |
    下游知识方法要把检索控制权、停止条件、来源标记和间接提示注入防护一起设计，不能只替换向量数据库。
  tags: [agentic-rag, retrieval, knowledge, react]

- id: g13
  term: 代码（Agent 的元能力）
  type: term
  source_chapter: 第 5 章开篇；第 5 章 5.2「代码：通用 Agent 的元能力」
  author_definition: |
    “代码生成不只是工具箱里的一个工具，而是一种元能力——能在运行时动态创造出新的工具和能力。”
  key_distinction: |
    ≠ 只为软件开发任务写程序
    = 形式化思考、精确表达、执行计算、固化规则、适配系统、生成界面和创造新工具的通用媒介
    适用边界：开放任务型通用 Agent 常以 Coding Agent + 文件系统为核心，封闭垂直任务未必如此
  why_it_matters: |
    下游设计可用少量通用执行工具替代大量专用接口，并把可验证的规则和重复操作沉淀为程序，但必须配套沙箱和测试。
  tags: [coding-agent, code, meta-capability, tools]

- id: g14
  term: Agent 评估
  type: term
  source_chapter: 第 6 章导读；第 6 章 6.3.1「评估环境的基本组成」
  author_definition: |
    “评估的对象不应只是模型，而应是模型与 Harness 的组合体。”
  key_distinction: |
    ≠ 偶尔跑一次公开榜单或只看最终回答准确率
    = 成功标准、可重置环境、任务数据集、工具接口、评判方法、统计分析和失败归因组成的持续验证系统
  why_it_matters: |
    下游所有优化都依赖它判断变化是否真实，并区分模型瓶颈、Harness 缺陷和环境问题。
  tags: [evaluation, benchmark, harness, validation]

- id: g15
  term: Pass@k
  type: term
  source_chapter: 第 6 章 6.2.1「技术奇观：用 Pass@k 看能力上限」
  author_definition: |
    “在同一任务上运行 k 次，只要至少有一次通过，任务就算通过；如果输出是连续得分，则取最好的一次。”
  key_distinction: |
    ≠ 单次平均成功率 Pass@1
    ≠ 连续可靠性 Pass^k
    = 衡量给定多次探索、筛选或尝试预算后的能力上限
  why_it_matters: |
    它适合科研发现、漏洞挖掘和开放创作等可挑选候选的任务，但不能拿来证明生产流程“稳定做成”。
  tags: [pass-at-k, evaluation, capability-ceiling, exploration]

- id: g16
  term: Pass^k（连续通过率）
  type: term
  source_chapter: 第 6 章 6.2.2「业务可靠性：关注 Pass^k」
  author_definition: |
    “同一任务连续运行 k 次，要求每一次都通过，且不能触发安全、合规或幻觉等一票否决项。”
  key_distinction: |
    ≠ k 次里至少一次成功的 Pass@k
    = 衡量 Agent 能否连续、稳定、无否决项地交付
    需明确 k 指同一任务多次采样，还是生产线上连续 k 个任务
  why_it_matters: |
    高风险和生产任务关心的是“不出错”而非“偶尔成功”。混淆两个指标会把技术演示误判为业务可靠性。
  tags: [pass-consecutive-k, reliability, evaluation, safety]

- id: g17
  term: 失败归因（failure attribution）
  type: term
  source_chapter: 第 6 章 6.5.2「失败归因：从整条轨迹定位首个错误」
  author_definition: |
    “标出主要错误类别、首次出现不可接受行为的步骤、对应的工具调用或模型输出，并附上可复核的证据。”
  key_distinction: |
    ≠ 给整条失败轨迹写一句笼统总结
    ≠ 把最后一个报错或所有后续症状当成根因
    = 定位首个使任务偏离的错误，并区分主因、次因、后果与责任层
  why_it_matters: |
    下游修复载体的选择依赖准确归因：模型、提示词、工具协议、Harness 或产品规则需要不同的改法。
  tags: [failure-attribution, root-cause, trajectory, bad-case]

- id: g18
  term: 轨迹前缀回归任务
  type: term
  source_chapter: 第 6 章 6.5.3「端到端回归任务与轨迹前缀回归任务」
  author_definition: |
    “轨迹前缀回归任务把已有的上下文、对话、工具返回和环境状态冻结下来，只要求 Agent 思考并执行下一步或下几步可观察动作。”
  key_distinction: |
    ≠ 从初始请求重跑整个任务的端到端回归
    ≠ 要求唯一标准答案；应定义可接受动作集合与禁止动作
    = 在首错之前冻结状态，隔离验证一个决策边界
  why_it_matters: |
    它以较低成本验证具体修复是否生效，并把失败归因直接转成可用于回归、SFT、偏好学习或过程约束的数据。
  tags: [trajectory-prefix, regression, decision-boundary, evaluation]

- id: g19
  term: SFT 与 RL
  type: term
  source_chapter: 第 7 章 7.1.4「SFT 与 RL 的本质区别」；第 7 章 7.15「本章小结」
  author_definition: |
    “SFT 最大化标注回答的概率；RL 最大化期望奖励。”
  key_distinction: |
    SFT 用输入—输出示范高效固化格式、风格、映射与协议；RL 让模型探索并强化获得奖励的策略
    “SFT 记忆、RL 泛化”只是本书受控实验中的倾向，不是不受数据、模型、奖励与环境影响的普遍规律
    结构化输出不稳定时常先用 SFT 立“形”，再用 RL 求策略之“神”
  why_it_matters: |
    下游训练决策必须先判断需要稳定协议还是探索策略，并验证数据、环境与奖励是否足够可靠，不能因术语热度默认上 RL。
  tags: [sft, reinforcement-learning, post-training, strategy]

- id: g20
  term: 可验证奖励（RL VR）
  type: term
  source_chapter: 第 6 章 6.11「仿真环境：从评估到后训练的桥梁」；第 7 章 7.11.1「奖励来自哪里」
  author_definition: |
    “最可靠的来源是可验证奖励（RL VR）：用测试用例、数据库断言、状态差异或格式检查直接判断结果。”
  key_distinction: |
    ≠ 让模型自己声称“已完成”或只用主观偏好打分
    ≠ 路径合规性约束；RL VR 主要验证结果，违规路径需过程信号或 RL VP 补充
    = 可复现、可执行、直接读取真实环境状态的奖励
  why_it_matters: |
    它连接评估环境与后训练。若验证器不可靠或只检查表面声明，训练会把奖励漏洞而非真实能力写入参数。
  tags: [rl-vr, verifiable-reward, training, environment]

- id: g21
  term: 持续进化
  type: term
  source_chapter: 第 8 章开篇；第 8 章 8.3「构建可长期运行的持续进化闭环」
  author_definition: |
    “持续进化需要来自可追溯的运行经验、能够改变后续行为，并经过验证没有造成明显退化。”
  key_distinction: |
    ≠ 保存日志、追加反馈、生成一次反思或直接在线微调
    ≠ Agent 可不受约束地修改自身
    = 评价与归因、提炼更新提案、独立验证、灰度发布、监控、回滚和淘汰组成的版本化闭环
  why_it_matters: |
    下游学习系统必须证明更新改变了后续行为且没有破坏旧能力，否则“完成一次自我修改”不等于“取得进步”。
  tags: [continuous-evolution, learning-loop, validation, rollback]

- id: g22
  term: 四种更新载体
  type: term
  source_chapter: 第 8 章 8.2「Agent 持续进化的四种方法」
  author_definition: |
    “事实和经验适合写成知识文档；可以清楚语言化的策略适合写入提示词或 Skill；可以精确执行的流程与约束适合写成程序；高维能力则必须进入模型参数。”
  key_distinction: |
    ≠ 按经验新旧程度从知识一路“升级”到参数的单向阶梯
    = 知识、指令、程序、参数四种互补表示；首要判断是能力能否被事实、语言规则或程序完整表达
    同一能力可以拆分到多个载体，并由程序守住不可绕过的硬约束
  why_it_matters: |
    它是 bad case 修复路由的核心词典。选错载体会造成事实难更新、规则不可审计、流程反复推理或昂贵且脆弱的训练。
  tags: [knowledge, instructions, program, parameters, update-routing]

- id: g23
  term: 交互能力
  type: term
  source_chapter: 第 9 章开篇；第 9 章 9.4「本章小结」
  author_definition: |
    “交互回答的是：模型能否在持续变化的环境中，在合适的时机接收信息、采取行动，并根据反馈调整下一步。”
  key_distinction: |
    ≠ 理解能力（能否看懂并想明白）
    ≠ 生成能力（能否把想法表达出来）
    = 把已有智能放进有时间约束、会产生反馈并可能改变环境的持续闭环
  why_it_matters: |
    强推理或强生成不保证真实任务表现。下游语音、GUI 和机器人方法都必须设计持续感知、时机、反馈确认与恢复。
  tags: [interaction, realtime, multimodal, closed-loop]

- id: g24
  term: 世界模型
  type: term
  source_chapter: 第 9 章 9.2.4「Computer Use 的世界模型」；第 9 章 9.3.6「世界模型」
  author_definition: |
    “可以把世界模型理解成一个‘动作结果预测器’：在当前状态下采取某个动作，下一刻的状态可能变成什么样。”
  key_distinction: |
    ≠ 只描述当前画面的视觉语言模型
    ≠ 必须生成逼真的未来截图或视频
    = 显式学习动作与未来观察的关系，用于候选动作比较、异常检测和规划
  why_it_matters: |
    下游交互系统可用它在执行前预测后果、执行后比较偏差，但仍需短期预测、实时观察、不确定性估计和独立安全控制。
  tags: [world-model, prediction, computer-use, robotics]

- id: g25
  term: 多 Agent 信息增量
  type: term
  source_chapter: 第 10 章 10.2「多 Agent 何时真正优于单 Agent」
  author_definition: |
    “核心判据只有一条：协作过程是否引入了单个 Agent 在生成时无法获得的新信息？”
  key_distinction: |
    ≠ 多设几个角色、让相同模型反复阅读同一上下文或无外部证据地辩论
    = 独立观察、测试执行、渲染截图、外部事实验证、专有上下文或并行探索带来的新证据
    信息增量必须与额外 token、延迟和协调成本一起衡量
  why_it_matters: |
    它是决定是否采用多 Agent 的首要门槛，可避免把昂贵的角色扮演误当成能力提升。
  tags: [multi-agent, information-gain, collaboration, cost]

- id: g26
  term: Loop 工程（Loop Engineering）
  type: term
  source_chapter: 第 10 章 10.4.3.1「Loop 工程」
  author_definition: |
    “设计一个让 Agent 持续运转的循环——发现下一件该做的事、执行、验证、记录进度——由验证器而不是模型自己来判定‘是否真的可以停’。”
  key_distinction: |
    ≠ 写一条更强的提示词催模型继续
    ≠ 无上限地循环或相信模型的完成声明
    = 将目标、门禁、待办、证据、预算、移交和终止条件放进持久控制面
  why_it_matters: |
    它直接处理偷懒式假完成、过早放弃和假成功。下游循环的瓶颈首先是验证器质量，而不是循环速度或模型数量。
  tags: [loop-engineering, verification, termination, control-plane]

- id: g27
  term: 移交包
  type: term
  source_chapter: 第 10 章 10.4.5「去中心化模式」
  author_definition: |
    “一个有效的‘移交包’通常包含三部分：任务描述（接收方要做什么、验收标准是什么）、已确认的事实与约束（用户偏好、业务规则、前序阶段敲定的决策），以及结构化产物的引用（文件路径而非文件内容，接收方按需读取）。”
  key_distinction: |
    ≠ 默认传递前一个 Agent 的完整私有轨迹或思考过程
    ≠ 只有一句“请继续处理”的自由文本消息
    = 面向接收方、结构化、可追溯，并用文件路径等引用按需传递大产物
  why_it_matters: |
    隔离上下文的协作依靠移交包保持语义完整、控制信息泄露并减少上下文膨胀；它也是跨组织 A2A 协作的基本接口思想。
  tags: [handoff, multi-agent, structured-artifact, context-isolation]
