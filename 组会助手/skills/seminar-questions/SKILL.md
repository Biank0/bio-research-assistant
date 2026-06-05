---
name: seminar-questions
version: "0.1.0"
description: "Generate strategic questions for seminar Q&A when given literature summary and experiment notes"
triggers:
  - "准备提问"
  - "策略性提问"
  - "组会问题"
input:
  - literature_summary.md (file, MUST)
  - experiment_notes.md (file, SHOULD)
  - presenter_topic (string, MAY) — 其他同学汇报的主题
output:
  - questions.md
---

# seminar-questions — 策略性提问生成

## 职责

生成组会中可用的高质量提问，展示持续投入和学术思考深度。

## 双角度提问策略

### 角度一：实验/方法层面
- 实验设计的对照是否充分？
- 统计方法是否合适？
- 可重复性如何？

### 角度二：文献/前沿层面
- 与最新文献的异同？
- 该领域未解决的核心问题？
- 可能的新方向？

## 流程

### Phase 1: 素材分析 (MUST)

读取输入文件，提取：
- 核心研究问题
- 方法论特征
- 尚未回答的gap

### Phase 2: 提问生成 (MUST)

每次生成 5-8 个问题，分级：
- ⭐⭐⭐ 展示深度思考（推荐优先问）
- ⭐⭐ 有价值的追问
- ⭐ 安全牌（不出错的基础问题）

### Phase 3: 回答预判 (SHOULD)

对每个问题预判：
- 可能的回答方向
- 追问路径（如果对方这样回答，可以继续问...）

## 输出格式

```markdown
## 策略性提问 ({topic})

### ⭐⭐⭐ 高价值问题
1. {问题}
   - 背景: {为什么问这个}
   - 预判回答: {对方可能怎么答}
   - 追问: {可以接着问什么}

### ⭐⭐ 中等价值
...

### ⭐ 安全牌
...
```

## 约束

- MUST 问题基于真实文献/数据，不凭空构造
- MUST 标注问题来源（来自哪篇文献/哪个实验现象）
- SHOULD 兼顾"展示学弟在认真学"和"不冒犯汇报者"
- MUST NOT 生成攻击性或让人难堪的问题
