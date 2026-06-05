---
name: seminar-outline
version: "0.1.0"
description: "Compose a structured seminar presentation outline when given literature, experiment notes, and questions"
triggers:
  - "写大纲"
  - "组会大纲"
  - "汇报结构"
input:
  - literature_summary.md (file, MUST)
  - experiment_notes.md (file, SHOULD)
  - questions.md (file, MAY)
  - time_limit (int, SHOULD, default: 15) — 汇报时长(分钟)
output:
  - outline.md
---

# seminar-outline — 汇报大纲编排

## 职责

将文献综述、实验进展、提问整合为一份逻辑清晰的组会汇报大纲。

## 大纲结构模板

```
1. 开场 (1-2 min)
   - 研究背景一句话回顾
   - 本周工作概述

2. 文献进展 (5-7 min)
   - 关键文献 1-3 篇精讲
   - 与自己课题的关联

3. 实验进展 (3-5 min)
   - 本周做了什么
   - 结果与判断
   - 遇到的问题

4. 下一步计划 (2-3 min)
   - 短期（下周）
   - 中期（本月）

5. 讨论/提问 (2-3 min)
   - 主动抛出 1-2 个思考点
```

## 流程

### Phase 1: 素材汇总 (MUST)

读取所有输入文件，评估内容量。

### Phase 2: 时间分配 (MUST)

根据 time_limit 和内容量动态分配各部分时长。
- 内容多的部分多分时间
- 空的部分（如无实验）直接跳过

### Phase 3: 逻辑串联 (MUST)

确保各部分之间有逻辑衔接：
- 文献 → 启发了什么
- 实验 → 验证了文献中的什么
- 问题 → 接下来要回答什么

### Phase 4: 输出大纲 (MUST)

含每页的核心内容和预估时长。

## 约束

- MUST 控制总时长在 time_limit ± 2min
- MUST 每个 section 有明确的"这一页要传递的信息"
- SHOULD 标注哪些内容可以跳过（时间紧时）
- SHOULD 在大纲中标注"节奏提示"（这里放慢/这里快过）
- MUST NOT 堆砌内容，宁可精选少讲
