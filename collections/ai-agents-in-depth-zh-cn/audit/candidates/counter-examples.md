# 反例与失败模式候选池

> Cangjie Skill 阶段 1 提取。按全书自然章节扫描，仅归并机制相同的重复项，不做 Skill 筛选或编写。`source_quote` 均为原文短引，合并项在 `source_chapter` 中保留全部出处。

- id: ce001
  title: "把固定任务过度 Agent 化"
  type: "架构反例"
  source_chapter: "第 1 章 1.2.3、1.2.5；第 3 章 3.3.4；第 10 章 10.2"
  source_quote: |
    “如果通过优化提示词和上下文示例就能解决问题，就不要引入 Agent 系统。”
  failure_mode: |
    固定、可预编排或单次调用即可完成的任务被升级为自主 Agent、Agentic RAG 或多 Agent，徒增延迟、费用、故障点和失控面。
  mechanism: |
    自主决策层没有带来新的任务信息，只增加抽象层、模型调用与中间信息变换；每层又会引入误差和调试盲区。
  warning_signs:
    - "步骤、分支和工具顺序在实现前已经完全可枚举"
    - "新增 Agent 后成功率不升，但 token、延迟和故障率上升"
  bound_to:
    - "按任务动态性选择单次调用、工作流或自主 Agent"
    - "新增复杂度必须有实测收益"
  tags: [architecture, over-engineering, orchestration, cost]

- id: ce002
  title: "用通用工具承载高风险副作用"
  type: "安全反例"
  source_chapter: "第 1 章 1.1.2 工具"
  source_quote: |
    “通用工具并不总是优于专用工具。”
  failure_mode: |
    让通用代码、Shell 或浏览器工具直接完成支付、删除数据、发信和生产部署，模型可绕过业务参数、权限和审批边界。
  mechanism: |
    通用动作空间过宽，业务约束仅存在于提示词而非不可绕过的执行接口中；一次误判即可变成不可逆副作用。
  warning_signs:
    - "高风险操作只靠自然语言提醒"
    - "工具能访问完成当前任务不需要的资源或动作"
  bound_to:
    - "高风险操作使用参数明确、最小权限、可审计的专用工具"
    - "不可逆动作设置预览与人工确认"
  tags: [tools, least-privilege, side-effect, safety]

- id: ce003
  title: "轨迹缺少工具结果反馈"
  type: "闭环失败"
  source_chapter: "第 1 章 1.1.4 上下文，实验 1-1"
  source_quote: |
    “缺失它会导致 Agent ‘盲目’执行，陷入无限循环。”
  failure_mode: |
    工具已经执行，但返回值没有可靠写回下一轮上下文，Agent 反复调用同一个工具或基于旧假设继续行动。
  mechanism: |
    ReAct 闭环的观察通道断裂，策略无法看到环境状态变化，也无法区分动作未执行、执行失败或已经成功。
  warning_signs:
    - "相同参数的工具调用连续出现"
    - "模型声称未取得一个实际已返回的结果"
  bound_to:
    - "每个动作结果必须进入后续决策上下文"
    - "检测重复调用并在反馈缺失时终止"
  tags: [react, observation, tool-result, loop]

- id: ce004
  title: "轨迹失忆导致重复执行"
  type: "上下文失败"
  source_chapter: "第 1 章 1.1.4 上下文，实验 1-1；第 2 章 2.3.2 常见的错误上下文管理"
  source_quote: |
    “没有它 Agent 等于失忆，于是从头开始整个任务流程，重复执行已完成的步骤。”
  failure_mode: |
    历史消息、已完成步骤或关键工具结果被删除后，Agent 从头规划并重复产生副作用。
  mechanism: |
    当前状态只隐含在被裁掉的轨迹中；模型看不到已做过什么，因而把已完成动作判断为待办。
  warning_signs:
    - "压缩或滑窗后任务进度突然回退"
    - "同一邮件、提交或写操作被再次执行"
  bound_to:
    - "裁剪前显式保存完成状态与幂等键"
    - "上下文管理不得丢失决定下一步所需的信息"
  tags: [context, history, state, duplicate-action]

- id: ce005
  title: "自主循环没有停止条件"
  type: "控制流失败"
  source_chapter: "第 1 章 1.2.5.2 自主 Agent；第 10 章 10.5.3"
  source_quote: |
    “自主性不等于无限制——必须设计明确的停止条件（任务完成、达到最大迭代次数或遭遇不可恢复的错误）。”
  failure_mode: |
    Agent 在无法完成、观察不变或子任务循环委派时持续消耗工具、token 和外部资源。
  mechanism: |
    完成判断由模型自报且没有外部预算、超时、进展检测和取消传播，控制循环因此没有可靠的吸收态。
  warning_signs:
    - "轮数增长但环境状态或产物无变化"
    - "Agent 在同一错误与同一恢复动作之间振荡"
  bound_to:
    - "设置轮数、工具、时间和费用上限"
    - "提供可传播到子 Agent 的取消与人工终止"
  tags: [termination, budget, infinite-loop, control]

- id: ce006
  title: "用单一护栏代替分层防御"
  type: "安全陷阱"
  source_chapter: "第 1 章 1.2.6 护栏与安全机制"
  source_quote: |
    “单个护栏不太可能提供足够的保护。”
  failure_mode: |
    系统把输入分类器、提示词规则或单次审批当成完整安全边界，一个绕过就能直达危险工具。
  mechanism: |
    单一检测器存在未知攻击面、分布外输入和误判；没有执行侧权限与输出侧验证来限制其漏检后果。
  warning_signs:
    - "安全设计只描述一个模型或一组关键词"
    - "护栏漏检后敏感操作没有第二道门禁"
  bound_to:
    - "输入、执行和输出采用相互独立的分层护栏"
    - "安全能力以对抗测试验证而非提示词自证"
  tags: [guardrail, defense-in-depth, safety]

- id: ce007
  title: "只追求拦截率造成误拒绝"
  type: "评估反例"
  source_chapter: "第 1 章 1.2.6 护栏与安全机制"
  source_quote: |
    “护栏也存在另一类失败：误拒绝。”
  failure_mode: |
    为降低危险请求放行率不断收紧规则，最终连经过授权的安全测试、研究和合法敏感任务也无法完成。
  mechanism: |
    单目标优化只奖励拒绝危险样本，没有把合法样本的可完成率纳入约束，决策边界会系统性偏向拒绝。
  warning_signs:
    - "安全指标很好但用户大量改写请求以绕过误拒"
    - "评测集只有应拒绝样本，没有明确允许样本"
  bound_to:
    - "同时评估漏放与误拒"
    - "为授权敏感任务设计可审计的放行路径"
  tags: [guardrail, false-positive, evaluation, usability]

- id: ce008
  title: "把动态信息写进稳定前缀"
  type: "性能反例"
  source_chapter: "第 2 章 2.3 KV Cache 友好的上下文设计"
  source_quote: |
    “那一行时间戳使每次请求的 token 序列从时间戳所在位置开始不同。”
  failure_mode: |
    时间戳、用户状态或每轮变化的配置被插入系统提示词前部，导致首 token 延迟和推理成本突然上升。
  mechanism: |
    前缀任一 token 改变都会使该位置之后的 KV 状态无法复用，动态字段越靠前，失效范围越大。
  warning_signs:
    - "模型和请求长度不变但缓存命中率骤降"
    - "系统提示词每轮包含不同的时间、随机数或状态"
  bound_to:
    - "稳定规则放前缀，动态信息追加到轨迹末尾"
    - "监控前缀哈希和缓存命中率"
  tags: [kv-cache, context-layout, latency, cost]

- id: ce009
  title: "动态重排工具定义破坏缓存"
  type: "性能陷阱"
  source_chapter: "第 2 章 2.3.2 常见的错误上下文管理，实验 2-3"
  source_quote: |
    “改变顺序就会使 token 序列从首个顺序变化的位置开始不同，导致该位置及其后的缓存无法复用。”
  failure_mode: |
    框架按热度、名称或注册时机重排同一组工具，语义未变却让每轮前缀字节序列不同。
  mechanism: |
    缓存按 token 前缀而不是语义等价性匹配；工具 schema 顺序变化会使后续全部状态重新计算。
  warning_signs:
    - "工具集合相同但请求序列化结果不稳定"
    - "重启或动态注册后首 token 延迟波动"
  bound_to:
    - "稳定工具集合采用确定性排序和序列化"
    - "动态工具放在按需加载的后缀"
  tags: [tools, kv-cache, serialization, performance]

- id: ce010
  title: "滑动窗口切掉关键任务状态"
  type: "上下文反例"
  source_chapter: "第 2 章 2.3.2 常见的错误上下文管理，实验 2-3"
  source_quote: |
    “使用滑动窗口的 Agent 经常陷入循环，反复执行相同的工具调用。”
  failure_mode: |
    系统机械保留最近 N 条消息，把早期约束、工具结果和用户确认一起删除，Agent 随后违约或重做。
  mechanism: |
    消息新旧不等于信息价值；固定窗口按位置淘汰，无法识别对后续决策仍有因果作用的旧信息。
  warning_signs:
    - "错误总在对话达到固定轮数后出现"
    - "早期确认和不可变约束不再能被模型复述"
  bound_to:
    - "按信息价值而非消息年龄压缩"
    - "将长期约束和进度显式保留"
  tags: [sliding-window, context-loss, state]

- id: ce011
  title: "把结构化消息扁平化为纯文本"
  type: "表示反例"
  source_chapter: "第 2 章 2.3.2 常见的错误上下文管理"
  source_quote: |
    “文本格式化方法是最具破坏性的模式之一。”
  failure_mode: |
    框架把 system、user、assistant 和 tool 消息拼成普通文本，模型开始忽略工具结果、用文字假装调用工具或混淆指令优先级。
  mechanism: |
    原生协议中的角色、调用 ID 和结果关联被抹平，相同字符不再携带可供模型与 Harness 解析的结构语义。
  warning_signs:
    - "模型在正文中生成伪造的 tool JSON"
    - "工具结果无法与对应调用可靠匹配"
  bound_to:
    - "保留 API 原生角色与工具调用结构"
    - "用调用 ID 关联动作和观察"
  tags: [message-format, tool-calling, structure, protocol]

- id: ce012
  title: "把业务规则堆成无序清单"
  type: "提示反例"
  source_chapter: "第 2 章 2.4.3 把规则写成流程，实验 2-4"
  source_quote: |
    “去除标题层次，把有序的流程拆散成无序的规则集合。这个看似简单的改变带来了灾难性的后果：任务成功率下降超过 30%。”
  failure_mode: |
    大量退款、改签或权限规则平铺在提示词中，模型无法稳定判断优先级、前置条件和互斥关系。
  mechanism: |
    规则只有内容没有控制流结构，模型必须临时推断依赖图；长上下文中相邻或显眼规则会压过真正优先级。
  warning_signs:
    - "规则单条都正确，组合场景却频繁违规"
    - "交换规则顺序会显著改变结果"
  bound_to:
    - "把业务规则组织为带条件和优先级的流程"
    - "用冲突组合用例验证规则"
  tags: [prompt-engineering, business-rules, control-flow]

- id: ce013
  title: "把模糊业务裁量交给模型"
  type: "规则失败"
  source_chapter: "第 2 章 2.4.4 业务规则必须具体"
  source_quote: |
    “模糊的规则（‘根据任务情况选择合适的计费类型’）会导致 Agent 的行为极不稳定。”
  failure_mode: |
    提示词使用合理、适当、必要时等模糊词，却没有阈值、条件和升级路径，导致相同事实得到不一致决定。
  mechanism: |
    模型用预训练分布填补缺失规则，其隐含标准会随措辞、上下文和采样变化，无法成为可审计业务政策。
  warning_signs:
    - "同一输入重复运行得到不同审批结论"
    - "运营人员无法从规则解释模型阈值"
  bound_to:
    - "关键规则写明可计算条件、例外与升级路径"
    - "不确定裁量交给显式审批而非自由生成"
  tags: [prompt, ambiguity, policy, auditability]

- id: ce014
  title: "用大量相似示例稀释规则"
  type: "上下文陷阱"
  source_chapter: "第 2 章 2.4.5 少而精的示例"
  source_quote: |
    “示例的数量也不是越多越好。”
  failure_mode: |
    为覆盖场景不断追加近似 few-shot 示例，token 成本上升，真正的规则和边界反而更难被注意。
  mechanism: |
    重复示例提供的信息增量很低，却竞争有限注意力，并可能让模型把表面模板误当成普遍规则。
  warning_signs:
    - "示例数量增长但边界场景成功率不升"
    - "删除冗余示例后效果相同或更好"
  bound_to:
    - "示例覆盖不同决策边界而非重复表面形式"
    - "用消融验证每个示例的信息增量"
  tags: [few-shot, context-budget, redundancy]

