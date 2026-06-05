---
name: grad-seminar-report
version: "0.2.0"
description: "Orchestrate a full seminar report pipeline when user says '准备组会' or '帮我准备汇报'"
triggers:
  - "准备组会"
  - "帮我准备汇报"
  - "组会汇报"
dependencies:
  - seminar-literature
  - seminar-experiment
  - seminar-questions
  - seminar-outline
  - seminar-ppt
---

# grad-seminar-report — 编排层

## 角色

调度器。自己不做具体工作，只负责：
1. 确认用户输入（研究方向、本周进展、时间约束）
2. 按序调用子 skill
3. 在子 skill 间传递中间产物
4. 汇总最终交付物

## 流程

```
用户输入
  │
  ▼
[1] skill_view("seminar-literature") → 文献检索
  │  输出: {output_dir}/literature_summary.md
  ▼
[2] skill_view("seminar-experiment") → 实验整理
  │  输出: {output_dir}/experiment_notes.md
  ▼
[3] skill_view("seminar-questions") → 策略性提问
  │  输入: literature_summary.md + experiment_notes.md
  │  输出: {output_dir}/questions.md
  ▼
[4] skill_view("seminar-outline") → 大纲编排
  │  输入: 上述所有产物
  │  输出: {output_dir}/outline.md
  ▼
[5] skill_view("seminar-ppt") → PPT 生成
  │  输入: outline.md
  │  输出: {output_dir}/slides.pptx + speaker_notes.md
  ▼
交付给用户
```

## 冷启动

首次运行时检查子 skill 是否已安装：

```
REQUIRED_SKILLS=(seminar-literature seminar-experiment seminar-questions seminar-outline seminar-ppt)

对于每个 skill:
  如果 skill_view 失败 → 提示用户运行 install.sh
```

## 用户交互协议

### 启动阶段 (MUST)

向用户确认：
1. 本次组会的研究方向/主题
2. 本周实验进展（如有）
3. 时间约束（组会日期）
4. 模式选择：完整流程 / 仅文献 / 仅大纲

### 中间确认点 (SHOULD)

- 文献检索完成后，展示摘要让用户确认方向
- 大纲生成后，让用户调整结构再生成 PPT

## 输出目录规范

```
{project_root}/产出和思考/组会_{YYYY-MM-DD}/
├── literature_summary.md
├── experiment_notes.md
├── questions.md
├── outline.md
├── slides.pptx
└── speaker_notes.md
```

## 红线 (MUST NOT)

- MUST NOT 跳过用户确认直接执行全流程
- MUST NOT 在子 skill 失败时静默跳过
- MUST NOT 捏造文献或实验数据
