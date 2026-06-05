---
name: seminar-literature
version: "0.3.1"
description: search and summarize recent papers when the input includes a research direction, keywords, or a specific paper request and the user needs a structured literature summary for seminar preparation, weekly reading, or research exploration in biology and life sciences.
---

# Seminar Literature — 文献检索与综述

用这个 skill 为组会准备文献部分。根据研究方向检索近期文献，尝试获取全文，输出结构化文献综述。面向生物学/生命科学方向优化。

## 工作流

```
触发 skill
  │
  ▼
[0] 记忆初始化 — 读取/创建 skill 专属 memory（工具可用时）或本地记忆文件
  │  (输出目录、已检索文献列表)
  ▼
[1] 确认参数 — 研究方向、时间范围、关注侧重
  │  + 需要写入文件时确认输出保存路径（只在对话内输出可暂不询问）
  ▼
[2] 去重检查 — 对比 memory 中已检索文献，排除重复
  ▼
[3] 执行检索 — 多源检索，获取候选列表
  ▼
[4] 展示候选 — 让用户确认深入哪几篇
  ▼
[5] 获取全文 — 区分成功与 pending
  ▼
[6] 生成产出 — 精读卡 + 综述总览
  ▼
[7] 输出确认 — 展示内容摘要，询问用户确认后写入 .md 文件
  ▼
[8] 更新记忆 — 将本次检索的文献标题写入 memory 或本地记忆文件
```

## 记忆管理 (Skill Memory)

本 skill 优先使用环境提供的 memory 工具维护一条专属记忆；如果当前环境没有 memory 工具，则在输出目录中维护本地记忆文件 `{output_dir}/.seminar_literature_memory.md`。两种方式使用同一内容格式：

```
[seminar-literature] output_dir: {path}; searched_papers: {title1} | {title2} | ...
```

### 记忆协议

- **工具优先**: 如果当前环境提供 memory 工具，用 `memory(action='add')` / `memory(action='replace')` 创建或更新记忆。
- **本地 fallback**: 如果没有 memory 工具，用 `{output_dir}/.seminar_literature_memory.md` 记录同样字段；如果还没有 output_dir，则只在本轮对话上下文中临时去重，待用户确认保存路径后再落盘。
- **首次写入文件前**: 询问用户产出文件保存在哪个目录，然后创建 memory 或本地记忆文件。
- **只在对话内输出**: 如果用户明确只想先看检索结果/摘要，不需要写文件，可跳过输出目录确认，也不强制创建本地记忆文件。
- **后续运行**: 追加新检索到的文献标题到 `searched_papers`。
- **每次检索前**: 读取 `searched_papers` 字段，排除已检索过的文献；如果记忆不可用，则说明本次无法基于历史记录去重。
- **路径变更**: 如果用户要求更换输出目录，更新 memory 或本地记忆文件中的 `output_dir`。

### 记忆内容

| 字段 | 说明 | 示例 |
|------|------|------|
| output_dir | 产出文件保存路径 | ~/Bian-workspace/bio-research-assistant/产出和思考/文献/ |
| searched_papers | 已检索文献标题列表（\| 分隔） | Bridge RNA structures... \| IS element diversity... |

### 本地记忆文件

当使用本地 fallback 时，创建或更新：

```
{output_dir}/.seminar_literature_memory.md
```

文件内容保持简短，只记录必要字段，不保存全文或长摘要，避免后续读取成本过高。

### 去重规则

- 每次检索结果出来后，对比 `searched_papers` 列表。
- 如果候选文献标题与已检索文献匹配（模糊匹配，忽略大小写），标记为"已检索过"并告知用户。
- 用户可以选择"重新检索"已有文献（比如想看更新版本），但默认跳过。

## 输入处理规则

- 接收研究方向（关键词或一句话描述）、时间范围、关注侧重。
- 如果用户给了具体论文（标题/DOI/链接），直接处理该论文，跳过检索。
- 如果用户只说"帮我查文献"而没给方向，必须先确认再行动。
- 如果用户给了 PDF 文件路径，直接从文件提取内容。

## 参数

| 参数 | 必要性 | 默认值 | 说明 |
|------|--------|--------|------|
| research_direction | MUST | — | 研究方向/关键词 |
| time_range | SHOULD | 近2周 | 检索时间窗口 |
| max_papers | SHOULD | 3-5 | 目标文献数（最多5篇，贵精不贵多） |
| focus | MAY | — | 关注侧重（方法/机制/应用/工具） |
| source_preference | MAY | PubMed优先 | 数据源偏好 |

## 检索策略

