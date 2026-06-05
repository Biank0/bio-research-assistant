---
name: seminar-ppt
version: "0.1.0"
description: "Generate PowerPoint slides and speaker notes when given a finalized seminar outline"
triggers:
  - "生成PPT"
  - "做幻灯片"
  - "slides"
input:
  - outline.md (file, MUST)
  - style (string, MAY, default: "学术简洁") — 风格偏好
output:
  - slides.pptx
  - speaker_notes.md
---

# seminar-ppt — PPT 生成与演讲备注

## 职责

将大纲转化为可直接使用的 PPT 文件 + 对应的演讲备注。

## 流程

### Phase 1: 页面规划 (MUST)

根据大纲拆分页面：
- 每个要点 = 1 页
- 目标总页数: time_limit × 1-1.5 页/分钟

### Phase 2: 内容填充 (MUST)

每页包含：
- 标题（简短有力）
- 要点（最多 3-4 条 bullet）
- 图/表占位提示（如需要）

### Phase 3: 演讲备注 (MUST)

为每页生成：
- 要讲的话（口语化，非书面语）
- 预估时长
- 过渡语（到下一页怎么衔接）

### Phase 4: PPT 生成 (MUST)

使用 python-pptx 生成 .pptx 文件：
- 学术风格模板（白底，深色文字）
- 统一字体和字号规范
- 页码标注

## 演讲备注格式

```markdown
## Slide 1: {标题}
**时长**: ~1.5 min
**要说的话**:
"大家好，这周我主要看了几篇关于...的文献，然后在实验上..."

**过渡**: "接下来我先分享一下文献部分"
```

## 约束

- MUST 演讲备注用口语而非书面语
- MUST PPT 每页文字不超过 50 字（不含标题）
- SHOULD 标注哪些页可以快速翻过
- SHOULD 图表页只放图+标题，解释放备注里
- MUST NOT 把大段文字直接搬到 PPT 上
- MAY 提供配色建议但不强制