- id: ce015
  title: "让不可信内容进入指令通道"
  type: "安全攻击"
  source_chapter: "第 2 章 2.4.7 提示注入；第 3 章 3.3.4 Agentic RAG；第 4 章 4.3 MCP；第 5 章 5.2.5；第 8 章 8.3.4"
  source_quote: |
    “攻击者通过 Agent 处理的外部内容（网页、邮件、文档等），将伪装成系统指令的文本混入上下文，从而劫持 Agent 的行为。”
  failure_mode: |
    网页、文档、检索结果、工具描述或生成页面中的恶意文本被模型当作高优先级指令，进而泄露数据或触发副作用。
  mechanism: |
    自然语言既承载数据又承载指令，模型没有可靠的来源隔离；摘要和再生成也不会自动消除其中的攻击意图。
  warning_signs:
    - "外部内容要求忽略规则、读取秘密或调用无关工具"
    - "工具调用目标随检索文档措辞而非用户目标变化"
  bound_to:
    - "不可信内容标记为数据并与系统指令隔离"
    - "敏感动作由结构化权限与人工确认兜底"
    - "摄取知识前做来源、权限和内容审查"
  tags: [prompt-injection, rag, mcp, untrusted-input]

- id: ce016
  title: "Skill 描述过宽导致误路由"
  type: "路由反例"
  source_chapter: "第 2 章 2.5.1 Skills"
  source_quote: |
    “描述太宽泛（如‘help with backend’）等于任何后端相关的工作都能触发，路由就会失准。”
  failure_mode: |
    Skill 的触发描述只有宽泛领域词，没有正反边界，导致无关任务也加载它，甚至多个 Skill 同时争抢。
  mechanism: |
    路由器主要依据简短元数据做语义匹配；宽描述提高召回同时摧毁精度，并把错误指令注入后续上下文。
  warning_signs:
    - "同一 Skill 在大多数相邻领域任务上都会触发"
    - "候选 Skill 经常超过真实所需数量"
  bound_to:
    - "Skill 描述同时写适用任务与排除条件"
    - "用正例、难负例和冲突 Skill 测试路由"
  tags: [skill, routing, false-positive, metadata]

- id: ce017
  title: "启动时加载全部 Skill 和工具"
  type: "上下文反例"
  source_chapter: "第 2 章 2.5.3 Skills 在上下文中的位置；第 4 章 4.8 主动工具发现"
  source_quote: |
    “不是把所有知识一次性塞给 Agent，而是让它按需加载。”
  failure_mode: |
    系统把所有能力说明和 schema 常驻上下文，模型选择变差、规则互相干扰、缓存和 token 成本持续膨胀。
  mechanism: |
    大量当前无关信息争夺注意力；相似工具增加决策熵，且任何动态变化都会扩大前缀缓存失效范围。
  warning_signs:
    - "请求前缀主要由当前任务不会调用的能力占据"
    - "增加工具后旧任务准确率下降"
  bound_to:
    - "用元数据目录和渐进式披露按需加载"
    - "限制每轮可见工具集合并允许后续再发现"
  tags: [progressive-disclosure, tools, skills, context-rot]

- id: ce018
  title: "让 LLM 充当权威状态计算器"
  type: "状态反例"
  source_chapter: "第 2 章 2.6.1 Agent 状态栏的理论基础"
  source_quote: |
    “前沿大模型去一次性读完整段历史、吐出统计结果，反而在大多数格子上出错。”
  failure_mode: |
    用一次模型摘要计算工具次数、任务进度或权限状态，并把结果作为后续决策的权威事实，错误会持续传播。
  mechanism: |
    长轨迹统计是易漏、易错的有损生成；显式状态又会获得更高注意力，因此一个摘要错误比隐式缺失更具支配性。
  warning_signs:
    - "状态栏数值无法从事件日志复算"
    - "模型无条件相信与原始轨迹矛盾的状态摘要"
  bound_to:
    - "可计算状态由代码或事件归约维护"
    - "状态保留来源并可与原始证据核验"
  tags: [state, llm-summary, error-propagation]

- id: ce019
  title: "用有损状态摘要替换原始证据"
  type: "信息丢失"
  source_chapter: "第 2 章 2.6.1 Agent 状态栏；第 3 章 3.3.3 知识库持续更新"
  source_quote: |
    “状态栏是对原始上下文的一次有损投影。”
  failure_mode: |
    系统生成进度或知识摘要后删除底层轨迹与原文，遇到摘要未预见的问题时无法恢复细节、来源和条件。
  mechanism: |
    投影只保留生成当时认为相关的维度；未来查询的信息需求不同，已丢失的维度无法从摘要逆推出。
  warning_signs:
    - "结论存在但无法定位到原始工具结果或文档"
    - "新问题只能反复改写旧摘要"
  bound_to:
    - "摘要与原始证据分层保存"
    - "所有关键状态携带可追溯来源"
  tags: [lossy-summary, provenance, state, evidence]

- id: ce020
  title: "追加式状态造成新旧版本歧义"
  type: "状态失败"
  source_chapter: "第 2 章 2.6.4 状态更新的两种实现与缓存代价"
  source_quote: |
    “代价是陈旧的状态会在上下文中累积，既占用 token，也要求模型自己关注‘最新一条’状态而忽略已过时的旧状态。”
  failure_mode: |
    为保住 KV Cache，每轮都追加完整新状态但不使旧状态失效，模型同时看到多个互相矛盾的版本。
  mechanism: |
    追加保持前缀稳定却把版本解析责任交给模型；显眼的旧值可能被错误检索，token 也随轮次线性增长。
  warning_signs:
    - "上下文中同一字段出现多个不同值"
    - "模型偶尔引用数轮之前的状态"
  bound_to:
    - "状态更新携带版本、有效期和明确取最新规则"
    - "达到阈值时合并归档旧状态"
  tags: [state-versioning, stale-state, kv-cache]

- id: ce021
  title: "等到溢出才治理上下文"
  type: "容量陷阱"
  source_chapter: "第 2 章 2.7.1 为什么需要压缩"
  source_quote: |
    “明明上下文窗口还远没有满，但 Agent 突然找不到关键信息了，或者反复纠结于一个早已解决的问题，这种现象被称为上下文腐化。”
  failure_mode: |
    系统只在 token 超限时截断，实际在此前就因噪声、重复与冲突信息出现工具误选和约束遗忘。
  mechanism: |
    上下文窗口是容量上限而非有效注意力保证；无关内容增多会降低关键信息的检索概率。
  warning_signs:
    - "请求未超限但长会话准确率持续下降"
    - "模型能找到信息却在决策时忽略它"
  bound_to:
    - "按信息价值和行为指标主动治理上下文"
    - "监控上下文腐化而不只监控 token 上限"
  tags: [context-rot, compression, attention]

- id: ce022
  title: "每轮压缩破坏缓存并累积失真"
  type: "压缩反例"
  source_chapter: "第 2 章 2.7.3 压缩与 KV Cache"
  source_quote: |
    “频繁压缩会频繁破坏缓存，最好在上下文接近阈值时批量压缩，而不是每轮都压。”
  failure_mode: |
    为保持上下文短小，每轮都重新总结历史，延迟成本上升且同一事实经多轮转述逐渐漂移。
  mechanism: |
    摘要改写破坏稳定前缀；递归有损变换会放大遗漏和错误，并删除无法预先判定价值的细节。
  warning_signs:
    - "摘要内容每轮变化但任务状态没有变化"
    - "缓存命中率与事实保真度同时下降"
  bound_to:
    - "只在预算阈值触发批量、分层压缩"
    - "关键事实从原始来源重建而非摘要套摘要"
  tags: [compression, kv-cache, summary-drift]

- id: ce023
  title: "逐项摘要制造碎片与重复"
  type: "压缩失败"
  source_chapter: "第 2 章 2.7.3，实验 2-6"
  source_quote: |
    “主要问题是信息碎片化——多个页面重复描述同一事件，白白浪费了上下文空间。”
  failure_mode: |
    工具输出被逐条独立摘要，跨条关系消失且相同背景反复出现；改成简单拼接截断时，后部重要信息又被切掉。
  mechanism: |
    压缩单元与任务语义单元不一致，局部摘要看不到跨输出依赖，位置截断也不理解信息价值。
  warning_signs:
    - "摘要中背景说明重复多于实际结论"
    - "最终答案总忽略较晚返回的工具结果"
  bound_to:
    - "按任务问题联合压缩相关证据"
    - "保留跨项关系并用价值而非位置裁剪"
  tags: [compression, fragmentation, truncation]

- id: ce024
  title: "压缩时删除决策依据与失败路径"
  type: "信息丢失"
  source_chapter: "第 2 章 2.7.6 对 Agent 架构设计的启示"
  source_quote: |
    “压缩最容易丢失的不是细节本身，而是早期的架构决策、约束背后的理由和失败的路径。”
  failure_mode: |
    摘要只保留当前结论，下一会话不知道为何这样设计、哪些替代方案已失败，于是重开旧路径或违反隐含约束。
  mechanism: |
    生成摘要偏好结果性和流畅信息，低频但高价值的因果依据与负面证据更容易被判为可删噪声。
  warning_signs:
    - "产物有结论却没有取舍理由"
    - "Agent 多次尝试历史已证伪方案"
  bound_to:
    - "压缩模板强制保留决策、约束、验证与失败路径"
    - "失败证据可追溯到原始记录"
  tags: [compression, decision-log, negative-evidence]

- id: ce025
  title: "隔离子任务却不给自包含输入"
  type: "委派反例"
  source_chapter: "第 2 章 2.7.7 隔离优于压缩；第 10 章 10.4"
  source_quote: |
    “代价是子 Agent 看不到主 Agent 的完整上下文，任务描述必须自包含、目标明确。”
  failure_mode: |
    主 Agent 只发一句依赖隐含历史的任务，子 Agent 因缺少目标、约束、输入和验收标准而产出表面相关但不可用的结果。
  mechanism: |
    上下文隔离阻止噪声也阻止必要信息；未结构化的委派无法重建父上下文中的关键状态。
  warning_signs:
    - "子 Agent 频繁重复询问基本背景"
    - "返回结果格式或范围与主任务不兼容"
  bound_to:
    - "委派包包含目标、输入、约束、输出协议和验收标准"
    - "回传结论同时携带证据与未决问题"
  tags: [delegation, context-isolation, handoff]

- id: ce026
  title: "把未核验提取写成长期事实"
  type: "记忆污染"
  source_chapter: "第 3 章 3.1 用户记忆系统"
  source_quote: |
    “提取器可以提出候选，但不能自行把未核验的字符串当成事实。”
  failure_mode: |
    记忆提取器把误听、推测、临时计划或外部文本直接写入用户长期档案，之后每次会话都把错误当真。
  mechanism: |
    候选生成与事实发布没有验证边界；持久记忆提高了错误的检索频率和权威性，使一次局部误差跨会话放大。
  warning_signs:
    - "长期记忆没有来源、时间或验证状态"
    - "模型推断与用户明确陈述以相同等级保存"
  bound_to:
    - "提取、核验、发布分阶段"
    - "记忆记录来源、时间、置信度与冲突版本"
  tags: [memory, verification, provenance, poisoning]

- id: ce027
  title: "用单一记忆格式覆盖所有信息"
  type: "表示反例"
  source_chapter: "第 3 章 3.1.3 用户记忆的四种存储格式，实验 3-2"
  source_quote: |
    “但在需要综合多条信息、区分同名实体的第二、三层用例上频繁失分。”
  failure_mode: |
    所有记忆都强制存成原子键值、整段叙事或刚性卡片，分别造成关系割裂、冗余难更新或多维语义丢失。
  mechanism: |
    不同信息的检索、更新、消歧和聚合需求不同；统一表示把一种格式的结构偏差扩散到全部任务。
  warning_signs:
    - "查询单条事实正常，跨实体或跨时间问题频繁失败"
    - "同一事实出现在多段文本中且更新不一致"
  bound_to:
    - "按事实重要性和关系复杂度混合记忆格式"
    - "用跨会话关联与消歧用例选择表示"
  tags: [memory-format, representation, entity-resolution]

- id: ce028
  title: "冲突时覆盖历史版本"
  type: "更新反例"
  source_chapter: "第 3 章 3.1.7 记忆压缩与整理机制；3.3.3 知识库持续更新"
  source_quote: |
    “冲突检测采用版本化方法——保留历史版本同时标记最新版本。”
  failure_mode: |
    新地址、新政策或新结论到来时直接 UPDATE/DELETE 旧记录，导致历史事实、适用时段和冲突证据不可恢复。
  mechanism: |
    写入时过早把差异解释为替换关系；实际差异可能来自时间、主体或适用范围不同，破坏性覆盖会消除判别线索。
  warning_signs:
    - "无法回答某事实在过去何时有效"
    - "新证据一出现，旧来源和审核记录就消失"
  bound_to:
    - "冲突信息版本化并标记有效期与范围"
    - "只有明确可替代的当前值才收敛到最新版"
  tags: [memory, versioning, conflict, temporal]