数据源优先级（生物方向）：
1. **PubMed / NCBI** — 生物医学首选
2. **bioRxiv / medRxiv** — 预印本（最新但未同行评审）
3. **Google Scholar** — 补充覆盖

检索执行：
- 主关键词 + 限定词组合，至少 2 种检索式交叉
- 优先近期高相关，而非经典老文献
- 如果结果太少，放宽时间或扩展关键词并告知用户
- **去重**: 检索结果与 memory 中 searched_papers 对比，已有的默认排除

## 全文获取

尝试获取全文的优先级：
1. Open Access / PMC 全文
2. bioRxiv/medRxiv 预印本
3. 作者个人主页或实验室网站
4. 仅摘要可用时，标记为 pending

不做的事：
- 不使用 Sci-Hub 或任何非法途径
- 不假装读过未获取的全文

### PDF 保存规则

- 所有能下载到 PDF 的文献，统一保存到 `{output_dir}/检索文献/` 目录下。
- 如果该目录不存在，自动创建。
- 文件命名: `{第一作者姓}_{年份}_{关键词缩写}.pdf`（如 `Durrant_2024_BridgeRNA.pdf`）

## 精读卡规则

- **只对成功获取全文的文献生成精读卡**。
- 仅获取到摘要的文献：只在 overview.md 中以一行摘要形式列出，不生成精读卡。
- 仅知标题的文献：列入 pending.md，不做任何分析。

逻辑判断：
```
if 全文获取成功 (PDF/HTML全文):
    → 生成精读卡 (summaries/paper_xx.md)
    → 保存 PDF 到 检索文献/
elif 仅有摘要:
    → overview 中列一行（标题 + 一句话 + 🟡标记）
    → 不生成精读卡
else:
    → 列入 pending.md
```

## 输出结构

```
{output_dir}/
├── 检索文献/            ← PDF 全文统一存放（自动创建）
│   ├── Durrant_2024_BridgeRNA.pdf
│   └── ...
├── summaries/           ← 精读卡（仅全文文献）
│   ├── paper_01.md
│   └── paper_02.md
├── overview.md          ← 综述总览（含所有文献概要）
└── pending.md           ← 未获取全文的文献列表
```

## 输出确认协议 (MUST)

所有产出默认写入 .md 文件，但写入前 MUST 遵循以下流程：

1. 生成内容后，先在对话中展示**内容摘要**（非全文，而是关键点概述）。
2. 询问用户："内容是否满意？确认后我将写入 {output_dir}/xxx.md"。
3. 用户确认后才执行文件写入。
4. 如果用户要求修改，先修改再重新确认。

不需要确认的情况：
- 用户明确说过"直接写"或"不用问我"时，可跳过确认。

## 证据与表述约束

- 每条判断标注来源级别：
  - 🟢 **全文** — 基于完整论文内容的判断
  - 🟡 **摘要** — 仅基于 abstract 的推断
  - 🔴 **标题** — 仅知标题，判断极度保守
- 基于摘要时，弱化关于方法细节和实验设计的断言。
- 不把论文 claim 直接改写成既定事实。
- 不编造实验结果、数据集细节或开源状态。
- 宁可写"未找到相关文献"也不凭空构造。

## 输出规则

- 默认输出中文，术语保留英文原文。
- 每篇文献的"与课题关联"和"启发"必须具体，不要泛泛写"可以借鉴其思路"。
- 明确写成"可借鉴到哪个实验环节/哪个机制理解/哪个技术路线的选择"。
- 对低相关文献仅列标题+一句话，不展开。
- overview 中展示文献间的对照关系，不要写成逐篇摘要拼接。

## 何时读引用文件

- **始终读取** `references/literature_card_template.md` — 保持单篇输出结构稳定。
- **始终读取** `references/overview_template.md` — 保持综述总览格式一致。
- 在判断文献是否值得精读时，参考 `references/reading_priority.md`。

## 用户交互

- **首次需要写文件时**询问输出目录，存入 memory 或 `{output_dir}/.seminar_literature_memory.md`。后续运行读取记录并确认"还是保存到 {path} 吗？"
- 如果用户明确只要对话内结果，可跳过输出目录确认，待需要写文件时再询问。
- 检索完成后，先展示候选列表（标题+一句话摘要），让用户确认要深入哪几篇。
- 如有与已检索文献重复的，告知用户并默认跳过。
- 如有 pending 文献，明确告知用户需手动获取，并提供获取建议。
- 产出内容生成后，展示摘要并等待确认才写入文件。
- 用户补充全文后，继续完成对应精读卡。
