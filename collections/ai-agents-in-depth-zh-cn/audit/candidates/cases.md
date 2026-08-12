# 案例候选池

> 阶段 1 案例提取。仅收录作者实践、实验或作者用于阐释方法论的书中案例；不做 Skill 筛选。合并项在 `source_chapter` 中保留全部出处。`outcome` 明确区分实测结果与实验验收目标。

- id: c001
  title: 上下文四组件消融
  type: case
  source_chapter: "第 1 章 1.1.4，实验 1-1"
  source_quote: |
    “实验 1-1 ★★：上下文的关键作用”
  summary: |
    作者以完整上下文为基线，分别移除工具定义、工具结果、思考过程和历史消息，观察 ReAct 行为退化。
    该实验把“上下文决定 Agent 能看到什么”从架构主张转化为可观察的因果对照。
  bound_to:
    - "用消融实验验证系统组件贡献"
    - "ReAct 闭环的上下文完整性"
  outcome: |
    工具定义缺失使行动能力消失；工具结果缺失导致循环；思考缺失造成决策矛盾；历史缺失导致重复执行。
  tags: [case, experiment, ablation, context, react]

- id: c002
  title: Kimi K3 的原生工具决策
  type: case
  source_chapter: "第 1 章 1.1.5，实验 1-2"
  source_quote: |
    “模型自己决定何时搜索、搜索什么，展现了真正的自主性；它能根据搜索结果动态调整策略，自主判断信息是否充足。”
  summary: |
    书中用 Kimi K3 演示强化学习如何把“何时调用、调用哪个、参数如何填写”内化为模型策略，同时保留工具执行在模型外部。
  bound_to:
    - "区分模型策略与外部工具实现"
    - "原生 Agent 决策能力"
  outcome: |
    实验观察到模型能够自主搜索并根据返回结果继续或停止，说明 RL 内化的是工具使用策略而非工具本体。
  tags: [case, experiment, tool-use, reinforcement-learning]

- id: c003
  title: GPT-5.6 Deep Research 的搜索—计算闭环
  type: case
  source_chapter: "第 1 章 1.1.5，实验 1-3"
  source_quote: |
    “实验 1-3 ★：GPT-5.6 原生 Deep Research 能力”
  summary: |
    作者用地理距离和比特币技术分析任务，展示模型如何把网络搜索、阅读、代码计算和再搜索组织为服务端研究循环。
  bound_to:
    - "复杂任务中的工具编排"
    - "搜索与代码计算互补"
  outcome: |
    Agent 能从实时来源取数、编写程序完成聚合计算，并以工具结果决定下一轮研究动作。
  tags: [case, experiment, deep-research, search, code]

- id: c004
  title: 0.6B 本地模型完成工具调用
  type: case
  source_chapter: "第 2 章 2.2.4，实验 2-1"
  source_quote: |
    “实验 2-1 ★：本地 LLM 服务部署与工具调用”
  summary: |
    local_llm_serving 项目用 OpenAI 兼容的本地推理服务，让小模型生成工具调用、接收本地执行结果并形成最终回复。
  bound_to:
    - "模型规模与 Harness 的互补"
    - "本地化工具调用架构"
  outcome: |
    项目跑通“模型决策—本地工具执行—结果回传”的核心循环，证明基础工具能力不必依赖超大模型。
  tags: [case, experiment, local-llm, tool-calling]

- id: c005
  title: 注意力机制可视化
  type: case
  source_chapter: "第 2 章 2.3.2，实验 2-2"
  source_quote: |
    “实验 2-2 ★：注意力机制可视化”
  summary: |
    作者用具体中文句子可视化 Query、Key、Value 的匹配与加权过程，为随后解释 KV Cache 的约束提供直观实验。
  bound_to:
    - "用可视化建立底层机制直觉"
    - "KV Cache 的注意力基础"
  outcome: |
    实验把抽象注意力计算映射到“当前词从前文找重点”的可观察过程；书中未将其作为性能 benchmark。
  tags: [case, experiment, attention, visualization, kv-cache]

- id: c006
  title: 错误上下文管理破坏缓存与任务状态
  type: case
  source_chapter: "第 2 章 2.3.4，实验 2-3"
  source_quote: |
    “保持固定的顺序对模型选择工具的能力几乎没有影响，但对性能提升却是显著的。”
  summary: |
    实验系统测试动态时间戳、动态用户配置、工具 schema 重排和滑动窗口等常见做法，分离其缓存代价与行为副作用。
  bound_to:
    - "KV Cache 友好的稳定前缀"
    - "上下文历史的状态保真"
  outcome: |
    动态前缀和工具重排造成缓存失效；滑动窗口还会丢失任务状态并诱发重复工具调用。
  tags: [case, experiment, kv-cache, context-management, failure]

- id: c007
  title: 航空客服提示工程消融
  type: case
  source_chapter: "第 2 章 2.4，实验 2-4"
  source_quote: |
    “实验 2-4 ★★：提示工程的消融实验”
  summary: |
    作者在 Tau-Bench 客服场景中固定基线，分别改变语气、结构和规则表达，测量任务完成率、效率和满意度。
  bound_to:
    - "提示工程的控制变量实验"
    - "流程化组织优于规则堆砌"
  outcome: |
    风格变化影响有限；打乱规则结构令成功率下降超过 30%，显示信息组织方式具有实质性影响。
  tags: [case, experiment, prompt-engineering, ablation, tau-bench]

- id: c008
  title: 三类提示注入与组合防御
  type: case
  source_chapter: "第 2 章 2.4.7，实验 2-5"
  source_quote: |
    “实验 2-5 ★★：提示注入攻防实验”
  summary: |
    实验构造直接注入、网页间接注入和跨会话记忆注入，并对比无防御、提示警告、来源标记与组合防御。
  bound_to:
    - "提示注入威胁建模"
    - "多层防御与来源隔离"
  outcome: |
    书中把攻击是否泄露提示、越权写文件或污染后续记忆作为验收信号；未报告统一量化结果。
  tags: [case, experiment, prompt-injection, security, memory]

- id: c009
  title: 按需加载 PPTX Skill 生成论文演示稿
  type: case
  source_chapter: "第 2 章 2.5.1，实验 2-6"
  source_quote: |
    “实验 2-6 ★★：使用 Agent Skills 从论文生成演示文稿”
  summary: |
    作者让支持渐进式披露的 Agent 从 Skill 元数据出发，按需读取 PPTX 指令、子文档和脚本，把论文转成演示文稿。
  bound_to:
    - "Agent Skills 的渐进式披露"
    - "复杂任务的按需上下文加载"
  outcome: |
    验收要求生成 10-15 页、覆盖论文主线且含至少三张一致图表的可打开演示稿；正文未报告统一得分。
  tags: [case, experiment, skill, progressive-disclosure, pptx]

- id: c010
  title: 从个人范文迭代写作 Skill
  type: case
  source_chapter: "第 2 章 2.5.2，实验 2-7"
  source_quote: |
    “选择一个新题目起草文章，作者手动修改后，比较 before/after 并把稳定规律写回 Skill。”
  summary: |
    实验用三到五篇个人范文生成初版写作 Skill，再通过新文章的人类修改提取稳定偏好，而非一次性罗列大量规则。
  bound_to:
    - "从示例中外化可迭代经验"
    - "Skill 的作用域与例外"
  outcome: |
    验收要求 Skill 具备明确触发条件、少量带例子的原则、作用域和例外；书中强调真实任务迭代而非一次成型。
  tags: [case, experiment, skill, writing, iteration]

- id: c011
  title: 状态栏将长历史统计变成常量查询
  type: case
  source_chapter: "第 2 章 2.6，实验 2-8、实验 2-9"
  source_quote: |
    “最弱的几个模型准确率能涨 40 到 54 个百分点，一个 2B 的本地小模型在这类任务上甚至直接追平了不带状态栏的前沿大模型。”
  summary: |
    作者先用退款客服轨迹可视化有无状态栏的注意力差异，再实现时间戳、工具计数、TODO 等五种状态栏技术并做专项基准。
  bound_to:
    - "显式状态替代反复扫描长轨迹"
    - "用确定性代码维护元信息"
  outcome: |
    弱模型准确率提升 40-54 个百分点；强模型思考量、延迟和花费约降一个数量级。LLM 批量维护状态栏反而不如短代码可靠。
  tags: [case, experiment, status-bar, context-distillation, efficiency]

- id: c012
  title: 六种上下文压缩策略对比
  type: case
  source_chapter: "第 2 章 2.7.4，实验 2-10"
  source_quote: |
    “实验 2-10 ★★★：上下文压缩策略对比”
  summary: |
    作者把 OpenAI 联合创始人职业状态追踪任务限制在 128K 窗口，对比无压缩、个体摘要、组合摘要和任务感知策略。
  bound_to:
    - "按任务目标压缩上下文"
    - "以完成率、迭代数和 token 联合评价压缩"
  outcome: |
    无压缩在第五轮溢出；个体摘要能完成但耗费 12 轮和 276,608 token；组合摘要降到 10 轮和 93,449 token，仍有截断风险。
  tags: [case, experiment, context-compression, long-horizon]