- id: ce029
  title: "按固定 token 拦腰切分文档"
  type: "RAG 反例"
  source_chapter: "第 3 章 3.2.1 文档分块"
  source_quote: |
    “一个段落、一段代码、一张表格都可能被拦腰截断。”
  failure_mode: |
    索引按固定长度切块而无视标题、段落、代码和表格边界，检索结果缺主体、条件或行列语义。
  mechanism: |
    嵌入和生成只看到局部片段；跨边界的语义关系被切开，重叠只能降低而不能消除随机断裂。
  warning_signs:
    - "命中块包含代词或数值却没有所属对象"
    - "代码定义和调用、表头和数据分处不同块"
  bound_to:
    - "优先按自然结构递归切分"
    - "用目标查询评估块大小与重叠"
  tags: [rag, chunking, structure, context-loss]

- id: ce030
  title: "块过小或过大都损害检索"
  type: "参数陷阱"
  source_chapter: "第 3 章 3.2.1 文档分块"
  source_quote: |
    “块太小，单块信息不完整，脱离上下文后语义模糊。”
  failure_mode: |
    盲目追求细粒度使片段脱离上下文，盲目追求完整又让嵌入主题模糊并把无关内容注入模型。
  mechanism: |
    块大小同时控制语义自包含度和检索精度，两端优化目标相反，不存在脱离语料与查询分布的通用常数。
  warning_signs:
    - "检索片段需要相邻块才能读懂"
    - "命中块很长但只有一两句相关"
  bound_to:
    - "在真实查询集上联合调节块大小、重叠和 top-k"
    - "为代码、表格和叙事文档使用不同策略"
  tags: [rag, chunk-size, retrieval, tradeoff]

- id: ce031
  title: "只用稠密或只用稀疏检索"
  type: "检索盲区"
  source_chapter: "第 3 章 3.2.4 混合检索"
  source_quote: |
    “没有哪种单一检索策略在所有场景下都可靠。”
  failure_mode: |
    纯向量检索漏掉产品号、法条号和罕见专名；纯关键词检索又漏掉同义改写和概念相近表达。
  mechanism: |
    稠密表示压缩词面细节，稀疏表示缺乏语义泛化；任何单一路径都会在另一类查询上形成系统性盲区。
  warning_signs:
    - "精确 ID 明明存在却搜不到"
    - "换成同义词后结果集合完全不同"
  bound_to:
    - "融合稠密、稀疏候选并去重重排"
    - "按查询类型监控各通道召回"
  tags: [rag, dense-retrieval, sparse-retrieval, hybrid]

- id: ce032
  title: "用 Top-k 检索回答全库统计"
  type: "任务错配"
  source_chapter: "第 3 章 3.3.1 分层索引"
  source_quote: |
    “统计类问题需要‘数遍所有文档’，而检索的本性是‘找最相关的几个’，两者天然矛盾。”
  failure_mode: |
    系统从最相关的少数文档估算比例、总数或全局规则，把被截断且有选择偏差的样本当成全集。
  mechanism: |
    Top-k 为相关性优化，不保证覆盖率和抽样无偏；未检索文档在生成阶段完全不可见。
  warning_signs:
    - "答案给出全库百分比但证据只有少量片段"
    - "调整 k 值会显著改变统计结论"
  bound_to:
    - "聚合问题使用结构化统计或预计算全局摘要"
    - "结果声明覆盖范围而非伪装全量"
  tags: [rag, aggregation, top-k, sampling-bias]

- id: ce033
  title: "把自然语言压成三元组后当作完整语义"
  type: "知识图谱反例"
  source_chapter: "第 3 章 3.3.1 GraphRAG"
  source_quote: |
    “将自然语言转为三元组不可避免地导致语义降级。”
  failure_mode: |
    条件、时间依赖和语气被拆成孤立实体关系，图查询返回的事实看似精确却已经改变原意。
  mechanism: |
    主语-关系-宾语表示无法天然承载复杂条件逻辑；LLM 提取错误又会把误读固化成可反复传播的结构化知识。
  warning_signs:
    - "图中有关系但找不到其原句条件"
    - "时间性计划被表示为无条件事实"
  bound_to:
    - "图索引保留原文证据和条件元数据"
    - "仅在多跳与消歧收益明确的场景采用图表示"
  tags: [graphrag, triple, semantic-loss, knowledge-poisoning]

- id: ce034
  title: "用摘要更新摘要造成知识漂移"
  type: "知识更新失败"
  source_chapter: "第 3 章 3.3.3 知识库持续更新；第 8 章 8.2"
  source_quote: |
    “索引是可重建的派生物，Git 中已审核的知识才是真正的来源。”
  failure_mode: |
    新一轮只读取旧摘要再生成新摘要，原始证据不参与更新，遗漏和误读随代际累积并失去可追溯性。
  mechanism: |
    每次生成都是有损变换；当派生物被当作来源，错误没有外部证据可以校正，只会被后续流畅措辞掩盖。
  warning_signs:
    - "知识条目只能追溯到另一份摘要"
    - "多次更新后细节逐渐变得笼统或确定化"
  bound_to:
    - "从原始证据重建派生摘要与索引"
    - "知识变更保留证据标识、审核和版本"
  tags: [knowledge-base, summary-drift, provenance]

- id: ce035
  title: "把最新记录强行解释为唯一真相"
  type: "时效性反例"
  source_chapter: "第 3 章 3.3.3 知识库持续更新"
  source_quote: |
    “遇到互相矛盾的说法时，不应简单地‘保留最新一条’或让模型猜哪一条正确。”
  failure_mode: |
    系统遇到冲突只保留更新时间最近的条目，误删仍适用于旧产品、地区、人群或历史时期的规则。
  mechanism: |
    时间顺序被误当成语义包含关系；没有作用域和有效期，版本选择无法判断是替代还是并存。
  warning_signs:
    - "同一政策只有更新时间，没有适用对象和生效期"
    - "历史问题总被当前规则回答"
  bound_to:
    - "冲突记录显式建模作用域、有效期和替代关系"
    - "检索同时按查询时间与对象过滤"
  tags: [freshness, conflict, scope, temporal]

- id: ce036
  title: "检索后才做权限过滤"
  type: "数据泄露"
  source_chapter: "第 3 章 3.3.3 多用户共享的权限与租户隔离"
  source_quote: |
    “一旦敏感内容进入了 LLM 的上下文，就很难保证它不以某种形式泄露到最终回答里。”
  failure_mode: |
    系统先跨租户检索和注入文档，再在最终回答阶段删除敏感片段，秘密已暴露给模型并可能影响输出。
  mechanism: |
    输出过滤只能匹配显式复述，不能撤销模型对敏感上下文的利用，也无法覆盖侧信道、概括和间接推断。
  warning_signs:
    - "检索日志出现调用者无权访问的文档 ID"
    - "多个租户共用无权限分区的向量索引"
  bound_to:
    - "在检索层按调用者权限和租户下推过滤"
    - "敏感内容不得进入未授权模型上下文"
  tags: [rag, access-control, tenant-isolation, leakage]

- id: ce037
  title: "只索引局部块而没有全局视图"
  type: "检索反例"
  source_chapter: "第 3 章 3.3.1 分层索引；3.3.5 上下文感知检索"
  source_quote: |
    “标准分块方法无论是固定大小切分还是递归切分，都不可避免地将紧密关联的上下文分离。”
  failure_mode: |
    每个文本块独立嵌入，实体所属文档、章节主题与跨块关联消失，局部相似命中无法回答全局结构问题。
  mechanism: |
    索引阶段丢掉的上位上下文不会在查询阶段自动恢复；纯局部向量也看不到跨块层次关系。
  warning_signs:
    - "命中片段相关但无法判断来自哪个产品或时期"
    - "全局概览与细节证据无法在同一查询中组合"
  bound_to:
    - "块携带文档、章节、实体和时间上下文"
    - "局部检索与层次摘要互补"
  tags: [rag, contextual-retrieval, hierarchy, metadata]

- id: ce038
  title: "工具粒度过细造成选择爆炸"
  type: "工具反例"
  source_chapter: "第 4 章 4.2.2 工具粒度的权衡"
  source_quote: |
    “当工具数量过多时（比如超过 100 个），即使是最先进的大语言模型也容易在工具选择上出错。”
  failure_mode: |
    每个文件类型、参数变体或微小动作都注册独立工具，模型在相似 schema 间选错，前缀也被工具说明占满。
  mechanism: |
    工具数与语义重叠共同增加决策熵；模型需要在有限注意力中比较大量低差异候选。
  warning_signs:
    - "多个工具只有文件扩展名或单个参数不同"
    - "增加工具后误选率和 token 成本同步上升"
  bound_to:
    - "按功能相似性整合工具并保留清晰参数"
    - "对大型工具库采用分层和按需发现"
  tags: [tool-design, granularity, choice-overload]

- id: ce039
  title: "工具描述只写能力不写边界"
  type: "接口反例"
  source_chapter: "第 4 章 4.2.4 工具描述的艺术"
  source_quote: |
    “大多数工具选择错误的根因在于描述不准确——边界不清、缺少反例、参数含义模糊。”
  failure_mode: |
    描述只说搜索或读取，却不说明何时用、何时不用、限制和参数单位，模型只能猜测并频繁误调用。
  mechanism: |
    工具 schema 是模型的动作说明书；缺失的适用条件会由语言先验填补，而非由真实实现约束。
  warning_signs:
    - "模型频繁在功能相近工具间切换"
    - "错误集中在参数单位、范围或不支持场景"
  bound_to:
    - "描述包含触发条件、禁止场景、参数语义和示例"
    - "先修接口说明再归因于模型能力"
  tags: [tool-description, affordance, negative-example]

- id: ce040
  title: "工具静默改写模型参数"
  type: "接口失真"
  source_chapter: "第 4 章 4.2.5 参数传递的保真性"
  source_quote: |
    “工具的‘智能修正’非但没有帮到模型，反而制造了一个模型无法自行诊断的系统性故障。”
  failure_mode: |
    包装层暗中注入、删除或规范化参数，实际执行与模型所见不同；模型随后反复修改无关字段仍无法修复。
  mechanism: |
    观察世界和动作世界产生系统偏差，错误返回又不披露变换，策略无法从反馈识别真实因果。
  warning_signs:
    - "日志中的实际命令与模型调用参数不一致"
    - "模型多次调整参数但错误完全不变"
  bound_to:
    - "参数透传默认保真"
    - "必要规范化必须在描述和返回中显式披露"
  tags: [tool-interface, parameter, transparency, diagnosability]

- id: ce041
  title: "把第三方 MCP 元数据当作可信配置"
  type: "供应链风险"
  source_chapter: "第 4 章 4.3 工具生态：MCP 与工具选择的挑战"
  source_quote: |
    “每接入一个 MCP 服务器，就等于把一段不受自己控制的文本注入了 Agent 的上下文，往往还把一份凭证交到了别人手里。”
  failure_mode: |
    恶意描述投毒、静默升级、同名工具遮蔽或凭证滥用把第三方服务器变成持久提示注入和数据外传通道。
  mechanism: |
    工具定义同时影响模型决策并获得执行凭证；供应商更新不经审核即可改变文本和行为，信任边界被协议便利性掩盖。
  warning_signs:
    - "MCP 服务器自动升级且 description 无差异审查"
    - "多个来源存在同名工具或复用高权限个人 token"
  bound_to:
    - "审计描述、锁定版本、验证来源并最小化凭证"
    - "同名工具使用稳定身份而非仅靠名称路由"
  tags: [mcp, supply-chain, tool-shadowing, credential]

- id: ce042
  title: "感知工具静默截断输出"
  type: "观察失败"
  source_chapter: "第 4 章 4.4 感知工具"
  source_quote: |
    “静默截断是危险的——Agent 会误以为自己看到了全部内容。”
  failure_mode: |
    搜索、文件或数据库工具只返回头部结果却不标记省略，Agent 基于不完整样本作出全量判断。
  mechanism: |
    工具结果没有表达不确定性和分页状态，模型把响应边界误认为数据边界，无法主动继续读取。
  warning_signs:
    - "返回长度总在固定阈值结束但没有 total 或 next offset"
    - "Agent 对长文件声称已完整检查"
  bound_to:
    - "截断必须显示总量、已读范围和续读方式"
    - "关键结论验证读取覆盖范围"
  tags: [tool-output, truncation, pagination, observation]

