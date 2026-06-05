---
name: seminar-literature
version: "1.0.0"
description: Three-phase literature workflow for seminar preparation — search papers by direction, produce structured summaries, and generate a seminar report after user confirmation. Optimized for biology and life sciences.
---

# Seminar Literature — 组会文献助手

三阶段文献工作流：**检索 → 总结 → 报告**。面向生物学/生命科学方向组会准备优化。

## Overview

本 skill 在用户给出研究方向后，分三个阶段渐进完成组会文献准备：

1. **Phase 1 — 检索**: 根据方向执行多源文献检索，展示候选列表
2. **Phase 2 — 总结**: 对用户选定的文献生成精读卡和综述总览
3. **Phase 3 — 报告**: 向用户询问组会侧重后，生成一份可直接用于组会汇报的结构化报告

每个阶段结束后 MUST 停下，等用户确认后才进入下一阶段。

## Parameters

- **research_direction** (required): 研究方向、关键词、或一句话描述
- **time_range** (optional, default: "近2周"): 检索时间窗口
- **max_papers** (optional, default: 5): 目标检索文献数（贵精不贵多）
- **focus** (optional): 关注侧重（方法/机制/应用/工具），从用户输入推断
- **source_preference** (optional, default: "PubMed优先"): 数据源偏好

**参数获取约束:**
- You MUST only require research_direction，其余参数从用户输入推断或使用默认值
- You MUST NOT 在启动前逐一询问参数
- You MUST support 多种输入：关键词、一句话描述、具体论文标题/DOI/链接、PDF 路径
- You MAY 在用户输入中推断 focus（如"Bridge RNA 结构"→ focus=机制）

## 场景自动配置

| 用户说的话 | 推断配置 |
|------------|----------|
| "帮我准备组会文献" | 近 1-2 周，3 篇精读，侧重课题直接相关 |
| "最近 XX 方向有什么新进展" | 近 1 月，5 篇概览，侧重广度 |
| "帮我看看这篇论文" | 跳过 Phase 1，直接进入 Phase 2 处理指定论文 |
| "XX 方向的经典文献" | 不限时间，侧重高引 |

## Steps

### Phase 1: 检索 (Search)

根据研究方向执行文献检索，输出候选列表供用户选择。

**Constraints:**
- You MUST 读取 skill memory 获取已检索文献列表，执行去重
- You MUST 使用至少 2 种检索式交叉检索（主关键词 + 限定词组合）
- You MUST 按以下优先级选择数据源：
  1. PubMed / NCBI（生物医学首选）
  2. bioRxiv / medRxiv（预印本，最新）
  3. Google Scholar（补充覆盖）
- You MUST 展示候选列表，每篇包含：标题、期刊/预印本、年份、一句话摘要、⭐高相关标记
- You MUST 标记与已检索文献重复的条目
- You MUST 在候选列表展示后停下，等用户选择要深入哪几篇
- You MUST NOT 在用户选择前进入 Phase 2
- You SHOULD 如果结果太少，放宽时间或扩展关键词并告知用户
- You MAY 建议用户追加关键词以获得更好结果

**Phase 1 产出:**
- 候选文献列表（展示在对话中，不写文件）

**Phase 1 → Phase 2 Checkpoint:**
- 用户确认选择的文献后，进入 Phase 2

---

### Phase 2: 总结 (Summary)

对用户选定的文献获取全文/摘要，生成精读卡和综述总览。

**Constraints:**
- You MUST 按以下优先级尝试获取全文：
  1. Open Access / PMC 全文
  2. bioRxiv/medRxiv 预印本 PDF
  3. 作者个人主页或实验室网站
  4. 仅摘要可用时，标记为 pending
- You MUST NOT 使用 Sci-Hub 或任何非法途径
- You MUST NOT 假装读过未获取的全文
- You MUST 根据获取级别分级处理：
  - 全文 → 完整精读卡（参考 `references/literature_card_template.md`）
  - 仅摘要 → 简版摘要卡（标题、来源、摘要翻译、与课题关联、🟡标记）
  - 仅标题 → 列入 pending，不做分析
- You MUST 在每篇产出中标注证据级别：🟢全文 / 🟡摘要 / 🔴仅标题
- You MUST 生成综述总览（参考 `references/overview_template.md`），组织文献间的对照关系
- You MUST NOT 把综述写成逐篇摘要拼接
- You MUST 所有产出生成完毕后，一次性展示内容摘要（每篇一行关键点）
- You MUST 一次询问用户确认后批量写入文件
- You SHOULD 将可下载的 PDF 保存到 `{output_dir}/检索文献/`
- You SHOULD 精读卡末尾包含"发散思考"（2个延伸问题）

**证据与表述约束:**
- You MUST NOT 把论文 claim 直接改写成既定事实
- You MUST NOT 编造实验结果、数据集细节或开源状态
- You MUST 基于摘要时，弱化关于方法细节和实验设计的断言
- You MUST 宁可写"未找到相关文献"也不凭空构造

**Phase 2 产出:**
```
{output_dir}/
├── 检索文献/           ← PDF 全文存放
├── summaries/          ← 精读卡 + 摘要卡
│   ├── paper_01.md
│   └── abstract_01.md
├── overview.md         ← 综述总览
└── pending.md          ← 未获取全文的文献列表
```

**Phase 2 → Phase 3 Checkpoint:**
- 文件写入完毕后，询问用户：「文献总结已完成。需要我帮你生成组会汇报材料吗？如果需要，请告诉我：1) 本次组会的侧重点或主题；2) 汇报时长（5分钟/10分钟/15分钟）；3) 需要讨论的问题方向」
- You MUST 等用户回应后才进入 Phase 3
- You MUST NOT 自动进入 Phase 3