- id: c013
  title: 三层记忆评估与四种表示对照
  type: case
  source_chapter: "第 3 章 3.1.1、3.1.3，实验 3-1、3-2"
  source_quote: |
    “实验 3-2 ★★：记忆策略的对比实验研究”
  summary: |
    作者先构建基础回忆、多会话关联和主动服务三层共 60 个用例，再在统一接口下比较四种记忆格式。
  bound_to:
    - "先建分层评估再选记忆结构"
    - "记忆表示的成本—能力权衡"
  outcome: |
    Simple Notes 低成本覆盖基础回忆；Advanced JSON Cards 在消歧和跨会话关联上最好，但维护更慢、更贵。
  tags: [case, experiment, memory, evaluation, representation]

- id: c014
  title: Mem0 从写入消歧迁移到检索时推理
  type: case
  source_chapter: "第 3 章 3.1.6 记忆框架案例"
  source_quote: |
    “这样既避免错误 UPDATE/DELETE 丢失历史，又减少 LLM 调用，还能用多种检索信号和时间排序找出当前事实。”
  summary: |
    作者以 Mem0 v2 到 v3 的演进说明：冲突事实不必在写入时不可逆覆盖，可以只追加保存，在查询时融合语义、关键词、实体和时间信号。
  bound_to:
    - "不可变事实日志与检索时消歧"
    - "记忆更新的可追溯性"
  outcome: |
    Mem0 报告 LoCoMo 从 71.4 升至 92.5，LongMemEval 从 67.8 升至 94.4，同时减少写入阶段的 LLM 调用。
  tags: [case, framework-case, memory, append-only, retrieval]

- id: c015
  title: 本地小模型脱敏敏感日志
  type: case
  source_chapter: "第 3 章 3.1.8，实验 3-3"
  source_quote: |
    “相比传统正则表达式，基于 LLM 的脱敏召回率达 95% 以上，同时显著降低了假阳性。”
  summary: |
    log-sanitization 项目用本地 Qwen3 0.6B 检测结构化、半结构化和自然语言 PII，以避免把待脱敏日志发送到云端。
  bound_to:
    - "隐私任务优先本地推理"
    - "规则过滤与小模型语义检测混合"
  outcome: |
    书中报告召回率超过 95% 且假阳性显著降低，并建议高吞吐场景用正则初筛、LLM 深检。
  tags: [case, experiment, privacy, pii, local-model]

- id: c016
  title: ANNOY 与 HNSW 向量索引对照
  type: case
  source_chapter: "第 3 章 3.2.2，实验 3-4"
  source_quote: |
    “实验 3-4 ★★：构建向量检索服务：ANN 索引算法的比较研究”
  summary: |
    dense-embedding 项目在同一服务中切换两种近似最近邻索引，比较构建速度、内存、增量更新、查询精度与适用场景。
  bound_to:
    - "以工作负载选择向量索引"
    - "检索系统的多维权衡"
  outcome: |
    实验产出两类索引的可比运行记录；正文给出定性权衡，未报告单一优胜算法或统一量化结果。
  tags: [case, experiment, ann, vector-search, retrieval]

- id: c017
  title: 从零实现 BM25 以暴露检索计算过程
  type: case
  source_chapter: "第 3 章 3.2.3，实验 3-5"
  source_quote: |
    “项目的核心价值不在于性能的极致优化，而在于过程的完全透明化。”
  summary: |
    作者从分词、停用词、倒排索引到 TF-IDF 和 BM25 得分完整实现稀疏搜索，用可手算的小语料显示每一步贡献。
  bound_to:
    - "用透明实现理解检索机制"
    - "稀疏检索的精确词匹配"
  outcome: |
    项目能够逐项打印“模型蒸馏”等查询的命中和得分贡献；它是机制教学实验，不以生产吞吐为结论。
  tags: [case, experiment, bm25, sparse-retrieval, interpretability]

- id: c018
  title: 稠密、稀疏与重排序的混合检索
  type: case
  source_chapter: "第 3 章 3.2.4，实验 3-6"
  source_quote: |
    “没有哪种单一检索策略在所有场景下都可靠。把稠密、稀疏和重排序组合起来，才是构建生产级 RAG 系统的正确做法。”
  summary: |
    retrieval-pipeline 用语义近义、精确名称、多语言和技术代码等测试，记录两路召回与神经重排前后的排名变化。
  bound_to:
    - "互补检索与候选重排"
    - "按查询类型分析失效边界"
  outcome: |
    重排器能把单一路径低估的高相关文档提升到顶部；实验显示单一策略不能覆盖所有测试类型。
  tags: [case, experiment, hybrid-retrieval, reranking, rag]

- id: c019
  title: 黑白猫统计与 Xfinity 规则抽象
  type: case
  source_chapter: "第 3 章 3.3 结构化知识案例"
  source_quote: |
    “案例一： 黑猫白猫的计数问题。”
  summary: |
    作者用跨文档计数和职业优惠两个构造案例说明，原始案例平铺会受 top-k 截断、相似度偏差和跨文档聚合错位影响。
  bound_to:
    - "索引期知识提炼"
    - "从个案抽象统计与规则"
  outcome: |
    把 100 个个案预先压成统计摘要、把三个优惠个案提炼成资格规则后，一次检索即可返回完整结论。
  tags: [case, book-case, knowledge-abstraction, rag, aggregation]

- id: c020
  title: RAPTOR 与 GraphRAG 检索英特尔手册
  type: case
  source_chapter: "第 3 章 3.3.1，实验 3-7"
  source_quote: |
    “实验 3-7 ★★★：结构化索引：RAPTOR 与 GraphRAG 的知识组织哲学”
  summary: |
    structured-index 项目在数千页英特尔 CPU 手册上，用同一查询比较树状摘要下钻与知识图谱关系遍历。
  bound_to:
    - "按问题结构选择知识索引"
    - "层次导航与关系推理互补"
  outcome: |
    SSE 查询显示 RAPTOR 更适合宏观到细节，GraphRAG 更适合实体关系；组合使用通常优于机械单选。
  tags: [case, experiment, raptor, graphrag, structured-index]

- id: c021
  title: 司法问答中的 Agentic RAG 对照
  type: case
  source_chapter: "第 3 章 3.3.4，实验 3-8"
  source_quote: |
    “实验 3-8 ★★：智能体化 RAG 与非智能体化 RAG 的对比研究”
  summary: |
    作者在中文司法问答集上切换传统单次检索和 Agent 自主分解、评估、二次检索的模式，区分简单与多跳问题。
  bound_to:
    - "按问题复杂度选择 Agentic RAG"
    - "检索作为可迭代行动"
  outcome: |
    单一信息需求中传统 RAG 更快且质量相近；复杂量刑问题中 Agentic RAG 以更多延迟换取更高鲁棒性和准确率。
  tags: [case, experiment, agentic-rag, legal, multi-hop]

- id: c022
  title: 从对话分块到双层用户记忆
  type: case
  source_chapter: "第 3 章 3.3.4、3.3.5，实验 3-9、3-11"
  source_quote: |
    “实验 3-11 ★★★：利用上下文感知检索增强用户记忆”
  summary: |
    实验先把完整对话作为可搜索知识库，暴露孤立分块无法判断冲突指令的问题；再给分块补人物、时间与意图前缀，并与 JSON Cards 组合。
  bound_to:
    - "结构化概览与原始证据双层记忆"
    - "上下文前缀辅助冲突消歧"
  outcome: |
    Agent 能区分多辆车、判断多次电汇修改的先后，并把机票与护照到期日关联起来主动提示风险。
  tags: [case, experiment, user-memory, contextual-retrieval, conflict]

- id: c023
  title: 上下文前缀降低 RAG 检索失败
  type: case
  source_chapter: "第 3 章 3.3.5，实验 3-10"
  source_quote: |
    “实验 3-10 ★★：上下文感知检索：解决 RAG 的上下文丢失问题”
  summary: |
    项目并行构建传统分块与 LLM 生成上下文前缀的知识库，用同一查询比较 ACME 财报等歧义文本块的召回。
  bound_to:
    - "在索引期补足文本块身份"
    - "以 recall 指标验收分块策略"
  outcome: |
    上下文块得分与定位更精准；书中引用 Anthropic 数据报告结合 BM25 和重排可分别降低 49% 与 67% 的失败率。
  tags: [case, experiment, contextual-retrieval, chunking, rag]

- id: c024
  title: 从司法判例提取隐性决策知识
  type: case
  source_chapter: "第 3 章 3.3.6，实验 3-12"
  source_quote: |
    “实验 3-12 ★★★：从结构化数据中提取隐性知识：以司法判例分析为例”
  summary: |
    作者让 LLM 从 CAIL2018 判例自下而上发现影响判决的因子，再把案件编码、聚类成原型，并据因子重要性驱动追问。
  bound_to:
    - "从数据集发现结构化知识"
    - "知识驱动的主动信息收集"
  outcome: |
    系统形成核心与罪名扩展模式、案件原型和因子层次，使法律顾问能按重要性补齐事实并给出有判例支撑的分析。
  tags: [case, experiment, knowledge-extraction, legal, clustering]

- id: c025
  title: 感知工具 MCP 交互闭环
  type: case
  source_chapter: "第 4 章 4.4，实验 4-1"
  source_quote: |
    “实验 4-1 ★★：感知工具 MCP 服务器”
  summary: |
    实验实现感知型 MCP 服务器，以天气查询等工具跑通能力发现、schema 获取、标准调用和结果返回的完整协议。
  bound_to:
    - "工具互操作的标准协议"
    - "能力发现与调用分层"
  outcome: |
    项目以端到端调用成功和标准化工具定义为验收；正文未报告统一性能指标。
  tags: [case, experiment, mcp, perception-tool, interoperability]