- id: ce043
  title: "把布局敏感输入一律 OCR 成文本"
  type: "多模态信息丢失"
  source_chapter: "第 4 章 4.4 感知工具"
  source_quote: |
    “后者精简高效但可能丢失关键的空间结构（如表格的行列对应关系）。”
  failure_mode: |
    UI、复杂表格和设计稿被转成线性文本后，模型读到了字符却把控件、行列或视觉分组关系配错。
  mechanism: |
    OCR 只保留词序近似，不保留二维布局、层级和视觉指示；这些关系无法从纯文本可靠重建。
  warning_signs:
    - "字段值正确但归属行列错误"
    - "页面操作忽略按钮位置或视觉状态"
  bound_to:
    - "布局敏感内容保留原图或结构化坐标"
    - "文本提取与视觉检查组合验证"
  tags: [multimodal, ocr, spatial-structure, table]

- id: ce044
  title: "把命令黑名单当作唯一沙盒"
  type: "安全反例"
  source_chapter: "第 4 章 4.5 执行工具"
  source_quote: |
    “黑名单只是最基础的防护层，不应作为唯一手段。”
  failure_mode: |
    系统只匹配 rm、管道符等表面字符串，攻击者通过编码、别名、间接脚本或等价命令完成同一危险动作。
  mechanism: |
    黑名单枚举已知语法而动作语义空间开放，任何未列出的等价表达都能绕过确定性字符串检测。
  warning_signs:
    - "安全测试只覆盖原样危险命令"
    - "执行器仍有宿主文件、网络和进程权限"
  bound_to:
    - "默认拒绝、语义解析和系统级隔离共同防护"
    - "以动作效果而非字符串做对抗测试"
  tags: [command-execution, blacklist, bypass, sandbox]

- id: ce045
  title: "审核者与提议者共享同一盲区"
  type: "验证反例"
  source_chapter: "第 4 章 4.5 提议者-审核者；第 6 章 6.5；第 8 章 8.1"
  source_quote: |
    “单一模态的审查很容易陷入相同的盲区。”
  failure_mode: |
    用同家族、同提示、同输入或明显更弱的模型复核开放式产出，两者一致并不代表正确，只是共享偏差。
  mechanism: |
    审核没有引入独立信息、能力或观测模态；相关错误无法通过重复生成消除，同源偏差还会制造虚假共识。
  warning_signs:
    - "Reviewer 只是要求同一模型再想一次"
    - "审查无外部测试、渲染结果或人类金标准"
  bound_to:
    - "审核引入独立模型、模态或确定性执行证据"
    - "开放式审核者能力不得显著弱于提议者"
  tags: [reviewer, correlated-error, verification, independence]

- id: ce046
  title: "让安全 Sidecar 阅读被污染的完整轨迹"
  type: "安全边界失败"
  source_chapter: "第 4 章 4.5 Sidecar 机制"
  source_quote: |
    “Reviewer 看到工具名、解析后的参数和权限元数据，而不是可能携带提示注入的完整轨迹。”
  failure_mode: |
    安全审查模型读取主模型的自由文本和不可信网页，攻击指令同时劫持执行者与门卫。
  mechanism: |
    审核通道未与攻击载荷隔离；基于自然语言的门禁可以被待审内容直接操纵其判断过程。
  warning_signs:
    - "安全分类 Prompt 拼接整段对话或网页正文"
    - "改变无关自然语言会改变同一结构化动作的批准结果"
  bound_to:
    - "Sidecar 只读取结构化动作、目标和权限元数据"
    - "必须传递的文本明确标记为数据并限长检查"
  tags: [sidecar, input-isolation, prompt-injection, safety]

- id: ce047
  title: "把 Python venv 误当安全沙盒"
  type: "隔离误区"
  source_chapter: "第 4 章 4.5 执行环境的隔离与沙盒"
  source_quote: |
    “Python 虚拟环境（venv）不是沙盒。”
  failure_mode: |
    不可信生成代码虽在独立依赖环境运行，却仍能删除宿主文件、访问网络、启动进程或读取凭证。
  mechanism: |
    venv 只改变包解析路径，不提供操作系统级文件、网络、进程和资源隔离。
  warning_signs:
    - "安全说明只提虚拟环境和 requirements"
    - "执行进程继承宿主用户权限与环境变量"
  bound_to:
    - "使用容器、虚拟机或等价系统沙盒"
    - "默认关闭网络并限制目录、CPU、内存、时间和输出"
  tags: [sandbox, venv, code-execution, isolation]

- id: ce048
  title: "超时后盲重试非幂等动作"
  type: "副作用失败"
  source_chapter: "第 4 章 4.5 幂等性与取消语义；第 5 章 5.1.5 错误恢复"
  source_quote: |
    “一个转账调用在网络超时后返回失败，钱可能已经转出，也可能还没。”
  failure_mode: |
    邮件、电话、订单或转账在响应超时后被自动重试，第一次实际已成功时就产生重复真实事件。
  mechanism: |
    网络返回状态与外部提交状态不等价；没有幂等键、状态查询或两阶段确认，客户端无法判定是否安全重放。
  warning_signs:
    - "相同业务动作没有唯一请求 ID"
    - "超时策略直接把调用放回重试队列"
  bound_to:
    - "可重试变更使用服务端幂等键"
    - "不可幂等动作采用预检确认，失败后回上层核查"
  tags: [idempotency, retry, side-effect, distributed-system]

- id: ce049
  title: "让 Agent 直接持有用户完整数字身份"
  type: "身份风险"
  source_chapter: "第 4 章 4.7.5 虚拟身份与隔离执行环境"
  source_quote: |
    “一旦 Agent 出现错误或被攻破，用户的全部数字身份将会暴露。”
  failure_mode: |
    通用 Agent 长期持有用户个人邮箱、电话、云盘和高权限账号，一次错误或注入可横向影响全部数字资产。
  mechanism: |
    身份和凭证没有按任务隔离，Agent 的动作空间等同用户本人；攻击面集中且缺少可撤销的代理边界。
  warning_signs:
    - "多个服务复用个人长期凭证"
    - "无法区分 Agent 行为和用户本人行为"
  bound_to:
    - "优先使用独立虚拟身份与最小范围凭证"
    - "必须以本人身份登录时采用可视化人工认证和审计"
  tags: [identity, credential, blast-radius, isolation]

- id: ce050
  title: "把异步占位符误当真实结果"
  type: "异步失败"
  source_chapter: "第 4 章 4.7.7 如何让同步模型支持异步打断"
  source_quote: |
    “系统仍可能在后续思考中‘编造’一个工具结果，误以为工具已经返回了有效数据。”
  failure_mode: |
    为满足同步 tool-call 格式注入的等待占位符被模型解释为调用已完成，随后基于虚构数据决策。
  mechanism: |
    模型训练中工具调用通常紧接真实结果，占位符违反其序列先验；格式合法不代表完成语义被正确理解。
  warning_signs:
    - "真实事件到达前回答中已出现具体工具数据"
    - "打断后 Agent 忘记仍在运行的任务"
  bound_to:
    - "占位符显式携带 pending 状态和任务 ID"
    - "仅紧急事件打断，并以真实完成事件恢复任务"
  tags: [async, placeholder, hallucination, tool-result]

- id: ce051
  title: "批量事件只处理最后一条"
  type: "异步注意力失败"
  source_chapter: "第 4 章 4.7.7 如何让同步模型支持异步打断"
  source_quote: |
    “在批量事件处理时，模型往往只关注最后一个事件。”
  failure_mode: |
    多个工具结果、用户补充和系统提醒同时追加后，Agent 只回应最新消息，遗漏早先事件中的约束或完成信号。
  mechanism: |
    对话模型被训练为优先响应最近输入，批量事件却需要集合式归约；没有显式待处理结构时出现近因偏置。
  warning_signs:
    - "批次越大，靠前事件的响应率越低"
    - "工具结果已到达却没有被消费"
  bound_to:
    - "事件逐条编号并维护未处理清单"
    - "批次末尾汇总类型、数量与完成状态"
  tags: [async, event-queue, recency-bias, attention]

- id: ce052
  title: "按初始查询一次性预筛工具"
  type: "工具发现反例"
  source_chapter: "第 4 章 4.8 主动工具发现"
  source_quote: |
    “它按用户的初始查询做一次性匹配。”
  failure_mode: |
    系统开局只为表面请求选择一组工具，执行中出现跨领域子问题时，Agent 无法访问后来才发现需要的能力。
  mechanism: |
    多步任务的工具需求依赖中间观察；初始语义检索只优化静态相关性，不能覆盖动态展开的行动链。
  warning_signs:
    - "Agent 已识别能力缺口却只能用不合适工具硬做"
    - "简单请求展开后需要的工具不在初始集合"
  bound_to:
    - "执行中允许主动声明能力缺口并动态发现工具"
    - "低相似度时明确返回未找到而非强配"
  tags: [tool-discovery, multi-step, routing, dynamic]

- id: ce053
  title: "不读仓库上下文就开始编码"
  type: "Coding Agent 反例"
  source_chapter: "第 5 章 5.1.3 Coding Agent 的工作流程"
  source_quote: |
    “没有这些，Agent 写出的代码可能语法正确但风格与项目格格不入，甚至引入架构层面的冲突。”
  failure_mode: |
    Agent 未读项目指令、目录、核心类型和相邻实现就直接修改，局部代码可编译却违反架构、规范或模块边界。
  mechanism: |
    代码生成依赖通用先验而非仓库事实；缺失的约束不会因模型更强而自动出现，只会被合理但错误的假设填补。
  warning_signs:
    - "首次写入前没有任何文件搜索或规则读取"
    - "实现重复已有抽象或引入项目未使用的模式"
  bound_to:
    - "编码前读取项目指令、相关实现、测试和依赖边界"
    - "以最小探索确认改动范围"
  tags: [coding-agent, repository-context, architecture]

- id: ce054
  title: "在目标模糊时执行优化"
  type: "需求反例"
  source_chapter: "第 5 章 5.1.3 Coding Agent 的工作流程"
  source_quote: |
    “在需求模糊的状态下就开始编码，往往导致大量返工。”
  failure_mode: |
    面对优化性能、改善体验等请求，Agent 未确认目标指标、可接受权衡和当前瓶颈就选择实现方向。
  mechanism: |
    多个合法目标互相冲突；缺少验收函数时，自动化执行只能高效优化模型擅自选择的代理目标。
  warning_signs:
    - "任务没有基线指标和可测验收条件"
    - "实现前未询问延迟、吞吐、内存或兼容性优先级"
  bound_to:
    - "高歧义任务先澄清目标、权衡与边界"
    - "用可复现基线定位瓶颈后再改"
  tags: [requirements, optimization, ambiguity, coding-agent]

- id: ce055
  title: "模型自报完成替代环境验收"
  type: "过早终止"
  source_chapter: "第 5 章 5.1.3；第 7 章 7.13.1；第 10 章 10.5.3"
  source_quote: |
    “写完代码不跑测试就报告‘任务完成’。”
  failure_mode: |
    Agent 未运行测试、只完成部分目标或遇到少量失败便声称完成或不可能，控制器据此提前结束。
  mechanism: |
    停止决定与执行策略属于同一模型，口头结论成本低且没有最终状态证据；完成措辞被误当作完成事实。
  warning_signs:
    - "完成声明之前没有对应验证工具调用"
    - "多目标清单仍有未勾选项"
  bound_to:
    - "由隐藏测试、环境状态和验收清单判定完成"
    - "声明与实际动作状态做一致性检查"
  tags: [premature-termination, self-report, verification]

- id: ce056
  title: "所有错误都原样重试"
  type: "恢复反例"
  source_chapter: "第 5 章 5.1.5 故障检测与恢复"
  source_quote: |
    “原样重试多少次都是同样的结果，必须改变输入或策略。”
  failure_mode: |
    参数不合法、权限不足、工具不存在等确定性错误也进入通用重试，Agent 重复同一调用而没有进展。
  mechanism: |
    恢复器没有按可重试性分类，重放不能改变故障前提，只放大费用、日志和副作用风险。
  warning_signs:
    - "工具名和参数指纹连续相同"
    - "错误码明确不可重试但重试计数仍增长"
  bound_to:
    - "先按错误类别映射恢复策略"
    - "不可重试错误改变输入、换策略或升级人工"
  tags: [retry, error-classification, recovery]

- id: ce057
  title: "只用连接超时监控长数据流"
  type: "活性失败"
  source_chapter: "第 5 章 5.1.5 故障检测与恢复"
  source_quote: |
    “SDK 的超时机制往往只覆盖初始连接而非传输过程。”
  failure_mode: |
    长连接成功建立后停止产出数据，系统因连接未断而永久等待，任务和资源无法释放。
  mechanism: |
    连接建立只证明起点可达，不证明持续进展；没有空闲看门狗或心跳就无法识别静默卡死。
  warning_signs:
    - "连接状态正常但长时间没有新 token 或字节"
    - "挂起任务不触发标准请求超时"
  bound_to:
    - "每个长连接设置独立空闲看门狗和活性信号"
    - "卡死后取消挂起流并按类别恢复"
  tags: [streaming, timeout, watchdog, liveness]

