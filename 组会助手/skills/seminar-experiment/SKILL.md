---
name: seminar-experiment
version: "0.1.0"
description: "Organize and format experimental progress notes when user provides raw lab data or experiment updates"
triggers:
  - "整理实验"
  - "实验进展"
  - "本周实验"
input:
  - raw_notes (string/file, MUST) — 用户口述或粘贴的实验记录
  - experiment_type (string, SHOULD) — 实验类型（分子克隆/测序/表型观察等）
output:
  - experiment_notes.md
---

# seminar-experiment — 实验数据整理

## 职责

将用户零散的实验记录整理为组会可用的结构化实验笔记。

## 流程

### Phase 1: 信息收集 (MUST)

引导用户提供：
- 本周做了什么实验
- 关键结果/数据（成功or失败）
- 遇到的问题
- 下一步计划

### Phase 2: 结构化整理 (MUST)

将口语化描述转为：
```markdown
## 实验进展 ({date_range})

### 实验 1: {实验名称}
- **目的**: ...
- **方法**: ...
- **结果**: ...
- **判断**: 成功 ✅ / 部分成功 ⚠️ / 失败 ❌
- **下一步**: ...
```

### Phase 3: 可视化建议 (MAY)

如果数据适合图表展示，建议：
- 何种图表类型
- 关键数据点标注

## 约束

- MUST 保留原始数据的准确性，不美化失败结果
- MUST 区分"用户说的"和"AI 推断的"
- SHOULD 用实验领域的规范术语
- MUST NOT 替用户解释实验失败原因（除非被要求）