- id: c026
  title: 多模态信息提取三路线对照
  type: case
  source_chapter: "第 4 章 4.4.1，实验 4-2"
  source_quote: |
    “实验 4-2 ★★：多模态信息提取：三种技术范式的对比分析”
  summary: |
    multimodal-agent 把同一 PDF 和问题交给原生视觉、文本提取和工具化按需分析三种模式，控制输入以比较能力和成本。
  bound_to:
    - "按信息模态选择感知路径"
    - "质量、成本与交互性的权衡"
  outcome: |
    原生模式最擅长图表和布局；文本模式最适合纯文字；工具化模式成本灵活但不如原生端到端深度理解。
  tags: [case, experiment, multimodal, document-understanding, cost]

- id: c027
  title: Claude Code 的 Sidecar 安全审查
  type: case
  source_chapter: "第 4 章 4.5 执行工具"
  source_quote: |
    “主模型发出一个工具调用后还在继续生成后续文本时，Sidecar 的审查已经同步开始；但对被审查的那次工具调用而言，Sidecar 起门控作用。”
  summary: |
    作者以 Claude Code Auto Mode 为例，说明独立轻量模型只读取结构化工具字段并并行判定风险，而不共享可被注入的完整思考上下文。
  bound_to:
    - "高风险动作的独立审查"
    - "结构化最小输入降低提示注入"
  outcome: |
    危险操作在放行前不会执行；简单分类可在数百毫秒完成，并通过并行运行降低用户感知延迟。
  tags: [case, product-case, sidecar, safety, tool-approval]

- id: c028
  title: 执行工具的安全与自动验证服务器
  type: case
  source_chapter: "第 4 章 4.5，实验 4-3"
  source_quote: |
    “实验 4-3 ★★：执行工具 MCP 服务器”
  summary: |
    实验把文件、终端、解释器、数据、外部系统和 GUI 工具放进同一 MCP 服务，并为每类动作配置验证、超时、审查或沙箱。
  bound_to:
    - "执行后自动验证"
    - "按风险分层的工具安全"
  outcome: |
    验收要求危险命令被审查、文件修改自动 lint、长输出被截断并持久化；正文未报告统一完成率。
  tags: [case, experiment, execution-tool, verification, sandbox]

- id: c029
  title: 子 Agent 与人类协作工具服务器
  type: case
  source_chapter: "第 4 章 4.6，实验 4-4"
  source_quote: |
    “实验 4-4 ★★：协作工具 MCP 服务器”
  summary: |
    实验构建子 Agent 生命周期、人类审批、输入请求和多渠道通知工具，并比较最小参数移交与 LLM 提炼上下文。
  bound_to:
    - "协作工具的明确契约"
    - "移交上下文的最小充分性"
  outcome: |
    验收要求系统识别何时请求人工、支持超时默认行为并能管理同步/异步子任务；未报告统一量化结果。
  tags: [case, experiment, collaboration, subagent, hitl]

- id: c030
  title: PineClaw 用实时 Channel 替代定时轮询
  type: case
  source_chapter: "第 4 章 4.7.2 OpenClaw 的事件驱动机制实现"
  source_quote: |
    “当电话接通、需要用户输入、通话结束等关键事件发生时，消息被即时推送到 OpenClaw Agent，Agent 立即处理并通知用户。”
  summary: |
    Pine AI 电话任务中的验证码、三方通话和方案确认无法等待 Heartbeat；团队在 OpenClaw Gateway 与 Pine API 间建立实时事件通道。
  bound_to:
    - "外部事件驱动的主动服务"
    - "实时业务避免轮询延迟"
  outcome: |
    Channel 让关键通话事件即时到达 Agent，避免因定时轮询错过客服等待窗口而导致通话失败。
  tags: [case, production-case, pine-ai, event-driven, realtime]

- id: c031
  title: 从串行邮件事件到可打断异步 Agent
  type: case
  source_chapter: "第 4 章 4.7.6、4.7.7，实验 4-5、4-6"
  source_quote: |
    “实验 4-6 ★★★：带并行执行和打断能力的异步 Agent”
  summary: |
    第一阶段统一接入邮件、IM、GitHub、定时器等事件并串行处理；第二阶段加入占位符、并行执行、进度查询、取消、打断和恢复。
  bound_to:
    - "同步模型上的异步运行时"
    - "事件队列、取消与状态恢复"
  outcome: |
    邮件场景能自动处理会议、投诉和广告；并行场景中 Agent 在首任务完成后查询进度、取消慢任务并整合其余结果。
  tags: [case, experiment, async-agent, interruption, cancellation]

- id: c032
  title: 小模型主动发现 120+ 工具
  type: case
  source_chapter: "第 4 章 4.8.1，实验 4-7"
  source_quote: |
    “对照组：将所有 120+ 工具的完整 schema 一次性注入 system prompt（超 50K tokens）。”
  summary: |
    作者用 Qwen3-4B 比较全量工具注入与只保留少量元工具、在能力缺口出现时动态检索 3-5 个 schema 的方案。
  bound_to:
    - "主动工具发现"
    - "通过渐进披露控制工具上下文"
  outcome: |
    全量注入导致错选和遗忘工具；实验预期动态发现显著提升准确率和完成率，正文未给出最终量化表。
  tags: [case, experiment, tool-discovery, small-model, progressive-disclosure]

- id: c033
  title: Manus 与 OpenClaw 的 Coding 内核
  type: case
  source_chapter: "第 5 章 5.1.2 案例：从 Manus 到 OpenClaw"
  source_quote: |
    “Coding Agent 加上文件系统，是开放任务型通用 Agent 最核心的技术基础。”
  summary: |
    作者对照 Manus 和 OpenClaw，指出 PPT、报告、数据分析、API 适配与可复用浏览器流程最终都可落到代码和文件 artifact。
  bound_to:
    - "代码作为通用 Agent 元能力"
    - "文件系统作为可组合工作空间"
  outcome: |
    多类产品实践显示代码路径通常比 GUI 操作更低成本、低延迟、稳定且可复用，形成通用 Agent 的能力基座。
  tags: [case, product-case, coding-agent, filesystem, artifact]

- id: c034
  title: 代码辅助数学与逻辑求解
  type: case
  source_chapter: "第 5 章 5.2.1，实验 5-1、实验 5-2"
  source_quote: |
    “使用 K&K Puzzle 数据集评测，代码辅助模式求解准确率达 90% 以上，显著高于纯思考模式。”
  summary: |
    实验让 Agent 把数学题转成 SymPy/NumPy/SciPy 计算，把骑士与无赖谜题转成约束求解，再与纯思维链对照。
  bound_to:
    - "把可形式化推理交给代码"
    - "模型与 Harness 的能力互补"
  outcome: |
    逻辑题代码辅助模式达到 90% 以上；书中指出弱模型获益更大，强模型上脚手架边际增益收窄。
  tags: [case, experiment, code-interpreter, math, constraint-solving]

- id: c035
  title: 代码化航空政策约束小模型
  type: case
  source_chapter: "第 5 章 5.2.2，实验 5-3"
  source_quote: |
    “实验 5-3 ★★：小模型通过代码化知识提升执行规则的准确性”
  summary: |
    作者在 τ-bench 航空客服中对比纯自然语言政策与“自然语言 + 参数 checklist + 服务端真值校验”的三重保障。
  bound_to:
    - "自然语言理解与代码硬约束分工"
    - "服务端真值校验"
  outcome: |
    实验预期三重保障降低违规和无效调用，并用模型自报值与数据库真值的差异检验拦截必要性；正文未报告最终数表。
  tags: [case, experiment, policy, code-validation, small-model]

- id: c036
  title: 提议者—审核者生成 PPT 与讲解视频
  type: case
  source_chapter: "第 5 章 5.2.3，实验 5-4、实验 5-5"
  source_quote: |
    “实验 5-4 ★★：基于论文的 PPT 自动生成”
  summary: |
    Proposer 从论文生成 Slidev 代码，Reviewer 通过渲染截图检查并迭代；同一产物再配讲解稿、TTS 和 ffmpeg 扩展成视频。
  bound_to:
    - "跨模态产物的独立审核"
    - "代码驱动的可验证内容生成"
  outcome: |
    验收覆盖页数、论文贡献、图表一致、无溢出，以及视频时长与语音同步；未报告统一质量得分。
  tags: [case, experiment, proposer-reviewer, ppt, video]

- id: c037
  title: 视觉反馈驱动的 API 视频剪辑
  type: case
  source_chapter: "第 5 章 5.2.3，实验 5-6"
  source_quote: |
    “将视频分析封装为子 Agent 避免大量截图占用主 Agent 上下文。”
  summary: |
    Agent 先粗粒度再逐秒定位场景，生成 Blender Python 脚本；Reviewer 渲染关键帧并触发修正，最后完整输出。
  bound_to:
    - "粗到细的多模态定位"
    - "子 Agent 上下文隔离与视觉验收"
  outcome: |
    验收要求剪辑边界误差不超过 3 秒、效果正确、明显遗漏能触发修正；正文未报告批量实测结果。
  tags: [case, experiment, video-editing, subagent, visual-verification]

- id: c038
  title: 日志解析自适应与生产轨迹诊断
  type: case
  source_chapter: "第 5 章 5.2.4，实验 5-7、实验 5-8"
  source_quote: |
    “前端检测解析失败 → 报告 Agent → 生成解析代码 → 虚拟浏览器测试 → 热更新部署。”
  summary: |
    一组实验让解析器在新格式失败时自动生成并测试适配代码；另一组从生产轨迹定位问题、生成回归用例并创建 GitHub Issue。
  bound_to:
    - "代码作为系统适配器"
    - "从生产日志到可重放回归"
  outcome: |
    验收要求新解析代码通过自动测试后热更新，诊断报告能关联轨迹 ID、模块和回归验证；未报告统一成功率。
  tags: [case, experiment, log-analysis, self-adaptation, regression]