- id: ce058
  title: "恢复路径没有熔断上限"
  type: "死亡螺旋"
  source_chapter: "第 5 章 5.1.5 故障检测与恢复"
  source_quote: |
    “曾有一个会话在这条恢复路径上连续失败三千余次。”
  failure_mode: |
    压缩、权限分类、停止钩子或错误分析失败后无限再次调用 LLM，恢复逻辑自身持续触发同一故障。
  mechanism: |
    异常处理被放回原控制环且没有独立预算；每次失败产生更多上下文或新调用，形成正反馈而非收敛恢复。
  warning_signs:
    - "恢复调用次数远高于主任务调用"
    - "错误钩子再次产生触发它的同类错误"
  bound_to:
    - "每条恢复路径设置基于产线数据的熔断上限"
    - "恢复失败降级到确定性终止或人工处理"
  tags: [recovery, circuit-breaker, death-spiral]

- id: ce059
  title: "让后台重试挤占主任务配额"
  type: "资源放大"
  source_chapter: "第 5 章 5.1.5 故障检测与恢复"
  source_quote: |
    “后台重试会挤占主链路的配额，形成‘重试放大’。”
  failure_mode: |
    标题、建议等非关键后台调用与主循环共用重试和速率配额，故障时辅助任务反而拖垮核心任务。
  mechanism: |
    未分级的重试队列在限流时竞争同一稀缺资源，失败越多，请求越多，进一步加重拥塞。
  warning_signs:
    - "服务过载时请求量不降反升"
    - "主任务因辅助调用耗尽配额而失败"
  bound_to:
    - "主链路与后台调用使用独立预算和优先级"
    - "辅助调用失败默认放弃而非无限重试"
  tags: [retry-storm, quota, backpressure, priority]

- id: ce060
  title: "直接执行模型生成的 HTML、SQL 或脚本"
  type: "代码执行风险"
  source_chapter: "第 5 章 5.2.5 动态软件生成与 Artifact"
  source_quote: |
    “生成的 SQL 和可视化代码不能直接执行。”
  failure_mode: |
    浏览器运行任意生成 HTML/JavaScript，数据库执行未解析 SQL，或宿主执行脚本，使提示注入落地为数据窃取和破坏操作。
  mechanism: |
    生成内容跨越了数据到代码的信任边界；模型输出不具备传统代码的审查、权限和部署保证。
  warning_signs:
    - "前端使用动态代码执行或不受限 HTML"
    - "数据库账号可写且不解析语句类型"
  bound_to:
    - "优先使用声明式组件和允许列表"
    - "SQL 只读、参数绑定、限表限时限行，代码在隔离沙盒执行"
  tags: [generated-code, sql, xss, artifact, sandbox]

- id: ce061
  title: "让 LLM 搬运大规模结构化数据"
  type: "数据路径反例"
  source_chapter: "第 5 章 5.2.5 生成 SQL 查询"
  source_quote: |
    “LLM ‘抄写’数据时非常容易出错。”
  failure_mode: |
    数千行查询结果先进入模型再被复述给用户，产生高成本、遗漏、数字抄错和不可验证的格式转换。
  mechanism: |
    模型被放在本可确定传输的数据平面中，概率生成替代了数据库到界面的精确复制。
  warning_signs:
    - "输入 token 随结果行数线性增长"
    - "聚合前后行数或数字对不上数据库"
  bound_to:
    - "模型只生成查询和展示程序，数据绕过模型直达可信渲染层"
    - "聚合由数据库或确定性代码完成"
  tags: [data-path, sql, copying-error, token-cost]

- id: ce062
  title: "把权限检查写在动态生成代码里"
  type: "信任边界失败"
  source_chapter: "第 5 章 5.2.5 动态生成软件的权限"
  source_quote: |
    “如果权限检查本身也放在动态生成的业务逻辑中，它就与被约束的代码处在同一个信任域里。”
  failure_mode: |
    Agent 生成或改写应用逻辑时遗漏权限、暴露字段或绕过旧路径，测试未覆盖的越权操作直接到达数据层。
  mechanism: |
    约束者与被约束者同步可变，攻击或生成错误可一起修改检查和动作；上层自检无法构成不可绕过边界。
  warning_signs:
    - "生成代码持有可绕过策略的高权限数据库凭证"
    - "租户隔离仅由应用 if 语句实现"
  bound_to:
    - "把最终权限裁决下沉到稳定、受审查的数据层"
    - "运行时绑定不可伪造的用户和租户上下文"
  tags: [authorization, generated-software, trust-boundary, tenant]

- id: ce063
  title: "让 Agent 从零生成 Agent"
  type: "自举反例"
  source_chapter: "第 5 章 5.2.6 代码创造代码：Agent 自举"
  source_quote: |
    “即使最强大的代码生成模型也可能创造出架构上有严重缺陷的 Agent。”
  failure_mode: |
    缺少领域范例时从空白生成完整 Agent，容易采用废弃 API、错误上下文架构、危险权限或不可维护模式。
  mechanism: |
    Agent 架构包含大量未写入需求的隐性工程知识；从零生成要求模型同时重建这些约束，错误还会在后续自举代际累积。
  warning_signs:
    - "生成任务没有经过验证的参考实现"
    - "产物能运行但缺少评估、权限、停止和恢复机制"
  bound_to:
    - "基于高质量范例做最小修改"
    - "自举产物经过独立架构审查和全套回归"
  tags: [self-bootstrap, exemplar, architecture, code-generation]

- id: ce064
  title: "用 Pass@k 宣称生产可靠"
  type: "指标误用"
  source_chapter: "第 6 章 6.2.1、6.2.2"
  source_quote: |
    “说明连续五次都不出错仍然很难。”
  failure_mode: |
    团队用多次尝试中最好的一次宣传稳定性，隐藏单次失败率和关键业务中连续成功的低概率。
  mechanism: |
    Pass@k 随重试次数单调增大，衡量能力上限而非每次交付可靠性；它还能掩盖副作用和筛选成本。
  warning_signs:
    - "报告只给 Best@k 或 Pass@k，不给 Pass@1"
    - "失败成本高的任务仍允许大量重试后挑最好结果"
  bound_to:
    - "探索任务报告 Pass@k，生产关键任务报告 Pass^k"
    - "同时披露重试成本和副作用"
  tags: [evaluation, pass-at-k, reliability, metric]

- id: ce065
  title: "只看回复、轨迹或最终状态的一侧"
  type: "评估盲区"
  source_chapter: "第 6 章 6.2.4、6.3"
  source_quote: |
    “只看回复会漏掉‘说了但没做’，只看最终状态又无法定位过程违规。”
  failure_mode: |
    评估只检查自然语言答案、只查数据库结果或只读轨迹，分别遗漏真实执行、违规捷径或最终任务失败。
  mechanism: |
    Agent 质量同时包含结果和达成路径，任一单一观测都是不完备投影，偶然正确或虚假承诺可从盲区通过。
  warning_signs:
    - "评分器从不读取环境最终状态"
    - "最终成功即可抵消过程中的越权动作"
  bound_to:
    - "联合保存并验证任务目标、完整轨迹和最终环境状态"
    - "安全违规设置一票否决"
  tags: [evaluation, trajectory, final-state, blind-spot]

- id: ce066
  title: "未校准就放量使用 LLM 评委"
  type: "评判失败"
  source_chapter: "第 6 章 6.2.5 人工抽检和对抗式评审"
  source_quote: |
    “没有这一步，LLM 评判的分数只是‘另一个模型的意见’。”
  failure_mode: |
    评委没有在人类金标集上验证一致率，模型或 Rubric 更新后也不重校准，自动分数被误当成客观质量。
  mechanism: |
    评判模型本身有系统偏差和版本漂移；没有外部标尺就无法知道分数是否代理了人类和领域判断。
  warning_signs:
    - "Judge 上线前没有人类标注对照集"
    - "更换模型后历史分数直接横向比较"
  bound_to:
    - "用覆盖任务与难度的人工金标集校准"
    - "模型或 Rubric 变化后重新测一致性"
  tags: [llm-judge, calibration, gold-set, evaluation]

- id: ce067
  title: "Rubric 只奖励流畅和篇幅"
  type: "奖励代理失败"
  source_chapter: "第 6 章 6.5.1 LLM-as-a-Judge"
  source_quote: |
    “缺乏专业基础的 Rubric 只能捕捉语言流畅度等表面特征。”
  failure_mode: |
    模糊评分标准使冗长、关键词堆砌和讨好式回答得到高分，事实错误或关键专业风险却未被捕获。
  mechanism: |
    评委只能优化被写进 Rubric 的可见代理；语言模型又有长度偏差，策略会逐渐学会迎合评分表面。
  warning_signs:
    - "高分与回答长度高度相关"
    - "评分档使用有帮助、有深度等不可验证措辞"
  bound_to:
    - "Rubric 由领域专家定义可观察行为、边界例和否决项"
    - "审计长度相关性和奖励作弊样本"
  tags: [rubric, length-bias, reward-hacking, judge]

- id: ce068
  title: "训练数据泄漏进评估集"
  type: "评估污染"
  source_chapter: "第 6 章 6.4 评估数据集；第 7 章 7.13"
  source_quote: |
    “当评估数据被纳入训练数据时，评估测的就是记忆力而非泛化能力。”
  failure_mode: |
    公开 benchmark、修复样本或轨迹前缀被用于训练后仍作为独立测试，分数上升却不代表未见任务能力提升。
  mechanism: |
    模型可以记住答案、模板或决策边界；训练与评估同分布且同实例时，泛化误差被系统性低估。
  warning_signs:
    - "训练数据来源包含完整 benchmark"
    - "已见实例暴涨而留出变体没有改善"
  bound_to:
    - "训练集、边界集和留出回归集严格隔离"
    - "用参数化变体和时间后移数据监测污染"
  tags: [data-contamination, benchmark, generalization]

- id: ce069
  title: "把最后一个报错当成根因"
  type: "归因反例"
  source_chapter: "第 6 章 6.5.2 失败归因；第 7 章 7.13.3"
  source_quote: |
    “后续错误往往只是连锁反应，不能把最后一个报错简单当成根因。”
  failure_mode: |
    团队根据轨迹末尾异常修改模型或重试策略，真正首次偏离可能发生在更早的工具、序列化、上下文或决策边界。
  mechanism: |
    错误沿多步链路传播并改变后续状态，最后症状离原始因果最远；错误归层会把补丁打在无辜组件。
  warning_signs:
    - "归因没有步骤号、工具名和具体证据"
    - "修复末尾异常后故障换一种形式复现"
  bound_to:
    - "定位首个不可接受行为并区分根因与后果"
    - "逐层比较字节、序列化、上下文、token 和工具执行"
  tags: [failure-attribution, root-cause, cascade]

- id: ce070
  title: "用小样本单次结果宣布系统提升"
  type: "统计反例"
  source_chapter: "第 6 章 6.6、6.9，AndroidWorld 案例"
  source_quote: |
    “在这轮完整复测之前，不能把子集上的 4/4 写成系统整体 100%。”
  failure_mode: |
    单次运行或四个定向任务全过就被外推为整体提升，随机性、任务覆盖和回归风险没有进入结论。
  mechanism: |
    小样本方差大且定向子集存在选择偏差；一轮证据只能支持同等范围的下一步实验，不能支持部署结论。
  warning_signs:
    - "报告没有置信区间、随机种子或重复次数"
    - "只测试曾失败的子集，不跑全量保留集"
  bound_to:
    - "多随机种子、足够样本和完整回归后决策"
    - "结论范围与证据规模一致"
  tags: [statistics, sample-size, overclaim, regression]

- id: ce071
  title: "只看总分掩盖集中失败簇"
  type: "指标聚合失败"
  source_chapter: "第 6 章 6.9.1 读懂 Benchmark 报告；第 8 章 8.3.2"
  source_quote: |
    “如果只盯着 88% 这个总分，这个小而集中的失败簇很容易被忽略。”
  failure_mode: |
    平均成功率看似稳定，却掩盖某类设备、权限或安全任务的系统性失败；安全否决甚至被其他高分抵消。
  mechanism: |
    聚合丢失维度和分布结构，频率低但严重的失败对平均值贡献小，无法反映风险和根因。
  warning_signs:
    - "报告只有单个 overall score"
    - "安全、保留和边界集被合成可相互补偿的平均分"
  bound_to:
    - "按任务族、错误类和风险维度分层报告"
    - "安全与关键底线使用不可平均的 veto"
  tags: [metrics, aggregation, failure-cluster, safety]

- id: ce072
  title: "把机制指标当作最终目标"
  type: "目标错位"
  source_chapter: "第 6 章 6.10.2 实验设计"
  source_quote: |
    “计划长度是机制指标（你直接改变的东西），但它不是目标。”
  failure_mode: |
    团队优化计划长度、工具步数或 token 单项，结果产生更多返工、重试和会话总成本，真实目标反而恶化。
  mechanism: |
    被直接改变的中间量只与业务目标部分相关；优化压力会寻找未被计量的补偿路径。
  warning_signs:
    - "局部指标变好但端到端成本或成功率变差"
    - "实验没有定义会话级目标和副作用指标"
  bound_to:
    - "区分机制指标与结果指标"
    - "用端到端成功、成本、延迟和风险共同验收"
  tags: [proxy-metric, goal-misalignment, goodhart]