---

### Phase 3: 组会报告 (Seminar Report)

根据用户的组会需求，基于 Phase 2 产出生成可直接汇报的结构化报告。

**Constraints:**
- You MUST 在生成报告前，向用户收集以下信息（一次性询问）：
  - 组会侧重点/主题（如"文献进展汇报"还是"方法对比"）
  - 汇报时长（决定详略程度）
  - 需要重点讨论的问题方向
  - 是否需要策略性提问（给导师/同门的问题）
- You MUST 报告结构包含：
  - **背景引入**（1-2句，为什么选这些文献）
  - **文献核心发现**（按逻辑关系组织，非逐篇陈述）
  - **方法/技术亮点**（如适用）
  - **与本课题的关联**（具体到实验环节）
  - **待讨论问题**（2-3个，区分"实验问题"和"前沿思考"）
  - **下一步计划**（基于本次文献启发的后续动作）
- You MUST 策略性提问包含两个角度：
  1. 实验/技术问题（关于可行性、对照设计等）
  2. 前沿/方向问题（关于研究趋势、新的可能性）
- You MUST 根据汇报时长调整详略：
  - 5分钟：只保留核心发现 + 关联 + 1个讨论问题
  - 10分钟：完整结构
  - 15分钟：增加方法细节对比和延伸讨论
- You MUST 生成完毕后展示报告全文，用户确认后写入文件
- You SHOULD 输出默认中文，术语保留英文原文
- You MAY 同时生成 PPT 提纲要点（bullet points 形式）

**Phase 3 产出:**
```
{output_dir}/
└── seminar_report.md   ← 组会汇报材料
```

## 记忆管理 (Skill Memory)

本 skill 使用 memory 工具维护一条专属记忆：

```
[seminar-literature] output_dir: {path}; searched_papers: {title1} | {title2} | ...
```

**记忆协议:**
- 首次运行: 静默使用默认输出目录（`产出和思考/文献/`），用 `memory(action='add')` 创建
- 后续运行: 用 `memory(action='replace')` 追加新检索文献标题
- 每次检索前: 读取 searched_papers 字段执行去重
- 路径变更: 只在用户主动要求时更换 output_dir

**去重规则:**
- 候选文献标题与已检索文献模糊匹配（忽略大小写），标记为"已检索过"
- 用户可选择重新检索已有文献，但默认跳过

## 输出规则

- 默认输出中文，术语保留英文原文
- 每篇文献的"与课题关联"和"启发"MUST 具体（到哪个实验环节/哪个机制）
- overview 中 MUST 展示文献间的对照关系
- 对低相关文献仅列标题 + 一句话，不展开
- 基于摘要的判断 MUST 使用弱化表述

## 何时读引用文件

- **始终读取** `references/literature_card_template.md` — 精读卡结构
- **始终读取** `references/overview_template.md` — 综述总览格式
- 判断阅读优先级时参考 `references/reading_priority.md`


## 渐进式参数暴露

检索完成后，在结果末尾附一行提示：
> 「💡 本次默认查了近2周、侧重XX方向。如需调整，下次可以说'查近一个月的/侧重方法的'」

## Troubleshooting

### 检索结果太少
- You SHOULD 放宽时间范围（近2周 → 近1月 → 近3月）
- You SHOULD 扩展同义词或上位词检索
- You MAY 切换数据源（PubMed → Google Scholar）
- You MUST 告知用户当前结果不足，并建议调整方向

### 全文获取失败
- You MUST 基于已有信息（摘要/标题）给出降级输出
- You SHOULD 提供获取建议（如"该文献可通过学校图书馆获取"）
- You MUST NOT 因获取失败而跳过该文献——至少产出简版摘要卡

### 用户输入不明确
- 如果用户只说"帮我查文献"而没给方向，MUST 先确认方向再行动
- 如果方向太宽泛（如"生物学"），SHOULD 建议缩窄并给出方向选项

### Phase 切换卡住
- 如果用户在 Phase 2 后没有回应是否进入 Phase 3，不要催促
- 用户可以在任何时候说"直接帮我写报告"跳入 Phase 3
- 用户可以在任何时候说"再查几篇"回到 Phase 1

## Examples

### Example: 标准三阶段流程

**输入:** "帮我查一下最近 CRISPR 递送系统方面的进展"

**Phase 1 输出:**
```
🔍 检索方向: CRISPR delivery systems
📅 时间范围: 近2周 | 🎯 侧重: 方法/技术

候选文献 (共5篇):
1. ⭐ "Lipid nanoparticle-mediated..." — Nature Biotech, 2026 — LNP递送效率提升3倍
2. ⭐ "AAV-free CRISPR delivery..." — Cell, 2026 — 非病毒载体新策略
3. "Exosome-based CRISPR..." — ACS Nano, 2026 — 外泌体递送概念验证
4. "In vivo base editing..." — Science, 2026 — 体内碱基编辑递送优化
5. "Targeted delivery review..." — Nat Rev Drug Discov, 2026 — 综述

请选择要深入的文献（编号，如"1,2,4"）:
```

**Phase 2 → Phase 3 过渡:**
```
📄 文献总结已完成（3篇精读卡 + 1篇摘要卡 + 综述总览）。
文件已保存到 ~/产出和思考/文献/

需要我帮你生成组会汇报材料吗？如果需要，请告诉我：
1) 本次组会的侧重点或主题
2) 汇报时长（5/10/15分钟）
3) 需要讨论的问题方向
```