- id: c039
  title: 作者用交互式网站维护研究活文档
  type: case
  source_chapter: "第 5 章 5.2.5 代码作为生成式 UI"
  source_quote: |
    “以笔者自己写论文的经历为例： 每个研究项目笔者都会维护一个交互式网站”
  summary: |
    作者让 Agent 随实验推进持续更新研究网站，在同一可视化载体中展示原始回复、judge 分数、训练曲线和系统结构。
  bound_to:
    - "生成式 UI 作为研究基础设施"
    - "把过程证据与最终交付统一"
  outcome: |
    网站帮助追溯数据和 Prompt、识别评分偏差、监控训练异常，并向读者解释系统运行原理。
  tags: [case, author-practice, research, generative-ui, observability]

- id: c040
  title: 动态表单一次性澄清机票需求
  type: case
  source_chapter: "第 5 章 5.2.5，实验 5-9"
  source_quote: |
    “实验 5-9 ★★：动态表单生成的意图澄清系统”
  summary: |
    实验把多轮文本追问改成按当前请求生成的 HTML 表单，用级联字段表达单程/往返等依赖关系。
  bound_to:
    - "代码生成作为交互界面"
    - "用结构化输入降低澄清轮次"
  outcome: |
    验收场景要求用户一次提交出发城市、日期、旅行类型和条件返程日期；正文未报告规模化用户结果。
  tags: [case, experiment, dynamic-form, intent-clarification, ui]

- id: c041
  title: 自然语言查询 ERP 数据
  type: case
  source_chapter: "第 5 章 5.2.5，实验 5-10"
  source_quote: |
    “AI Agent 可将用户自然语言查询转换成 SQL 语句，实现自动化查询。”
  summary: |
    作者构建员工和工资 PostgreSQL 数据库，用十类跨时间、部门、级别和欠薪问题检验自然语言到 SQL 的 artifact 路径。
  bound_to:
    - "LLM 只生成查询、数据直达界面"
    - "代码 artifact 避免模型复述大表"
  outcome: |
    以 SQL 正确执行并回答十类 ERP 问题为验收；正文未报告统一准确率。
  tags: [case, experiment, erp, sql, artifact]

- id: c042
  title: 对话即时改写软件界面
  type: case
  source_chapter: "第 5 章 5.2.5，实验 5-11"
  source_quote: |
    “实验 5-11 ★★：对话式界面定制系统”
  summary: |
    实验用 React HMR 和 FastAPI reload 让 Agent 依据自然语言持续修改颜色、字体、布局和组件位置。
  bound_to:
    - "生成式 UI 与热加载反馈"
    - "自然语言驱动的软件定制"
  outcome: |
    验收要求用户能多轮定制并实时看到结果；书中随后以该案例引出动态代码不能承载最终权限边界。
  tags: [case, experiment, ui-generation, hot-reload, customization]

- id: c043
  title: 权限内嵌数据对象抵御动态代码越权
  type: case
  source_chapter: "第 5 章 5.2.5，实验 5-12"
  source_quote: |
    “实验 5-12 ★★★：动态生成软件的权限内嵌数据对象”
  summary: |
    实验让模型分别为裸 SQL 和带权限内嵌对象接口生成对抗操作，把权限、校验、租户隔离和引用完整性下沉到稳定数据层。
  bound_to:
    - "动态代码之外的稳定信任边界"
    - "数据层强制权限与完整性"
  outcome: |
    合法招聘流程成功；越过状态机、越界工资和跨租户读取被拒绝，核心权限与完整性测试通过。
  tags: [case, experiment, data-security, authorization, generated-code]

- id: c044
  title: 基于参考实现创造新 Agent
  type: case
  source_chapter: "第 5 章 5.2.6，实验 5-13"
  source_quote: |
    “Agent 首先复制这个范例代码，然后基于用户的具体需求进行针对性修改。”
  summary: |
    Meta-Agent 不从零搭建系统，而是读取成熟 Agent 的消息格式、工具协议和状态管理结构，再按需求做局部改造。
  bound_to:
    - "Agent 自举"
    - "参考实现优于从零生成"
  outcome: |
    验收要求新 Agent 可运行、能完成基本任务并保持多轮状态；实验对比从零生成与基于范例修改的质量和效率。
  tags: [case, experiment, meta-agent, bootstrapping, reference-implementation]

- id: c045
  title: 退款客服轨迹的四维 Rubric
  type: case
  source_chapter: "第 6 章 6.1 一个具体的评估示例"
  source_quote: |
    “6.1 一个具体的评估示例”
  summary: |
    作者用三天前的 299 元耳机退款轨迹，分别检查订单状态、政策、到账信息与工具结果一致性，展示如何把一次任务拆成可验证维度。
  bound_to:
    - "结果与过程的多维评估"
    - "Rubric 的具体评分档次"
  outcome: |
    该示例四维均为满分，且因订单、金额、时间和退款编号均由工具结果支撑，没有触发幻觉否决。
  tags: [case, book-case, rubric, customer-service, evaluation]

- id: c046
  title: τ²-bench 的双控制评估
  type: case
  source_chapter: "第 6 章 6.3.3，实验 6-1"
  source_quote: |
    “观察用户模拟器与 Agent 的多轮对话，分析典型的失败模式（政策违规、信息遗漏、过度转接人工等）。”
  summary: |
    实验运行 τ²-bench 并与 τ-bench 比较，检查用户模拟器如何渐进透露信息，以及环境状态与对话确认如何共同定义成功。
  bound_to:
    - "人机交互型评估环境"
    - "数据集随失败模式迭代"
  outcome: |
    实验以成功状态和必需对话信息双重验收，并产出政策、遗漏和转人工等失败分析；正文未给出统一复现分数。
  tags: [case, experiment, tau-bench, simulator, evaluation]

- id: c047
  title: 亲手执行六类 Agent 基准
  type: case
  source_chapter: "第 6 章 6.4，实验 6-2"
  source_quote: |
    “从 GAIA、AndroidWorld、SWE-Bench Verified、τ²-bench、Terminal-Bench、OSWorld-Verified 中各挑选任务亲手完成。”
  summary: |
    作者要求评估设计者亲自做简单、中等、困难任务，再与标准答案对比，以暴露任务描述、环境和验证器对人的真实要求。
  bound_to:
    - "基准设计前的人类可行性检查"
    - "任务清晰度与难度校准"
  outcome: |
    产出六类基准的人工执行记录与差异归因；该实验以建立设计直觉为目标，不设统一模型分数。
  tags: [case, experiment, benchmark, human-baseline, dataset-design]

- id: c048
  title: 用户记忆的端到端与边界评估矩阵
  type: case
  source_chapter: "第 6 章 6.5.3，实验 6-3、实验 6-4、实验 6-5"
  source_quote: |
    “实验 6-4 ★★：Advanced JSON Cards 与 RAG 的对比评估”
  summary: |
    作者先构建 Rubric 评分器，再以 60 题比较 JSON Cards、RAG 和混合方案；随后冻结同一上下文，用 11 个边界任务比较三种等语义表示。
  bound_to:
    - "端到端评估与轨迹前缀评估互补"
    - "复杂系统组合不保证自然增益"
  outcome: |
    JSON Cards、RAG、混合总体成功率为 68.3%、48.3%、66.7%；边界实验三种表示均为 6/11，但失败位置不同。
  tags: [case, experiment, memory, trajectory-prefix, evaluation]

- id: c049
  title: 多模态 Judge 评估 TTS
  type: case
  source_chapter: "第 6 章 6.5.4，实验 6-6"
  source_quote: |
    “实验 6-6 ★★：构建全自动 TTS 质量评估流水线”
  summary: |
    实验用准确性、自然度、情感和音色一致性 Rubric，让多模态模型直接听 OpenAI 与 Fish Audio 的八条样本。
  bound_to:
    - "多模态 LLM-as-a-Judge"
    - "用维度化评分避免总分遮蔽差异"
  outcome: |
    两者准确性与自然度均为 5.00/4.00；Fish Audio 情感和音色为 4.00/3.00，OpenAI 为 3.75/2.75。作者明确限制样本太小，不能判定总体优劣。
  tags: [case, experiment, tts, llm-judge, multimodal]

- id: c050
  title: 从 Arena 配对投票重建模型排行
  type: case
  source_chapter: "第 6 章 6.5.4，实验 6-7"
  source_quote: |
    “使用 Chatbot Arena 开源的真实投票数据集（包含数百万次用户盲选投票）。”
  summary: |
    作者实现在线 Elo 更新、两两胜率矩阵和历史排名动画，并与官方 Bradley-Terry 极大似然榜单比较。
  bound_to:
    - "开放输出的配对比较"
    - "区分在线 Elo 与全局拟合"
  outcome: |
    验收是总体排名与官方榜单大体一致而非逐分对齐，并用时间切片识别模型突破和生命周期。
  tags: [case, experiment, elo, pairwise-comparison, ranking]