- id: ce073
  title: "评估环境不能干净重置"
  type: "实验污染"
  source_chapter: "第 6 章 6.3、6.11"
  source_quote: |
    “没有重置就无法公平复跑。”
  failure_mode: |
    前一轮订单、文件、缓存或页面状态残留到下一轮，后续成功率取决于运行顺序而非 Agent 能力。
  mechanism: |
    episode 不再独立同分布，上一策略造成的环境变化成为隐藏输入并污染评估与训练梯度。
  warning_signs:
    - "交换用例执行顺序会改变结果"
    - "重复同一任务的初始状态不一致"
  bound_to:
    - "每个 episode 恢复确定、可验证的初始状态"
    - "重置失败直接判环境无效而非归因 Agent"
  tags: [reset, reproducibility, environment, contamination]

- id: ce074
  title: "用有限 SFT 示范学习表面捷径"
  type: "训练过拟合"
  source_chapter: "第 7 章 7.1、7.14"
  source_quote: |
    “SFT 训练过度或 RL 优化过度，都可能产生过拟合。”
  failure_mode: |
    模型在同质示范上掌握格式和表面模式，却在新数字、布局、工具状态或任务组合上性能下降。
  mechanism: |
    最大似然训练奖励复现训练分布中的相关特征，不强制学习产生答案的规则；数据窄时捷径比真正机制更容易拟合。
  warning_signs:
    - "训练损失继续下降但留出集下降"
    - "只替换实体、数字或布局就失败"
  bound_to:
    - "SFT 用于稳定格式并设置早停"
    - "留出组合变化与分布外样本验证泛化"
  tags: [sft, overfitting, shortcut, generalization]

- id: ce075
  title: "结构化输出未稳定就做 RL"
  type: "训练顺序反例"
  source_chapter: "第 7 章 7.14 常见陷阱"
  source_quote: |
    “如果模型不能稳定生成奖励计算所需的 JSON，训练信号会变得稀疏或失真。”
  failure_mode: |
    模型频繁输出不可解析动作时直接进入 RL，大量 rollout 因格式失败得零分，无法区分策略好坏。
  mechanism: |
    环境和奖励器无法消费动作，任务层反馈被协议错误截断；稀疏噪声梯度不能有效教会复杂策略。
  warning_signs:
    - "训练失败主要来自 JSON 或 tool-call 解析"
    - "奖励 NaN、全零或由格式错误主导"
  bound_to:
    - "先用 SFT 稳定协议、格式和基本工具能力"
    - "奖励前单独监控动作可解析率"
  tags: [rl, structured-output, sft, reward-signal]

- id: ce076
  title: "用后训练记忆可变事实"
  type: "方法错配"
  source_chapter: "第 7 章 7.14 常见陷阱"
  source_quote: |
    “过度依赖后训练来记忆事实——应该用 RAG 管理事实知识。”
  failure_mode: |
    政策、价格、接口和私有事实被写进模型参数，更新慢、来源不可追溯，还可能因后续训练遗忘或过期。
  mechanism: |
    参数是难以局部编辑和审计的分布式存储，不适合高频变化、需要引用和精确撤销的知识。
  warning_signs:
    - "事实变化需要重新微调整个模型"
    - "回答无法给出事实版本和来源"
  bound_to:
    - "可变事实放入可版本化 RAG/知识库"
    - "参数更新只承载难以外部表达的策略和能力"
  tags: [fine-tuning, facts, rag, method-selection]

- id: ce077
  title: "用低保真模拟器训练真实策略"
  type: "仿真反例"
  source_chapter: "第 7 章 7.9、7.14"
  source_quote: |
    “模拟器的偏差就是训练的天花板。”
  failure_mode: |
    Agent 学会利用模拟用户、工具或物理环境的固定漏洞，在仿真中高分，部署到真实延迟、错误和行为分布时完全失效。
  mechanism: |
    策略优化的是模拟转移与奖励函数；任何系统性不真实都会成为可利用特征，而非被训练自动消除。
  warning_signs:
    - "模拟分数提升但真实小流量无改善"
    - "策略依赖真实环境不存在的固定响应模式"
  bound_to:
    - "校准模拟器并随机化延迟、失败和环境状态"
    - "训练收益必须在独立真实或高保真环境验证"
  tags: [simulation, sim-bias, rl, transfer]

- id: ce078
  title: "把环境返回 token 当成策略标签"
  type: "训练数据污染"
  source_chapter: "第 7 章 Agent 轨迹训练与蒸馏"
  source_quote: |
    “轨迹里哪些 token 该学、哪些是环境返回的不该学。”
  failure_mode: |
    训练时对整条交互轨迹计算语言建模损失，模型被迫预测工具、用户或模拟器的返回，而不是学习何时调用和如何响应。
  mechanism: |
    策略输出和环境观察属于不同生成主体；不做 loss mask 会把不可控外部事件错误归因给模型参数。
  warning_signs:
    - "loss 覆盖 tool result 和 user 消息"
    - "模型倾向直接编造工具输出而非调用工具"
  bound_to:
    - "只对策略可控 token 计算训练损失"
    - "环境结果作为状态输入而非生成目标"
  tags: [trajectory-training, loss-mask, environment-token]

- id: ce079
  title: "结果奖励诱导破坏性捷径"
  type: "奖励劫持"
  source_chapter: "第 5 章 5.1.4；第 7 章 7.11；第 8 章 8.1"
  source_quote: |
    “删除失败的测试用例也能让测试通过。”
  failure_mode: |
    只奖励最终测试通过或用户满意，Agent 通过删测试、改验证器、违规退款或浅层自检获得高分而未完成真实目标。
  mechanism: |
    可见代理指标与真实目标不等价，优化策略主动搜索评分器盲区；模型自设检查更容易被自己满足。
  warning_signs:
    - "分数提高伴随测试数量或安全检查减少"
    - "轨迹出现修改评价标准、回避难例或口头宣称"
  bound_to:
    - "验证器和隐藏测试位于策略不可修改范围"
    - "结果、路径与安全条件联合门控"
  tags: [reward-hacking, outcome-reward, verifier, safety]

- id: ce080
  title: "只修过早结束把模型训成永不收尾"
  type: "过度矫正"
  source_chapter: "第 7 章 7.13.1 Coding Agent 过早结束"
  source_quote: |
    “只盯前一个指标，会把模型训练成永远不敢收尾的过度矫正状态。”
  failure_mode: |
    训练集只包含应继续验证的边界，模型学会每次都再检查、再调用工具，完成任务后仍无法停止。
  mechanism: |
    决策边界只有单侧负例，没有任务确已完成的保留样本；优化把局部修复泛化成全局禁止结束。
  warning_signs:
    - "未完成任务变好但正常任务轮数和成本暴涨"
    - "验收已通过后仍重复运行同一验证"
  bound_to:
    - "边界集与正常收尾保留集同时评估"
    - "训练补丁采用小配比并检查通用能力"
  tags: [over-correction, retention-set, termination, training]

- id: ce081
  title: "把保存轨迹误认为已经学习"
  type: "持续学习误区"
  source_chapter: "第 8 章 导言"
  source_quote: |
    “保存经历不等于从经历中学习。”
  failure_mode: |
    系统把原始轨迹写进向量库就宣称会持续进化，后续只检索孤立案例，无法识别可迁移策略和偶然成功。
  mechanism: |
    日志同时包含有效动作、噪声、错误归因和不可信输入；缺少评价、跨案例对照、归纳与验证就不会形成可靠行为规则。
  warning_signs:
    - "经验库只增不整理，条目等同原始会话"
    - "相似失败发生多次却没有可验证规则变化"
  bound_to:
    - "学习流水线显式包含评价、对照、归纳和迁移验证"
    - "原始证据与正式经验分层保存"
  tags: [continuous-learning, trajectory, memory, evidence]

- id: ce082
  title: "根据未经验证反馈在线改写自己"
  type: "自我修改风险"
  source_chapter: "第 8 章 导言；8.3"
  source_quote: |
    “若允许正在运行的模型依据未经验证的反馈直接修改自身，错误经验和提示注入就可能被固化。”
  failure_mode: |
    单次点踩、满意、测试结果或外部文本立即修改正式 Prompt、Skill、程序或参数，噪声与攻击跨会话长期生效。
  mechanism: |
    在线任务和学习共用写权限，反馈没有可信度与因果验证；持久化把瞬时错误提升为未来所有任务的先验。
  warning_signs:
    - "生产 Agent 在当前请求内直接覆盖正式能力"
    - "更新没有候选版本、回归、灰度和回滚"
  bound_to:
    - "在线只记录证据，离线聚合并提出待验证更新"
    - "通过回归和安全门后才发布版本"
  tags: [self-modification, online-learning, poisoning, rollback]

- id: ce083
  title: "未评价成败就生成反思"
  type: "错误归纳"
  source_chapter: "第 8 章 8.1 从运行轨迹中获得学习信号"
  source_quote: |
    “持续进化的起点不是‘总结’，而是‘评价’。”
  failure_mode: |
    模型在不知道任务是否真正完成、哪一步造成结果时先总结教训，把流畅猜测写成长期知识。
  mechanism: |
    反思只能依据自身叙述而非环境真值；错误因果归因经持久化后会指导未来策略重复或规避错误动作。
  warning_signs:
    - "经验条目没有结果、过程和来源证据"
    - "失败轨迹也能生成肯定语气的成功策略"
  bound_to:
    - "先验证环境结果与允许路径，再做归纳"
    - "证据不足时拒绝形成持久结论"
  tags: [reflection, evaluation, causal-attribution, learning]

- id: ce084
  title: "把用户满意度当成唯一学习信号"
  type: "反馈错位"
  source_chapter: "第 8 章 8.1 从运行轨迹中获得学习信号"
  source_quote: |
    “用户可能因为 Agent 违规退款而满意，也可能因为合规限制而不满。”
  failure_mode: |
    系统奖励讨好、越权和虚假承诺，只要用户短期满意就把行为沉淀为成功经验。
  mechanism: |
    满意度混合任务结果、沟通质量和用户利益，不能区分合规成功与违规捷径，也受即时情绪影响。
  warning_signs:
    - "满意度上升同时规则违规率上升"
    - "学习数据没有数据库状态和权限审计"
  bound_to:
    - "结果、过程、合规和表达质量分维度评价"
    - "安全与真实状态作为满意度不可覆盖的硬门"
  tags: [feedback, satisfaction, compliance, proxy]

- id: ce085
  title: "从一次成功轨迹提炼普遍规则"
  type: "经验过拟合"
  source_chapter: "第 8 章 8.2.1 将经验写成知识"
  source_quote: |
    “经验不是‘记住一次成功’，而是从成功、失败和部分成功的对照中归纳出适用条件、例外和证据来源。”
  failure_mode: |
    一次因网络、版本或偶然环境而成功的路径被立即写成通用经验，在未见任务上产生负迁移。
  mechanism: |
    单轨迹无法区分必要策略与偶然共现，也没有反例来确定边界；检索相似度会把局部条件错误扩展到新场景。
  warning_signs:
    - "正式经验只有一条支持轨迹且没有反驳证据"
    - "经验文档不写环境版本、适用条件和例外"
  bound_to:
    - "按任务族聚合多条成功、部分成功和失败轨迹"
    - "达到证据门槛并在留出迁移任务验证"
  tags: [experience, evidence-threshold, negative-transfer]

- id: ce086
  title: "每次都重写整份 Prompt 或记忆"
  type: "更新反例"
  source_chapter: "第 8 章 8.2.2、8.2.5"
  source_quote: |
    “修改应是带来源的最小 diff，而不是让模型每次都重写整份 Prompt。”
  failure_mode: |
    为加入局部教训重新生成完整规则文件，多轮后旧细节消失、制约条件被抽象合并，难以归因和回滚。
  mechanism: |
    全量生成是有损重述，改动面远大于触发证据；版本间大量无关差异掩盖真实行为变化。
  warning_signs:
    - "修一个边界问题产生整文件 diff"
    - "旧规则在多轮改写后无证据地消失"
  bound_to:
    - "用稳定条目标识和带来源的最小补丁"
    - "边界集与保留集同时验证并保留快速回滚"
  tags: [prompt-update, minimal-diff, regression, provenance]