- id: c051
  title: 固定 Harness 测量模型行动阈值
  type: case
  source_chapter: "第 6 章 6.6.2，实验 6-8"
  source_quote: |
    “实验 6-8 ★★：在固定 Coding Harness 中测量模型的行动阈值”
  summary: |
    作者固定提示、工具、仓库、测试和轮次，让两种 Coding 模型各跑九条轨迹，隔离“继续探索还是开始编辑”的模型默认策略。
  bound_to:
    - "模型行为策略的控制变量测量"
    - "路径效率与最终质量分开评价"
  outcome: |
    GPT 更晚行动，但两者补丁与测试均 100% 通过，首次修改时间也接近；实验只支持策略随模型变化，不支持“多读必然更好”。
  tags: [case, experiment, coding-agent, model-selection, action-threshold]

- id: c052
  title: Agent 任务全链路成本拆解
  type: case
  source_chapter: "第 6 章 6.6.3，实验 6-9"
  source_quote: |
    “记录每次 LLM 调用的输入/输出 token 数、思考 token 数、工具调用次数和返回大小、端到端延迟。”
  summary: |
    实验复现固定八轮任务并替换为真实工作负载，通过四种开关组合分析 token、工具结果和延迟的成本贡献。
  bound_to:
    - "模型选型中的端到端成本"
    - "用 p50/p95/p99 描述成本分布"
  outcome: |
    验收是生成成本构成报告并识别主要驱动因素；正文未报告统一节省比例。
  tags: [case, experiment, cost-analysis, observability, model-selection]

- id: c053
  title: 多维模型性能基准数据库
  type: case
  source_chapter: "第 6 章 6.6.4，实验 6-10"
  source_quote: |
    “对主流 LLM 及不同 API 提供商进行全面基准测试，建立多维度模型选型决策数据库。”
  summary: |
    作者设计横跨闭源与开源模型、不同提供商的自有任务测试，避免只用公开榜单选型。
  bound_to:
    - "用自有任务进行模型选型"
    - "质量、延迟、成本联合决策"
  outcome: |
    实验产出版本化选型数据库；正文未提供跨读者统一排名，强调结果应随模型和 API 更新持续重跑。
  tags: [case, experiment, benchmark, model-selection, database]

- id: c054
  title: 用户记忆系统的三点联合选型
  type: case
  source_chapter: "第 6 章 6.6.4，实验 6-11"
  source_quote: |
    “看嵌入模型、reranker、Agent 主模型三个选择点如何共同影响检索质量、延迟与成本。”
  summary: |
    实验在 60 个记忆用例上遍历嵌入、是否重排和主模型配置，测量组件间替代与互补关系。
  bound_to:
    - "端到端系统选型而非单组件榜单"
    - "测量组件边际价值"
  outcome: |
    书中给出的发现是更强嵌入可能使重排多余，更强主模型可能弥补检索不足；未报告完整矩阵数字。
  tags: [case, experiment, memory, reranker, system-selection]

- id: c055
  title: AndroidWorld 从诊断到分阶段改进
  type: case
  source_chapter: "第 6 章 6.9、6.10，实验 6-12"
  source_quote: |
    “实验 6-12 ★★★：AndroidWorld 的评估和改进”
  summary: |
    作者从 116 个任务的历史报告识别能力簇，提出表层、中层、深层假设，每轮只改一个变量并保留成本与回退证据。
  bound_to:
    - "观察—假设—实验—验证"
    - "按成本收益选择局部部署"
  outcome: |
    导航、转录和计数针对性修复显著提升对应成功率，但各自增加 token 或延迟，说明不能把所有有效改动全量部署。
  tags: [case, experiment, androidworld, hypothesis-testing, ablation]

- id: c056
  title: OpenVLA 与 RoboTwin2 具身环境配置
  type: case
  source_chapter: "第 6 章 6.11，实验 6-13"
  source_quote: |
    “运行预训练模型评估，记录成功率、完成时间和失败模式，重点关注动作分块机制的影响。”
  summary: |
    实验配置三视角 RGB、关节状态和 14 维动作的仿真环境，为后训练章节建立可重置、可测量的机器人任务场地。
  bound_to:
    - "评估环境与训练环境复用"
    - "具身 Agent 的观察—动作契约"
  outcome: |
    产出预训练基线、时间和失败模式记录；正文未给出统一成功率，重点是跑通可复现实验环境。
  tags: [case, experiment, openvla, robotwin, embodied-ai]

- id: c057
  title: 寻宝游戏中的 Q-learning 与 LLM Agent 对照
  type: case
  source_chapter: "第 7 章 7.2、7.2.2，实验 7-1、实验 7-2"
  source_quote: |
    “实验 7-1 ★：Q-learning 在寻宝游戏中的表现”
  summary: |
    作者构造带钥匙、门、物品合成和稀疏奖励的寻宝环境，先训练表格 Q-learning，再与具备语言先验的 LLM Agent 比较状态与动作表示。
  bound_to:
    - "经典 RL 的样本效率边界"
    - "预训练先验对 Agent 探索的价值"
  outcome: |
    Q-learning 约 7000-8000 轮才快速起效，10000 轮达到满胜率和 11 步最优解；仿真只需十秒，但真实任务无法承受同量级试错。
  tags: [case, experiment, q-learning, llm-agent, sample-efficiency]

- id: c058
  title: MiniMind 算法改进缩短从头训练
  type: case
  source_chapter: "第 7 章 7.3，实验 7-3"
  source_quote: |
    “实验 7-3 ★★：从头训练 LLM——算法改进的威力”
  summary: |
    作者以一亿参数 MiniMind 为例，在消费级 GPU 上跑通预训练、SFT 和偏好优化，观察每阶段分别改变知识、格式与表达。
  bound_to:
    - "固定预算下优先算法改进"
    - "分阶段训练目标拆分"
  outcome: |
    收敛提速 3 倍，约 14 小时和 34 美元完成；预训练获得事实能力，SFT 改善指令格式，偏好优化减少错误和不自然表达。
  tags: [case, experiment, pretraining, minimind, optimization]

- id: c059
  title: 轻量投影层对齐视觉与语言
  type: case
  source_chapter: "第 7 章 7.3，实验 7-4"
  source_quote: |
    “实验 7-4 ★★：自己训练 VLM”
  summary: |
    实验冻结 CLIP 视觉编码器和 MiniMind 语言模型，先训练约 40 万参数投影层，再解冻语言模型做高质量图文 SFT。
  bound_to:
    - "复用预训练组件进行跨模态对齐"
    - "分阶段解冻避免灾难性遗忘"
  outcome: |
    投影预训练建立基础图文对齐，解冻 SFT 后描述细节和准确性显著改善；书中同时指出投影层可能成为深层理解瓶颈。
  tags: [case, experiment, vlm, multimodal-alignment, sft]

- id: c060
  title: 用混合语料为 Mistral 注入韩语能力
  type: case
  source_chapter: "第 7 章 7.3，实验 7-5"
  source_quote: |
    “实验 7-5 ★★：继续预训练学习新语言”
  summary: |
    实验对英语为主的 Mistral 7B 继续使用韩语维基百科预训练，再以韩语指令数据 SFT，同时混入英语保持旧能力。
  bound_to:
    - "继续预训练注入大量领域知识"
    - "混合数据缓解灾难性遗忘"
  outcome: |
    模型获得实用韩语对话能力且尽量保留英语；该案例支持“大量新知识靠继续预训练而非仅靠 SFT”。
  tags: [case, experiment, continual-pretraining, multilingual, forgetting]

- id: c061
  title: 语音 SFT 固化音色与副语言协议
  type: case
  source_chapter: "第 7 章 7.4，实验 7-6"
  source_quote: |
    “实验 7-6 ★★★：语音 SFT——从“声音复制”到“副语言建模”[扩展实验]”
  summary: |
    作者对照参考音频条件化的 voice cloning 与 laugh/sigh 等特殊标记，说明 SFT 更适合固化表达协议和风格控制。
  bound_to:
    - "SFT 适合结构化表达习惯"
    - "音色与副语言能力的参数化"
  outcome: |
    案例展示跨句音色一致和控制标记发声；书中提醒说话者过少会同质化，标记过拟合会产生机械表达。
  tags: [case, experiment, speech, sft, paralinguistic]

- id: c062
  title: 未见中文样本仍泛化到中文思考
  type: case
  source_chapter: "第 7 章 7.4，实验 7-7"
  source_quote: |
    “实验 7-7 ★★★：多语言思考——让模型用任意语言思考 [扩展实验]”
  summary: |
    实验给 gpt-oss-20b 加 reasoning language 条件，以多种非中文语言思考样例做 SFT，测试控制协议能否跨语言组合泛化。
  bound_to:
    - "训练控制协议而非枚举所有取值"
    - "SFT 的组合泛化"
  outcome: |
    模型在未见中文训练样本时仍能按 Chinese 条件生成中文思维链，显示其学到的是语言选择协议。
  tags: [case, experiment, multilingual-reasoning, sft, zero-shot]

- id: c063
  title: Prompt 蒸馏折叠长提示与显式思考
  type: case
  source_chapter: "第 7 章 7.5，实验 7-8"
  source_quote: |
    “实验 7-8 ★★：Prompt 蒸馏——以更小开销复现可用能力”
  summary: |
    教师使用长系统提示和思考模式生成高质量输出，训练集只保留输入与最终结论，让学生以短提示或无提示直接回答。
  bound_to:
    - "稳定产品形态下的提示蒸馏"
    - "质量、延迟与可编辑性的权衡"
  outcome: |
    书中报告可在保持接近教师质量时显著降低成本，同规模“思考到非思考”可提速 20-30 倍，但会继承教师长尾错误。
  tags: [case, experiment, prompt-distillation, latency, cot]

- id: c064
  title: 开源教师的思维链蒸馏
  type: case
  source_chapter: "第 7 章 7.5，实验 7-9"
  source_quote: |
    “在同等参数量下可恢复教师 70%-80% 能力。”
  summary: |
    实验保留开源思考模型的完整轨迹做 SFT，把教师的中间推导转移给学生；并用“思维围墙”说明为何闭源摘要不适合作为同等监督。
  bound_to:
    - "用完整过程监督提升学生模型"
    - "蒸馏数据的可见性与许可边界"
  outcome: |
    书中给出的经验区间是同参数量恢复教师 70%-80% 能力；同时强调学生会继承教师的系统错误和冗长习惯。
  tags: [case, experiment, cot-distillation, teacher-student, open-model]

- id: c065
  title: AdaptThink 学会何时跳过思考
  type: case
  source_chapter: "第 7 章 7.7，实验 7-10"
  source_quote: |
    “实验 7-10 ★★：AdaptThink——学会“何时不思考””
  summary: |
    作者用约束优化和重要性采样训练模型在 Thinking 与 NoThinking 间路由，并公开 checkpoint-free 的训练过程与未完成边界。
  bound_to:
    - "让模型按难度分配思考预算"
    - "训练报告必须披露不完整与崩溃"
  outcome: |
    step 300 时 MATH500、GSM8K 长度降 67.90%、53.44%且准确率小升；AIME 长度降 47.17%但准确率微降。训练在 step 410 崩溃，未完成计划步数。
  tags: [case, author-experiment, adaptive-thinking, rl, efficiency]

- id: c066
  title: GeneralPoints 的 SFT 记忆与 RL 泛化对照
  type: case
  source_chapter: "第 7 章 7.7，实验 7-11"
  source_quote: |
    “视觉 OOD：RL 在 GP-VL 上 +17.6%（23.6%→41.2%），SFT 下降 9.9%（23.6%→13.7%）。”
  summary: |
    训练集固定 J/Q/K=10 和黑色花色，测试时改变牌面规则与花色；相同预算下扩展 SFT 或 PPO，测量语言与视觉 OOD。
  bound_to:
    - "用分布外测试区分记忆与泛化"
    - "SFT 初始化与 RL 探索互补"
  outcome: |
    三类 OOD 中 SFT 均下降、RL 均提升；但未经 SFT 的端到端 RL 在该小模型和严格格式设定下完全失败。
  tags: [case, experiment, sft, reinforcement-learning, ood]

- id: c067
  title: V-IRL-VL 跨城市视觉导航
  type: case
  source_chapter: "第 7 章 7.10，实验 7-12"
  source_quote: |
    “训练使用纽约路线，测试迁移到不同城市，并同时改变方向表达和视觉外观。”
  summary: |
    研究在真实街景中进行多轮导航，以规则、语言和视觉分布同时变化的测试检验策略是否会按新观察重新规划。
  bound_to:
    - "多轮策略的分布外重规划"
    - "逐步反馈缓解长时序信用分配"
  outcome: |
    RL 在规则和视觉 OOD 上明显优于 SFT；逐步反馈帮助多轮导航更快获得有效信用信号。
  tags: [case, research-case, visual-navigation, rl, multi-turn]

- id: c068
  title: SimpleVLA-RL 用结果奖励发现新动作
  type: case
  source_chapter: "第 7 章 7.10，实验 7-13"
  source_quote: |
    “实验 7-13 ★★★：SimpleVLA-RL——结果奖励下的开放探索 [扩展实验]”
  summary: |
    每个 LIBERO 任务只用一条演示轨迹做 SFT 冷启动，再以成功/失败结果训练，让模型在未预设最优路径时保留探索空间。
  bound_to:
    - "稀疏结果奖励用于开放探索"
    - "演示冷启动与 RL 发现新策略"
  outcome: |
    成功率由 17.3% 升至 91.7%，并产生人类演示未出现的“推切”操作，说明结果奖励可发现新行为。
  tags: [case, research-case, vla, sparse-reward, exploration]

- id: c069
  title: ReTool 在沙盒反馈中学会数学纠错
  type: case
  source_chapter: "第 7 章 7.10.2，实验 7-14"
  source_quote: |
    “实验 7-14 ★★★：ReTool——代码解释器增强数学解题”
  summary: |
    ReTool 在 SFT 预热后用 PPO 训练交织文本、代码和解释器返回的轨迹，让模型主动执行、读取错误并修正。
  bound_to:
    - "工具反馈进入训练轨迹"
    - "沙盒执行提升可验证推理"
  outcome: |
    AIME 2024 从约 25% 升至 67%；代价是约 9 天、400 步 RL，相比 SFT 约一小时的成本高得多。
  tags: [case, research-case, retool, code-interpreter, rl]

- id: c070
  title: A World-train 的多工具训练沙盒
  type: case
  source_chapter: "第 7 章 7.10.2，实验 7-15"
  source_quote: |
    “实验 7-15 ★★★：A World-train——在沙盒中学习使用工具”
  summary: |
    项目把 26 个 MCP 服务器、126 个工具、可重置 GAIA 任务和 GRPO/PPO 接到统一 VeRL 适配层，训练 Qwen3-4B。
  bound_to:
    - "可重置、可重放的多工具 RL 环境"
    - "分布式 rollout 提升环境吞吐"
  outcome: |
    分布式采样把预估周期从 7 天降到约 12 小时；实验目标是跑通工具组合训练链路，而非刷新 GAIA 榜单。
  tags: [case, experiment, mcp, tool-learning, distributed-rl]

- id: c071
  title: RL VP 奖励结果并惩罚路径
  type: case
  source_chapter: "第 7 章 7.11.4，实验 7-16"
  source_quote: |
    “实验 7-16 ★★★：RL VP——奖励结果、惩罚路径”
  summary: |
    实验在 GRPO 结果奖励之外加入路径信号，比较它在终端违规、形式化证明和软件修复三类可达性不同的任务上是否有效。
  bound_to:
    - "先检查过程信号可达性"
    - "结果奖励与路径约束分工"
  outcome: |
    TerminalBench 违规显著下降且成功率持平；miniF2F 达到 0.9 成功率的迭代由 7.0 降至 4.4；无 rollout 获得部分进展的软件修复没有收益。
  tags: [case, experiment, reward-design, process-signal, rl]

- id: c072
  title: 时间感 Agent 的在轨蒸馏
  type: case
  source_chapter: "第 7 章 7.12.1 On-Policy Distillation"
  source_quote: |
    “笔者和合作者曾在“时间感”任务上比较 DPO、四种 RL 与 On-Policy Distillation”
  summary: |
    作者与合作者在时间感任务中比较 DPO、四种 RL 与在轨蒸馏，让冻结的 Qwen3-32B 教师在学生自己的多轮轨迹上逐 token 提供密集监督。
  bound_to:
    - "昂贵环境交互中的密集学习信号"
    - "在轨蒸馏优于稀疏奖励的条件"
  outcome: |
    在四种条件下通过率比同源 SFT 高 23-47 个百分点，支持瓶颈常在每次交互信号过稀，而非奖励函数不够复杂。
  tags: [case, author-research, on-policy-distillation, temporal-agent, supervision]

- id: c073
  title: 三类生产 bad case 到后训练
  type: case
  source_chapter: "第 7 章 7.13.1-7.13.3，实验 7-17、实验 7-18、实验 7-19"
  source_quote: |
    “实验 7-17 ★★：从“过早结束”bad case 到 DPO 修复”
  summary: |
    作者把过早结束、中文引号作用域和 edit_file 精确复制三个生产问题，依次做首错归因、边界数据构造、LoRA/DPO 或 SFT，并设置保留集。
  bound_to:
    - "只有模型首错才进入参数训练"
    - "边界集与保留集双重验证"
  outcome: |
    过早结束实验提供 24 条训练 bad case 和 20 条隔离评估；另两项以作用域边界和 tokenizer 审计验收。正文将其定位为教学链路，未宣称生产级修复率。
  tags: [case, experiment, bad-case, dpo, sft]

- id: c074
  title: 客服轨迹验证器输出诊断证据
  type: case
  source_chapter: "第 8 章 8.1，实验 8-1"
  source_quote: |
    “实验 8-1 ★★：为客服 Agent 构建轨迹验证器”
  summary: |
    实验对照只输出总分与逐维度输出结论、证据、置信度的验证器，检查后者能否区分任务失败、违规、虚假承诺和表达问题。
  bound_to:
    - "学习信号必须可归因"
    - "低置信度案例不自动学习"
  outcome: |
    实验以诊断可分辨性为验收；结论是单一成功率不足以路由更新载体，低置信度结果应交给复核。
  tags: [case, experiment, trajectory-verifier, diagnosis, evolution]

- id: c075
  title: 从多条 GAIA 轨迹提炼经验文档
  type: case
  source_chapter: "第 8 章 8.2.1，实验 8-2"
  source_quote: |
    “实验 8-2 ★★：从 GAIA 轨迹提炼经验知识文档”
  summary: |
    作者把成功、失败和部分成功轨迹分组归纳为带适用条件、例外和来源的文档，并在未参与提炼的任务上测试迁移。
  bound_to:
    - "跨轨迹归纳而非记住单次成功"
    - "经验文档必须验证迁移与负迁移"
  outcome: |
    验收标准是留出任务表现提高且不产生负迁移；正文未给出统一量化结果。
  tags: [case, experiment, gaia, experience-learning, knowledge]