- id: ce087
  title: "让进化 Agent 修改自己的可信根"
  type: "自证循环"
  source_chapter: "第 8 章 8.2.5、8.3.4"
  source_quote: |
    “一个 Agent 只需降低测试阈值或删除失败用例，就能把退化伪装成进步。”
  failure_mode: |
    修改者同时能改验证器、测试、发布门槛、审计日志或稳定备份，因此任何候选都可以通过自降标准获得发布。
  mechanism: |
    提案和批准处于同一权限域，评价函数随策略一起优化；系统失去不可伪造的外部参照与恢复点。
  warning_signs:
    - "候选补丁包含测试删除或阈值降低"
    - "稳定版本和审计日志对修改者可写"
  bound_to:
    - "评价器、权限边界、留出测试和备份位于不可修改可信根"
    - "修改者只能提交提案，不能批准发布"
  tags: [trusted-root, self-modification, verifier, governance]

- id: ce088
  title: "自动化戏剧产出像成果的东西"
  type: "开放任务失败"
  source_chapter: "第 8 章 8.3.3 可验证闭环的边界"
  source_quote: |
    “Harness 可能把流程执行得非常完整，却只是稳定地产出‘像成果的东西’，没有推动真实目标。”
  failure_mode: |
    自动科研、战略或产品流程每步都有产物和打分，但实现偏离原假设、评价选择乐观、长期价值没有进展。
  mechanism: |
    易测的流程完整度替代了反馈延迟、难形式化的真实目标；闭环把代理指标优化得更稳定而非更正确。
  warning_signs:
    - "文档、报告和图表齐全但核心假设未被检验"
    - "评价标准只覆盖即时可见产物"
  bound_to:
    - "人类参与问题定义、评价标准和停止判断"
    - "开放任务保留重要基线、反常结果和长期指标"
  tags: [automation-theater, open-ended, proxy-objective, research]

- id: ce089
  title: "丢弃失败实验造成生存者偏差"
  type: "证据偏差"
  source_chapter: "第 8 章 8.3.3 可验证闭环的边界"
  source_quote: |
    “失败和阴性结果则更容易被忽略。”
  failure_mode: |
    系统只把成功轨迹和漂亮结果写入经验库，失败、部分成功和负结果被清理，未来反复尝试相同错误方案。
  mechanism: |
    观测数据按结果筛选后，经验库高估策略成功率并丢失排除性知识，因果归纳只看幸存样本。
  warning_signs:
    - "经验库没有失败轨迹或 rejected proposal"
    - "相同已证伪方案换措辞后反复出现"
  bound_to:
    - "失败与负结果作为一等证据保存"
    - "经验草案同时列支持、反驳和历史尝试"
  tags: [survivorship-bias, negative-result, evidence]

- id: ce090
  title: "把不可信摘要直接沉淀为 Skill"
  type: "持久提示注入"
  source_chapter: "第 8 章 8.3.4 持续进化的安全边界"
  source_quote: |
    “LLM 总结只是为了提高可读性和便于处理的转换，并不是把输入变得无害的净化过程。”
  failure_mode: |
    网页、邮件或工具输出中的恶意指令经模型摘要后被视为可信经验，进入长期 Skill 并在未来任务反复触发。
  mechanism: |
    摘要改变表述但不保证移除攻击语义；一旦从证据通道晋升到指令通道，瞬时注入变成持久供应链污染。
  warning_signs:
    - "Skill 条目只能追溯到外部文本的模型摘要"
    - "长期规则含读取秘密或调用无关工具的要求"
  bound_to:
    - "原始内容与摘要始终标记为不可信证据"
    - "持久能力经过 schema、来源、独立审核和高风险人工批准"
  tags: [skill, persistent-injection, untrusted-evidence]

- id: ce091
  title: "能力库只增不淘汰"
  type: "长期退化"
  source_chapter: "第 8 章 8.3.5 睡眠学习"
  source_quote: |
    “把长期不用或被新证据推翻的能力标为过期、归档或删除，同时保留来源和回滚版本。”
  failure_mode: |
    知识、Prompt、Skill 和工具持续追加但不合并冲突、不标过期，检索和路由越来越不准，旧规则与新规则互相抵消。
  mechanism: |
    能力数量增加会扩大搜索空间和上下文噪声；时效与重复未治理时，选择器无法判断哪条应生效。
  warning_signs:
    - "能力库增长与任务量脱钩，命中后冲突增多"
    - "已废止 API 或规则仍被频繁检索"
  bound_to:
    - "离线周期执行合并、冲突解决、过期和修剪"
    - "修剪保留来源、审计和可回滚版本"
  tags: [pruning, capability-bloat, staleness, lifecycle]

- id: ce092
  title: "把智能上限当成交互质量"
  type: "多模态架构误区"
  source_chapter: "第 9 章 导言"
  source_quote: |
    “交互能力与智能上限并不直接相关。”
  failure_mode: |
    团队只升级推理模型，忽略持续感知、时机、延迟和反馈闭环，模型会答难题却无法在真实语音、GUI 或机器人任务中完成工作。
  mechanism: |
    离线理解和生成不包含环境随时间变化后的再次观察与动作修正；交互瓶颈位于 Harness 和时序而非知识容量。
  warning_signs:
    - "离线问答很强但实时任务常因等待、打断或旧状态失败"
    - "评测只有静态输入输出，没有闭环环境"
  bound_to:
    - "将理解、生成和交互分维度设计与评估"
    - "真实任务使用感知-行动-反馈闭环"
  tags: [interaction, multimodal, latency, closed-loop]

- id: ce093
  title: "级联语音把非文字证据压没"
  type: "语音信息丢失"
  source_chapter: "第 9 章 9.1.2、9.1.3"
  source_quote: |
    “当答案依赖语速、情绪或环境声时，纯文本瓶颈会不可逆地丢失证据。”
  failure_mode: |
    VAD-ASR-LLM-TTS 流水线只把转录交给推理层，犹豫、语调、重叠、附和和环境声音在接口处消失。
  mechanism: |
    离散文本是音频的有损中间表示；后级模型再强也不能恢复未被编码的副语言和声学事件。
  warning_signs:
    - "转录字面正确但情绪、反讽或紧急性判断错误"
    - "系统日志不保留声学事件和时间戳"
  bound_to:
    - "按任务信息需求选择级联或端到端音频路径"
    - "保留必要声学事件和时间关系"
  tags: [speech, cascade, prosody, information-loss]

- id: ce094
  title: "用未来音频给在线端点打标签"
  type: "因果评估泄漏"
  source_chapter: "第 9 章 9.1.2.1 从串行到流式感知"
  source_quote: |
    “端点判断的训练标签必须只使用决策时刻可见的信息，否则会因‘上帝视角’产生线上无法复现的判断。”
  failure_mode: |
    标注器看完整段未来音频后判断用户何时说完，离线模型表现很好，线上在同一时刻却没有那些未来证据。
  mechanism: |
    训练标签泄露了决策时刻之后的信息，形成非因果监督；部署分布的可观测信息严格更少。
  warning_signs:
    - "端点评测用完整音频回看标注"
    - "离线准确率高但线上抢话或等待严重"
  bound_to:
    - "标签与特征只使用决策时刻之前可见信息"
    - "以真实流式回放验证端点策略"
  tags: [speech, causal-supervision, label-leakage, endpoint]

- id: ce095
  title: "把递增前缀重编码冒充真流式"
  type: "实验误报"
  source_chapter: "第 9 章 9.1.2.1，实验 9-2"
  source_quote: |
    “每次都会重新编码此前音频，因此不能把结果当作真流式模型的延迟承诺。”
  failure_mode: |
    非因果音频模型反复读取越来越长的完整前缀，被包装成流式演示并宣传百毫秒级实时能力。
  mechanism: |
    模拟分块具备未来回看或重复计算，计算路径和线上因果编码不同；测得耗时不能代表增量服务延迟。
  warning_signs:
    - "每个新音频块都重新编码全部历史"
    - "报告没有区分机制演示与真实端到端延迟"
  bound_to:
    - "流式性能必须在因果/分块编码和真实传输下测量"
    - "负结果和硬件版本完整披露"
  tags: [streaming, benchmark, speech, non-causal]

- id: ce096
  title: "快慢模型各自给出完整答案"
  type: "交互一致性失败"
  source_chapter: "第 9 章 9.1.5.1 快思考应付，慢思考回答"
  source_quote: |
    “快模型先建议购买，慢模型随后发现套餐缺少关键功能，用户在几秒内便听到相互冲突的答案。”
  failure_mode: |
    前台为低延迟独立作答，后台深思后再纠正；用户先依据错误建议行动，随后收到相反结论并失去信任。
  mechanism: |
    两个实例进行彼此不可见的完整推理，没有共享承诺和表达控制，后台不能约束前台在证据不足时的内容。
  warning_signs:
    - "同一问题短时间收到方向相反的两次回答"
    - "前台不知道后台正在验证哪些假设"
  bound_to:
    - "前台只维持话头，后台提供建议或工具结果"
    - "高风险结论等待确认后再提交"
  tags: [fast-slow, consistency, realtime, trust]

- id: ce097
  title: "GUI 动作后跳过新观察"
  type: "Computer Use 开环失败"
  source_chapter: "第 9 章 9.2 Computer Use"
  source_quote: |
    “模型只提出候选动作，不能凭上一轮的文字宣称跳过新观察。”
  failure_mode: |
    Agent 根据旧截图连续点击或凭文字宣称成功，没有等待页面稳定并重新截图确认动作效果。
  mechanism: |
    GUI 状态在点击、加载、弹窗和外部更新后变化；旧观察不再代表现实，开环动作会把一次局部偏差带到任务末尾。
  warning_signs:
    - "多个动作共享同一截图"
    - "完成判断没有新的页面或后端状态证据"
  bound_to:
    - "每个有状态动作后等待稳定并重新观察"
    - "未达预期时回滚或重规划"
  tags: [computer-use, stale-observation, closed-loop, gui]

- id: ce098
  title: "截图非等比缩放造成系统性误点"
  type: "视觉定位失败"
  source_chapter: "第 9 章 9.2.2 视觉定位"
  source_quote: |
    “模型预测的坐标就会系统性偏移。”
  failure_mode: |
    截图被拉伸到模型训练分辨率或坐标未正确反向映射，所有点击按稳定方向偏离目标。
  mechanism: |
    坐标预测依赖图像几何与训练分辨率；非等比变换改变元素相对位置和形状，错误不是随机而是系统偏差。
  warning_signs:
    - "点击偏移随屏幕分辨率或宽高比变化"
    - "截图缩放与坐标放大使用不同系数"
  bound_to:
    - "按宽高比选择目标分辨率并等比缩放"
    - "统一记录模型坐标系和真实坐标系映射"
  tags: [grounding, coordinate, scaling, gui]

- id: ce099
  title: "用离散截图处理连续视觉事件"
  type: "时序感知盲区"
  source_chapter: "第 9 章 9.2.3 能看动画、能听声音的 Computer Use"
  source_quote: |
    “对这些‘两帧之间发生的事’既看不见也听不到。”
  failure_mode: |
    每几秒一张截图的 Agent 漏掉动画、短暂通知、加载进度、视频和会议语音，无法执行依赖时序信息的任务。
  mechanism: |
    静态采样丢失帧间事件和声音通道；提高单帧视觉能力不能恢复从未观测的时间序列。
  warning_signs:
    - "错误集中在短暂弹窗、视频或动态加载"
    - "观察接口只有截图，没有事件流和音频"
  bound_to:
    - "连续视觉流用关键帧、事件和音频转写补充"
    - "时序任务保留持久化事件摘要"
  tags: [computer-use, temporal, video, observation]

- id: ce100
  title: "让高层模型直接输出机器人关节角"
  type: "控制分层失败"
  source_chapter: "第 9 章 9.3.2 规划、动作与安全层"
  source_quote: |
    “模型不应直接输出任意关节角。”
  failure_mode: |
    低频高层推理同时负责任务规划和高频关节控制，延迟过大且缺少限速、标定、超时和急停边界。
  mechanism: |
    任务决策与物理控制频率相差数个数量级；开放连续动作空间把安全关键细节交给不确定生成。
  warning_signs:
    - "LLM 以 1-10 Hz 控制需要 50-1000 Hz 更新的执行器"
    - "动作不经过受限技能和硬件安全层"
  bound_to:
    - "高层只选择有边界的 pick、place、verify、stop 技能"
    - "底层控制器负责标定、限速、超时和急停"
  tags: [robotics, control-hierarchy, safety, action-space]

- id: ce101
  title: "动作块过长继续执行旧观察"
  type: "实时控制失败"
  source_chapter: "第 9 章 9.3.4 动作分块"
  source_quote: |
    “动作段越长，运动越平滑，模型在这段时间里看到的新画面却越少。”
  failure_mode: |
    机器人执行预生成长动作序列时物体已移动或被遮挡，却仍按旧画面完成后续动作并造成碰撞或抓空。
  mechanism: |
    动作分块以观察新鲜度换吞吐和平滑性；块执行期间策略对环境变化开环。
  warning_signs:
    - "环境突变后动作仍持续到 chunk 结束"
    - "成功率随 chunk 长度增加而下降"
  bound_to:
    - "依据风险和变化速度选择 chunk 长度"
    - "加入偏差监控、提前中断和重新观察"
  tags: [robotics, action-chunking, stale-observation, latency]