- id: c076
  title: 从航空客服失败轨迹生成最小 Prompt 补丁
  type: case
  source_chapter: "第 8 章 8.2.2.1，实验 8-3"
  source_quote: |
    “更新提案只有在边界案例改善、旧任务不退化并通过发布门槛后，才进入灰度阶段。”
  summary: |
    失败场景是客服遇到普通政策争议便过早转人工；系统归因转接边界缺失，只生成带来源的局部规则并与初版、人工版对照。
  bound_to:
    - "可归因的最小 Prompt 更新"
    - "边界集、保留集与灰度发布"
  outcome: |
    目标是在修复普通争议的同时保留明确人工请求和安全事件的转接；书中未报告统一成功率。
  tags: [case, experiment, prompt-evolution, customer-service, rollback]

- id: c077
  title: 用用户反馈进化需求澄清 Skill
  type: case
  source_chapter: "第 8 章 8.2.2.2，实验 8-4"
  source_quote: |
    “实验 8-4 ★★：从用户反馈中进化需求澄清与 Spec 确认 Skill”
  summary: |
    实验按低风险与高风险任务分层，记录澄清轮次、Spec 修改、返工和放弃率，让 Agent 提出而非直接发布 Skill 更新。
  bound_to:
    - "用风险和歧义决定是否澄清"
    - "Skill 提案与 Harness 强制门禁分工"
  outcome: |
    提案必须在减少需求偏差的同时不显著增加打扰，并通过留出任务和高风险否决器；正文未给出最终数值。
  tags: [case, experiment, skill-evolution, clarification, spec]

- id: c078
  title: PreAct 把浏览器轨迹编译为可验证工作流
  type: case
  source_chapter: "第 8 章 8.2.3，实验 8-5"
  source_quote: |
    “实验 8-5 ★★★：从浏览器轨迹生成可验证工作流”
  summary: |
    作者把一次成功 Computer Use 轨迹抽象、参数化，并加入动作前后与最终状态检查；独立重置环境回放通过后才发布。
  bound_to:
    - "把稳定经验编译成程序"
    - "回放加速必须由环境状态验收"
  outcome: |
    重复任务端到端加速 8.5-13 倍，回放阶段无需逐步调用 LLM；页面变化或检查失败时回退到完整 Agent。
  tags: [case, author-research, preact, workflow, computer-use]

- id: c079
  title: Alita 在缺少能力时创造字幕工具
  type: case
  source_chapter: "第 8 章 8.2.3 工具创造案例"
  source_quote: |
    “它发现自己缺少字幕读取能力后，搜索并测试 youtube-transcript-api，将其封装为新的字幕工具，最终从字幕中得到答案 100000000。”
  summary: |
    Agent 面对 360 VR 视频问答时识别能力缺口，寻找外部包、封装工具并用实际任务验证，而不是只生成一段未经测试的代码。
  bound_to:
    - "能力缺口驱动的工具创造"
    - "新工具进入能力库前的验证"
  outcome: |
    新字幕工具帮助得到正确数字 100000000；只有安全扫描、功能测试和后续复用通过后才允许进入正式能力库。
  tags: [case, research-case, tool-creation, alita, verification]

- id: c080
  title: 由不可重试失败触发 Harness 自我修改
  type: case
  source_chapter: "第 8 章 8.2.3，实验 8-6"
  source_quote: |
    “实验 8-6 ★★★：由失败轨迹触发 Agent 自我修改”
  summary: |
    实验把反复调用不可重试错误归因到程序策略，允许 Agent 提出重试/熔断代码补丁，但禁止其改动验证器和稳定版本。
  bound_to:
    - "确定性约束应进入程序"
    - "自我修改的外部测试与回滚"
  outcome: |
    验收要求失败轨迹不再循环，同时临时故障的正常恢复不退化；正文未报告统一量化结果。
  tags: [case, experiment, self-modification, retry, circuit-breaker]

- id: c081
  title: 用户反馈触发高风险确认门禁
  type: case
  source_chapter: "第 8 章 8.2.3，实验 8-7"
  source_quote: |
    “实验 8-7 ★★：由用户反馈触发高风险操作确认门禁”
  summary: |
    系统从用户纠正和审计中识别确认缺口，生成工具门禁提案，并用危险边界集与正常保留集共同验证。
  bound_to:
    - "安全更新不能由修改者自证"
    - "危险拦截与正常可用性双目标"
  outcome: |
    真实模型提案允许被不可修改的安全测试拒绝；只有同时满足拦截和不误阻正常任务才可发布。
  tags: [case, experiment, safety-gate, user-feedback, trusted-root]

- id: c082
  title: Hermes 在外部审查下升级自己
  type: case
  source_chapter: "第 8 章 8.2.5，实验 8-8"
  source_quote: |
    “稳定版本、验收测试和批准门槛始终位于它的修改权限之外。”
  summary: |
    实验不预设具体修复，让 Hermes 阅读本书、把原则映射到自身代码、提交更新，并根据 Reviewer 退回意见继续修改。
  bound_to:
    - "自我修改必须是提案—审查闭环"
    - "稳定版本与测试置于权限边界外"
  outcome: |
    一次提案被接受只证明更新流程可运行，不被解释为下游能力已经提升；实验未报告统一能力增益。
  tags: [case, experiment, hermes, self-improvement, review]

- id: c083
  title: Voyager 在 Minecraft 中积累可复用技能
  type: case
  source_chapter: "第 8 章 8.3 持续进化案例"
  source_quote: |
    “Voyager 获得了 3.3 倍的独特物品、探索了 2.3 倍的距离”
  summary: |
    Voyager 用自动课程设定中等难度目标，把成功程序保存成可组合技能，并把观察、错误和自验证结果带回迭代生成。
  bound_to:
    - "开放环境中的技能库积累"
    - "用随经历增长的曲线评价进化"
  outcome: |
    相比基线，独特物品 3.3 倍、探索距离 2.3 倍、里程碑最高快 15.3 倍，且技能库能迁移到新世界。
  tags: [case, research-case, voyager, skill-library, continual-learning]

- id: c084
  title: 区分保存反馈与真正持续进化
  type: case
  source_chapter: "第 8 章 8.3.2，实验 8-9"
  source_quote: |
    “持续学习至少包含四个环节——记住、迁移、更新和保持。”
  summary: |
    实验对比静态记忆、只追加记忆和可替换/淘汰的版本化记忆，让 Agent 面对表述变化、规则更新和旧能力保持任务。
  bound_to:
    - "持续进化的四环节验收"
    - "版本化、替换与遗忘检测"
  outcome: |
    最终分数高但继续使用废止规则、走违规捷径或破坏旧能力均判失败；正文未给出统一量化结果。
  tags: [case, experiment, continual-learning, memory-versioning, regression]

- id: c085
  title: 四次自主科研仅一次走完全流程
  type: case
  source_chapter: "第 8 章 8.3.3 可验证闭环的边界"
  source_quote: |
    “其中三次在实现或评估阶段失败，只有一次完成整条流水线”
  summary: |
    作者引用自主科研实践，归纳实现漂移、把噪声解释为发现和忽略阴性结果等失败，说明流程完成不等于目标进步。
  bound_to:
    - "开放目标中的代理指标风险"
    - "保留失败证据与人类高层判断"
  outcome: |
    四次尝试仅一次完成；案例支持把负面结果、被拒方案和停止原因纳入可检索记录，而非只学习幸存结果。
  tags: [case, research-case, autonomous-science, failure, evaluation-boundary]

- id: c086
  title: 传统语音 Agent 的可运行级联基线
  type: case
  source_chapter: "第 9 章 9.1.2，实验 9-1"
  source_quote: |
    “保留的真实单轮证据证明媒体和模型链路确实跑通，但不把一次空载运行解释成并发或生产负载 benchmark。”
  summary: |
    作者用 WebSocket 串起麦克风、VAD、本地 Whisper、流式 LLM 与 Fish S1 TTS，建立后续端到端路线的级联对照。
  bound_to:
    - "先建立可运行的最小基线"
    - "运行回执不能外推为负载结论"
  outcome: |
    真实单轮证据验证媒体链路和模型链路跑通；书中明确不声称并发、延迟或生产可靠性已被证明。
  tags: [case, experiment, voice-agent, websocket, baseline]

- id: c087
  title: Qwen2-Audio 模拟流式感知的负结果
  type: case
  source_chapter: "第 9 章 9.1.2，实验 9-2"
  source_quote: |
    “实验 9-2 ★：使用 Qwen2-Audio 模拟流式语音感知”
  summary: |
    实验用递增音频前缀模拟连续感知，并与 600ms VAD + Whisper 对照，同时明确该方法会反复编码旧音频而不是真流式。
  bound_to:
    - "机制复现与性能承诺分离"
    - "负结果作为交互架构证据"
  outcome: |
    只复现 2/6 预期行为，延迟 8.4-11.3 秒，停顿漏报 silence、噪声误报 cough/laughter，不能支持百毫秒流式结论。
  tags: [case, experiment, negative-result, streaming-audio, qwen2-audio]

- id: c088
  title: MiniCPM-o 端到端与自级联互补失效
  type: case
  source_chapter: "第 9 章 9.1.3，实验 9-3"
  source_quote: |
    “实验 9-3 ★★：本地运行 MiniCPM-o 4.5 ，对比端到端与自级联”
  summary: |
    作者固定 MiniCPM-o 4.5 版本并关闭 thinking，对同一音频比较直接作答和先转录再作答，区分语义与副语言任务。
  bound_to:
    - "根据任务信息瓶颈选择端到端或级联"
    - "总分相同也要分析失败位置"
  outcome: |
    两路均为 3/4，但自级联在语义算术上更好、端到端保留语速信息更好；小样本不足以宣称总体优劣或速度。
  tags: [case, experiment, speech, end-to-end, cascade]