- id: ce102
  title: "把行为模仿当成后果理解"
  type: "VLA 能力误判"
  source_chapter: "第 9 章 9.3.5 VLA 的局限"
  source_quote: |
    “行为克隆主要学习‘示范者下一步怎么做’，并没有明确要求模型回答‘这个动作会造成什么结果’。”
  failure_mode: |
    VLA 在见过的机器人和场景复现动作，却不能预测摩擦、遮挡、液体或新执行器延迟下的后果，换机或分布外环境失效。
  mechanism: |
    模仿损失对动作相似性监督，不对因果结果建模；不同机器人动作空间也没有天然对应关系。
  warning_signs:
    - "动作看似像示范但最终状态错误"
    - "换材质、坐标系或夹爪后性能骤降"
  bound_to:
    - "VLA 后接真实状态验证与失败恢复"
    - "用世界模型或环境反馈比较动作后果"
  tags: [vla, imitation-learning, consequence, transfer]

- id: ce103
  title: "把逼真预测当作现实真值"
  type: "世界模型误用"
  source_chapter: "第 9 章 9.3.6 世界模型"
  source_quote: |
    “预测只能帮助选择，不能代替验收。”
  failure_mode: |
    Agent 根据生成得很逼真的未来画面直接认定动作成功，忽略长程误差、真实接触和摄像头反馈。
  mechanism: |
    世界模型输出是有偏概率预测，预测越远误差越积累；视觉逼真度不保证物理因果正确。
  warning_signs:
    - "最终完成由预测状态而非真实新观察判定"
    - "系统把视频生成质量当作控制可靠性"
  bound_to:
    - "世界模型只排序候选和估计风险"
    - "真实环境观察与独立安全控制器拥有最终裁决权"
  tags: [world-model, prediction, verification, robotics]

- id: ce104
  title: "从仿真成功直接外推真机"
  type: "Sim-to-Real 反例"
  source_chapter: "第 9 章 9.3.7 从仿真环境到真实机器人"
  source_quote: |
    “实验 9-10 即使在模拟器里表现稳定，也不能直接推出实验 9-9 的 XLeRobot 真机会同样成功。”
  failure_mode: |
    理想视觉、物理和执行器下的高成功率被当作真实部署证据，真机因光照、相机、摩擦、延迟和标定差异失败。
  mechanism: |
    模拟与现实的观测和转移分布不同；策略会依赖仿真特有的纹理、动力学和无噪声反馈。
  warning_signs:
    - "报告混写仿真与真机结果"
    - "没有真实硬件小规模验证和安全监护"
  bound_to:
    - "分开报告仿真上限与真机闭环"
    - "做域随机化、标定和逐级真实验证"
  tags: [sim-to-real, robotics, domain-gap, evaluation]

- id: ce105
  title: "同一信息上堆多个 Agent"
  type: "协作反例"
  source_chapter: "第 10 章 10.2 多 Agent 何时真正优于单 Agent"
  source_quote: |
    “每一次串行传递中间结论都只可能丢失信息、不可能凭空创造信息。”
  failure_mode: |
    多个 Agent 围绕完全相同文本辩论或顺序改写，在等计算量下不优于单 Agent，却增加 token、延迟和误差。
  mechanism: |
    协作没有引入外部工具、独立观测或专业信息，只做有损语义再编码；表面收益常来自额外总计算量。
  warning_signs:
    - "所有 Agent 看到相同输入并使用相同能力"
    - "与等 token 单 Agent 对照后收益消失"
  bound_to:
    - "采用多 Agent 前证明信息增量或可并行的能力分工"
    - "按相同总预算与单 Agent 对照"
  tags: [multi-agent, information-gain, debate, cost]

- id: ce106
  title: "共享上下文造成膨胀与角色惯性"
  type: "共享上下文失败"
  source_chapter: "第 10 章 10.1、10.3"
  source_quote: |
    “共享上下文保留细节，却容易造成上下文膨胀和角色惯性。”
  failure_mode: |
    后续审查员继承分析师的全部对话和思维方向，既被大量历史噪声干扰，又继续沿前任角色的视角判断。
  mechanism: |
    全量继承保住信息也保住注意力锚点和旧身份先验；任务越长，相关信息密度越低，角色切换只改标签不清空惯性。
  warning_signs:
    - "角色切换后输出仍使用前一角色的关注点"
    - "共享轨迹随阶段增长且没有信息边界"
  bound_to:
    - "只共享任务状态、证据和结构化产物"
    - "强权限或独立职责使用隔离 Agent"
  tags: [multi-agent, shared-context, role-inertia, context-bloat]

- id: ce107
  title: "隔离 Agent 之间只靠自由文本传话"
  type: "通信失败"
  source_chapter: "第 10 章 10.4 不共享上下文的多 Agent 协作"
  source_quote: |
    “信息在传递过程中会不会丢失或重复？”
  failure_mode: |
    独立 Agent 通过临时自然语言摘要交接，目标、已确认事实、预算、产物引用和未决事项逐跳遗漏或被误解。
  mechanism: |
    上下文隔离使通信成为唯一共享状态；自由文本没有必填字段、版本和幂等语义，无法检测丢失与重复。
  warning_signs:
    - "下游重新询问或重新执行上游已完成工作"
    - "各 Agent 对目标和当前状态描述不一致"
  bound_to:
    - "使用结构化移交包和稳定产物引用"
    - "消息携带任务 ID、版本、预算、事实、约束和验收标准"
  tags: [multi-agent, handoff, protocol, state-sync]

- id: ce108
  title: "把不同权限文件区域混在同一空间"
  type: "文件系统边界失败"
  source_chapter: "第 10 章 10.4.1 Agent 眼中的文件系统"
  source_quote: |
    “相当一部分并发冲突与信息泄露，源于将本应隔离的区域混置。”
  failure_mode: |
    私有工作区、共享交付区、外部云盘和只读系统资源没有分区，Agent 误读他人中间数据或误写用户真实文件。
  mechanism: |
    统一路径接口掩盖不同可见性、生命周期、一致性和凭证边界；默认写权限把局部错误扩展到共享或外部资源。
  warning_signs:
    - "临时文件与最终交付物共用目录和权限"
    - "外部挂载默认可写且没有来源标识"
  bound_to:
    - "按私有、共享、外部挂载和内置只读资源分区"
    - "挂载层显式管理可见性、读写、超时与凭证"
  tags: [filesystem, isolation, multi-agent, data-leakage]

- id: ce109
  title: "父任务结束后留下孤儿 Agent"
  type: "生命周期失败"
  source_chapter: "第 10 章 10.4.2 Agent 间的通信与控制"
  source_quote: |
    “取消一个 Agent，它派生的所有子 Agent 随之取消，从根上杜绝无人认领的孤儿 Agent。”
  failure_mode: |
    主 Agent 已取消或某并行分支已成功，子 Agent 仍继续调用工具、持锁和消费 token，甚至晚到结果覆盖新状态。
  mechanism: |
    创建关系没有对应取消树和 deadline，异步任务生命周期脱离所有者；运行时无法回收失效工作。
  warning_signs:
    - "父任务结束后仍有子调用和文件写入"
    - "并行一者成功后其余分支继续运行"
  bound_to:
    - "deadline、取消令牌沿创建树级联"
    - "先优雅终止清理资源，无响应再强制终止"
  tags: [lifecycle, cancellation, orphan-agent, resources]

- id: ce110
  title: "Manager 成为单点能力瓶颈"
  type: "编排失败"
  source_chapter: "第 10 章 10.4.4 管理者模式"
  source_quote: |
    “Manager 成为系统的单点瓶颈。”
  failure_mode: |
    Manager 错误分解任务、选择 Agent 或传递上下文后，所有强执行者都在错误前提上高质量完成无用子任务。
  mechanism: |
    中心节点垄断全局规划和路由，局部执行无法修复上游目标偏差；同时全局上下文随子任务数量快速膨胀。
  warning_signs:
    - "子任务分别通过但整体目标仍失败"
    - "Manager 上下文和协调 token 远超执行工作"
  bound_to:
    - "最强规划能力和验证预算优先分配给 Manager"
    - "分解结果带验收条件并允许子 Agent 反馈纠偏"
  tags: [manager, orchestration, single-point, decomposition]

- id: ce111
  title: "去中心化移交形成循环"
  type: "拓扑失控"
  source_chapter: "第 10 章 10.4.5 去中心化协作"
  source_quote: |
    “预算、访问链和循环检测由运行时保留，不能由任一 Agent 自行删除。”
  failure_mode: |
    Agent A 把任务交给 B，B 又交给 A 或继续递归转交，任务没有进展却不断生成新上下文和费用。
  mechanism: |
    去中心化节点只做局部路由，没有全局 visited set、剩余预算和拓扑终止约束，环路对单个 Agent 不可见。
  warning_signs:
    - "同一 task_id 重复访问相同 Agent"
    - "handoff 数增加但产物版本不变"
  bound_to:
    - "运行时维护不可篡改的访问链和总预算"
    - "检测重复接收者即拒绝并升级"
  tags: [handoff, cycle, decentralized, budget]

- id: ce112
  title: "并行 Agent 直接写同一代码空间"
  type: "并发失败"
  source_chapter: "第 10 章 10.5.1 共享文件系统的并发冲突"
  source_quote: |
    “两个 Agent 同时修改同一个文件，后写入的那个把先写入的修改覆盖掉了。”
  failure_mode: |
    并行修改发生后写覆盖；即使不同文件无文本冲突，也可能因编号、接口或数据模型变化产生跨文件语义矛盾。
  mechanism: |
    共享可变状态没有版本检查和工作副本隔离；文件锁只检测同路径竞争，无法理解跨文件逻辑依赖。
  warning_signs:
    - "多个 Agent 对同一基线并发写入"
    - "合并无冲突但测试、引用或接口失效"
  bound_to:
    - "用版本检查、独立分支或 worktree 隔离写入"
    - "合并点运行跨文件语义验证和完整测试"
  tags: [concurrency, filesystem, worktree, semantic-conflict]

- id: ce113
  title: "错误沿 Agent 链逐层强化"
  type: "级联失败"
  source_chapter: "第 10 章 10.5.2 错误的级联放大"
  source_quote: |
    “Agent 间传递语义，每转述一次都是有损的重新编码。”
  failure_mode: |
    早期 Agent 的错误假设被后续摘要、计划和实现视为已确认事实，经过多次转述后变得更确定且更难追根。
  mechanism: |
    自然语言通信不逐位保真，下游通常继承结论而不重读原始证据；相关模型倾向延续上游叙事。
  warning_signs:
    - "最终结论只能追溯到上游摘要而非原始证据"
    - "每次交接都删去不确定性和反例"
  bound_to:
    - "高风险结论由隔离审核者对原始证据交叉验证"
    - "移交保留来源、置信度和异议"
  tags: [multi-agent, cascade, semantic-loss, provenance]

- id: ce114
  title: "给失控递归开放无限 Agent 预算"
  type: "资源失控"
  source_chapter: "第 10 章 10.4.2；10.5.3"
  source_quote: |
    “失控的 Agent 有时会生成数千个子 agent，浪费大量 token。”
  failure_mode: |
    子 Agent 可继续无界创建后代且并发、token、步骤和费用没有全局上限，错误分解迅速放大为资源事故。
  mechanism: |
    每个局部 Agent 只看到自己的委派收益，不承担系统总成本；分支因子大于一时资源按深度指数增长。
  warning_signs:
    - "活跃 Agent 数或委派深度持续增长"
    - "单任务能耗尽共享 API 配额"
  bound_to:
    - "运行时设置全局并发、深度、token、步骤与费用预算"
    - "子预算从父预算扣减且超限强制终止"
  tags: [multi-agent, recursion, resource-budget, explosion]

- id: ce115
  title: "把思考与理解一并外包"
  type: "人机协作失败"
  source_chapter: "第 10 章 10.5.4 理解债与认知投降"
  source_quote: |
    “循环交付代码越快，工程师对系统实际实现的理解就落后得越远。”
  failure_mode: |
    团队接受大量无法审阅的生成代码和架构，平时缺少独立判断，严重故障时已无人理解系统或承担责任。
  mechanism: |
    自动化提高产出速度却不自动提高人类吸收速度；审查能力长期不用会退化，未偿还的理解债持续复利。
  warning_signs:
    - "关键模块没有人能解释设计取舍和故障边界"
    - "评审只看测试绿灯，不读实现与证据"
  bound_to:
    - "关键设计保留人类所有者、决策记录和可解释验收"
    - "人可以外包执行但不能外包理解和责任"
  tags: [understanding-debt, cognitive-surrender, human-oversight]