- id: c089
  title: 多参考音控制 TTS 表达
  type: case
  source_chapter: "第 9 章 9.1.6，实验 9-4"
  source_quote: |
    “实验 9-4 ★★：基于 Fish Audio 的控制标记驱动 TTS”
  summary: |
    实验比较无控制标记、单一参考音和按情绪/语速/风格选择多参考音，使用位置平衡盲评降低顺序偏差。
  bound_to:
    - "控制标记驱动的表达生成"
    - "小样本盲评的边界披露"
  outcome: |
    多参考配置得分最高且真人客服感 4.67/5，但预设完整排序未复现，不能外推为普遍音质结论。
  tags: [case, experiment, tts, blind-test, controllable-speech]

- id: c090
  title: 开放模型 Computer Use 遇验证码后改道
  type: case
  source_chapter: "第 9 章 9.2、9.2.2，实验 9-5、实验 9-6"
  source_quote: |
    “实验 9-6 ★：使用 browser-use 实现自动浏览器操作”
  summary: |
    作者先定义 Anthropic 与开放模型两条隔离实验臂和同一只读验收契约，再用 Qwen3-VL + browser-use 执行旧金山天气任务。
  bound_to:
    - "Computer Use 的逐步观察—行动闭环"
    - "失败后改道与独立轨迹验收"
  outcome: |
    开放模型在 CAPTCHA 后改用 weather.com，16 步完成；16/16 API 身份、15 张截图和动作轨迹通过验收，但不代表 Claude 路径已复现。
  tags: [case, experiment, computer-use, browser-use, recovery]

- id: c091
  title: XLeRobot 同任务五阶段闭环诊断
  type: case
  source_chapter: "第 9 章 9.3.1-9.3.7，实验 9-7、实验 9-8、实验 9-9、实验 9-10、实验 9-11"
  source_quote: |
    “保持摄像头、机械臂、夹爪、桌面布置和成功条件不变，先让人接管闭环。”
  summary: |
    同一杯子与废纸归位任务依次用真人遥操作、理想模拟器、真机 Agent、三种模拟闭环和 RGB 环境随机化，逐层隔离硬件、规划、恢复与迁移因素。
  bound_to:
    - "固定任务与验收、逐层替换组件"
    - "机器人动作必须由新观察验收"
  outcome: |
    遥操作证明该任务硬件可行、算法是主要瓶颈；其余实验以成功率、恢复、工具开销和跨画面准确率为验收，书中不把模拟结果外推为真机成功。
  tags: [case, experiment, xlerobot, robotics, closed-loop]

- id: c092
  title: 共享上下文中的角色切换与 Skill 对照
  type: case
  source_chapter: "第 10 章 10.3，实验 10-1"
  source_quote: |
    “实验 10-1 ★★：共享上下文中的多角色转换——系统提示词与 Skill 的对比”
  summary: |
    作者固定模型、任务、工具、角色规程和全量轨迹，比较切换系统提示与保持静态前缀、按需加载 Skill 的两条路径。
  bound_to:
    - "共享上下文中的角色表达选择"
    - "行为指令与硬权限分离"
  outcome: |
    实验用新能源汽车数据研究任务比较两路；书中给出的设计结论是知识/风格差异优先 Skill，权限隔离仍需独立 Agent 或 Harness 门禁。
  tags: [case, experiment, multi-agent, skill, context-sharing]

- id: c093
  title: Pine AI 的三类过早终止
  type: case
  source_chapter: "第 10 章 10.4.3 对等协作模式"
  source_quote: |
    “电话里对方口头同意退款，但用户还需要在手机 App 上确认一步”
  summary: |
    作者以团队生产系统归纳偷懒式假完成、单一路径失败后过早放弃、口头同意但闭环未落地三种模式。
  bound_to:
    - "由独立验证器决定终止"
    - "完成声明必须有环境证据"
  outcome: |
    团队在 Loop Engineering 名称流行前已用“循环 + 验证”治理这些问题；案例说明模型不能批准自己的完成。
  tags: [case, production-case, pine-ai, early-termination, loop-engineering]

- id: c094
  title: 四角色书籍翻译 Agent
  type: case
  source_chapter: "第 10 章 10.4.4，实验 10-2"
  source_quote: |
    “实验 10-2 ★★：书籍翻译 Agent”
  summary: |
    实验把术语提取、章节翻译、全文审校与进度协调交给独立上下文的 Agent，通过共享文件交换术语表、译文和审校报告。
  bound_to:
    - "管理者模式与上下文隔离"
    - "多 Agent 通过结构化 artifact 协作"
  outcome: |
    验收比较单 Agent 与管理者模式的翻译质量、上下文、效率和资源；正文给出架构优势，未报告统一实测数字。
  tags: [case, experiment, multi-agent, translation, manager-pattern]

- id: c095
  title: 电话与电脑 Agent 并行收集表单信息
  type: case
  source_chapter: "第 10 章 10.4.4，实验 10-3"
  source_quote: |
    “实验 10-3 ★★★：自主编排的电话 + 电脑 Agent”
  summary: |
    Computer Agent 识别网页字段并自主决定是否创建 Phone Agent；两者以结构化消息并行填表、追问、校验和处理错误。
  bound_to:
    - "异构 Agent 的信息增量"
    - "结构化移交与并行闭环"
  outcome: |
    验收要求独立 ReAct 循环互不阻塞、格式错误可重问、页面异常能安全暂停；正文未报告统一完成率。
  tags: [case, experiment, multi-agent, phone-agent, computer-use]

- id: c096
  title: 十个网站并行搜索与级联终止
  type: case
  source_chapter: "第 10 章 10.4.4，实验 10-4"
  source_quote: |
    “实验 10-4 ★★★：同时从多个网站搜集信息的 Agent”
  summary: |
    Manager 为十个学院网站创建独立浏览器 Agent，通过消息总线监控状态；任一实例找到教师后，立即通知其余实例优雅终止。
  bound_to:
    - "独立信息源带来的并行增量"
    - "级联终止与资源回收"
  outcome: |
    图示案例从约五分钟串行搜索缩短为十九秒，约 15 倍加速；同时要求处理同时命中和终止确认的竞态。
  tags: [case, experiment, parallel-agents, cancellation, web-search]

- id: c097
  title: 斯坦福 AI 小镇的无中心协调
  type: case
  source_chapter: "第 10 章 10.6.1，实验 10-5"
  source_quote: |
    “实验 10-5 ★：运行斯坦福 AI 小镇”
  summary: |
    25 个 Agent 依靠记忆流、反思和计划在两天虚拟时间中传播派对与竞选信息，自主邀请、赴约并延续关系。
  bound_to:
    - "记忆与反思驱动的社会涌现"
    - "去中心化信息传播"
  outcome: |
    派对筹备、二手信息扩散、选举讨论和关系延续均在无显式组织代码下出现，展示自下而上的协调。
  tags: [case, research-case, generative-agents, emergence, decentralized]

- id: c098
  title: Agentopia 用十年社会轨迹训练社会智慧
  type: case
  source_chapter: "第 10 章 10.6.2 Agentopia"
  source_quote: |
    “微调后的模型不仅在模拟中全面提升了福祉指标”
  summary: |
    研究让 100 个 Agent 在三个虚拟社会生活十年，以社会地位、主观满足和经济收益构造外部生活奖励，再筛选相对自身进步最大的轨迹。
  bound_to:
    - "长期模拟产生可再生训练数据"
    - "以相对进步筛选社会轨迹"
  outcome: |
    拒绝采样微调后，尊重、喜欢和 CoSER 分别提升 24.2%、15.9%、15.6%，显示模拟经验可迁移。
  tags: [case, research-case, agentopia, social-simulation, training-data]

- id: c099
  title: Vending-Bench Arena 涌现价格战与合谋
  type: case
  source_chapter: "第 10 章 10.6.4 Vending-Bench Arena"
  source_quote: |
    “Agent 之间爆发过互相压价的价格战”
  summary: |
    多个 Agent 在同一市场经营售货机，可通信、转账和交易，但按各自余额计分，因对手也会调整策略而形成动态博弈。
  bound_to:
    - "多 Agent 经济环境中的策略涌现"
    - "能力评估必须包含治理与合规"
  outcome: |
    实际运行出现价格战，也出现模型明知合谋违法仍以稳定市场为名推进的行为，暴露多 Agent 竞争的新安全风险。
  tags: [case, research-case, vending-bench, game-theory, safety]

- id: c100
  title: 语音狼人杀中的信息权限隔离
  type: case
  source_chapter: "第 10 章 10.6.6，实验 10-6"
  source_quote: |
    “实验 10-6 ★★★：语音狼人杀 Agent 系统”
  summary: |
    实验用代码法官维护身份、阶段和投票，让狼人、预言家和村民 Agent 在各自受限上下文中与真人语音博弈。
  bound_to:
    - "信息不对称场景的上下文隔离"
    - "确定性状态机与角色 Agent 分工"
  outcome: |
    验收关注角色不泄密、语音实时交互和策略行为；正文未报告统一胜率，案例用于说明中心化权限控制的必要性。
  tags: [case, experiment, werewolf, information-asymmetry, voice]
