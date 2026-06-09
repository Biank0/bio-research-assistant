---
name: seminar-experiment
version: "0.2.0"
description: Experiment long-term memory system — record, track, analyze, and retrieve experimental progress across sessions. Core skill handles logging and querying (high-frequency); analysis and review guides loaded on demand from references/.
---

# Seminar Experiment — 实验长期记忆系统

核心工作流：**记录 + 查询**（高频）| 追踪 · 分析 · 回顾（按需加载）

## Overview

解决的问题：实验周期长、变量多、失败频繁，需要跨 session 的结构化记忆。

本 skill 是实验记忆的唯一入口和状态管理者。高频操作（记录、查询）完整定义在此；低频复杂操作（分析、回顾）的详细指南在 references/ 中按需加载。

## Parameters

- **action** (required): `log` | `query` | `track` | `analyze` | `review`
- **experiment_name** (optional): 实验名称/简称
- **project** (optional): 课题线，从上下文推断
- **date** (optional, default: today)
- **tags** (optional): 检索标签

**参数获取约束:**
- You MUST only require action，其余从用户输入推断
- You MUST NOT 在启动前逐一询问参数
- You MUST support 自然语言、结构化条目、语音转录等任何输入格式

## 场景自动配置

| 用户说的话 | action | 补充 |
|------------|--------|------|
| "记一下今天的实验" | log | |
| "上次做XX用的什么条件" | query | |
| "最近XX做到哪了" | track | |
| "为什么总是失败" | analyze | 加载 references/analysis_guide.md |
| "帮我整理本月进展" | review | 加载 references/review_guide.md |
| "组会要汇报实验" | review | output=seminar |

## 文件结构

```
{experiment_dir}/           ← 默认: 产出和思考/实验/
├── experiment_state.yaml   ← 当前状态（唯一数据源，钩子每条消息读它）
├── logs/                   ← 单次实验记录
│   ├── index.md            ← 检索总索引（每次 log 追加一行）
│   ├── assets/             ← 图片/凝胶/原始数据
│   │   └── {date}_{seq}_{name}/
│   └── {date}_{seq}_{name}.md
├── threads/                ← 实验线索时间轴
│   └── {project}_timeline.md
├── analysis/               ← 分析报告
│   └── {date}_{type}.md
├── reviews/                ← 阶段回顾
│   └── {date}_{type}.md
└── rules.md                ← 经验规则库
```

**`logs/index.md` 是检索的唯一入口**，避免随记录增多而漏检。格式：

```markdown
# 实验索引
| 编号 | 日期 | 名称 | 课题 | 状态 | 标签 | 关键参数摘要 | 文件 |
|------|------|------|------|------|------|--------------|------|
| ABC-003 | 2026-06-09 | Western验证 | ABC | 🔴 | western,膜蛋白 | 一抗1:1000, 4℃过夜 | logs/2026-06-09_003_western.md |
```

- 每次 log **MUST** 追加一行到 index.md
- query / 关联历史 / 检测连续失败：**先读 index.md 定位**，再按需打开具体记录文件
- 实验编号 = 该课题在 index 中现有最大序号 + 1（无需单独维护计数器）

---

## Action: log（记录）

将用户描述转化为结构化实验记录。使用频率最高，必须快速、低摩擦。

**流程:**
1. 读 `logs/index.md` 恢复上下文，确定本次实验编号（该课题最大序号+1）
2. 从自然语言提取结构化字段
3. 按编号关联同课题历史记录，如有则自动生成条件对比
4. 展示结构化卡片 → 用户确认 → 写入记录文件 **并追加一行到 index.md**

**Constraints:**
- You MUST 使用 `references/experiment_log_template.md` 的结构
- You MUST 从用户描述中提取：目的、体系/材料、关键条件（数值+单位）、结果、异常、下一步
- You MUST 缺失字段标记 "待补充"，不猜测
- You MUST 数值参数包含单位（nM/μM/mM, ℃, min/h）
- You MUST 自动关联历史同类实验，高亮条件差异
- You MUST 检测"连续失败"（≥2次），主动提示模式
- You MUST NOT 追问超过 1 次——接受不完整记录
- You MUST NOT 修改已有记录的数值（只追加补充说明）
- You SHOULD 对失败实验简短追问可能原因
- You SHOULD 检测"重复实验"，自动复制上次条件并标注差异
- You SHOULD 图片/凝胶/原始数据放入 `logs/assets/{date}_{seq}_{name}/`，记录中用相对路径引用

**状态标记:** 🟢 成功 / 🟡 待验证 / 🔴 失败 / ⚪ 进行中

**产出:** `{experiment_dir}/logs/{date}_{seq}_{experiment_short_name}.md` + 追加 `logs/index.md` 一行

---

## Action: query（查询）

快速检索历史实验信息，无流程，直接返回。

**支持的查询类型:**
- 条件查询："上次做XX用的什么浓度"
- 结果查询："XX实验结果怎么样"
- 时间查询："上个月做了哪些实验"
- 状态查询："哪些实验在进行中"
- 标签查询："所有Western相关的实验"

**Constraints:**
- You MUST 先读 `logs/index.md` 按编号/课题/标签/日期定位，再打开具体记录文件取细节
- You MUST 返回精确信息 + 来源文件路径
- You MUST NOT 找不到时编造答案——回复"未找到相关记录"
- You SHOULD 返回最相关的 1-3 条，非全部匹配

---

## Action: track（追踪）

维护实验线索时间轴。参考 `references/thread_timeline_template.md`。

**核心规则:**
- 按课题线组织，展示日期 + 实验名 + 状态 + 一句话结果
- 标记阻塞点（连续失败≥2次）和里程碑
- 默认展示最近 2 周，用户可扩展
- 检测 >2周未更新的线索，提醒用户
- 展示线索间依赖关系

**产出:** `{experiment_dir}/threads/{project}_timeline.md`（持续更新）

---

## Action: analyze（分析）

跨实验对比，发现模式。**进入此模式前 MUST 加载 `references/analysis_guide.md`。**

**分析模式:**
- `failure_pattern`: 失败共性分析 → 参考 `references/failure_analysis_template.md`
- `condition_compare`: 条件对比
- `technique_summary`: 技术经验总结
- `progress_assessment`: 课题进展评估

**核心防幻觉规则（即使不加载 guide 也必须遵守）:**
- 结论 MUST 标注支撑证据（哪次实验、什么数据）
- 相关性 MUST NOT 直接断言为因果
- 数据不足时 MUST 使用"可能""需要验证"
- 经验规则 MUST 用条件句（"当X时，Y更可能"）

**产出:** `{experiment_dir}/analysis/{date}_{type}.md`

---

## Action: review（回顾）

生成阶段性总结。**进入此模式前 MUST 加载 `references/review_guide.md`。**

**回顾类型:**
- `seminar`: 组会汇报（与 seminar-literature Phase 3 兼容）
- `mentor`: 导师讨论
- `self`: 自我复盘

**入口规则:**
- 生成前 MUST 确认时间范围和回顾目的（一次性问）
- 内容 MUST 包含：进展概览、问题与阻塞、下一步计划
- seminar 类型 MUST 包含策略性提问（实验问题 + 方向问题）
- MUST NOT 美化失败或夸大进展

**产出:** `{experiment_dir}/reviews/{date}_{type}.md`

---

## 状态协议（experiment_state.yaml）

当前状态存于单一文件 **`{experiment_dir}/experiment_state.yaml`**——"在做哪个实验、进行到哪一步"的唯一数据源。一个**项目级 UserPromptSubmit 钩子**会在每条消息前读取它，注入一行「当前实验」横幅，使上下文始终对齐（即使没触发本 skill）。

**字段:**
```yaml
active_project:    ABC                  # 课题线；空/null = 当前无活跃实验
active_experiment: ABC-003              # 实验编号（与 logs/index.md 一致）
experiment_name:   Western验证          # 一句话名称
stage:             Western 待验证        # 进行到哪一步
last_log:          2026-06-09
active_threads:    线索1 | 线索2
experiment_dir:    /abs/path/产出和思考/实验
updated_at:        2026-06-09T10:13
```

**写入时机（skill 负责写，钩子只读不写）:**
- 首次运行: 确认目录（默认 `产出和思考/实验/`），创建文件，active_* 留空
- 每次 log 后: 更新 active_project / active_experiment / experiment_name / stage / last_log / updated_at
- track / analyze / review 后: 更新 stage、active_threads
- 用户切换实验: 改写 active_*（旧实验状态已落盘在 logs/，不丢）

**读取:**
- 钩子每条消息自动注入横幅，skill 无需为了横幅主动读
- 但每个 action 启动时 skill 仍 MUST 自读一次 experiment_state.yaml + logs/index.md（保证钩子未安装时也能工作）

**不入状态文件:** 实验编号、规则数等派生信息从 logs/index.md、rules.md 现算。

**横幅格式（钩子产出，仅说明）:** `[当前实验] {active_experiment} {experiment_name} · 进行到: {stage} (last_log {date})`；active_experiment 为空时钩子不输出。

**跨 skill 协作:**
- 与 `seminar-literature` 共享课题方向
- review(seminar) 可与 seminar-literature Phase 3 合并
- 文献中的方法启发可作为新实验线索起点

## 数据完整性

- MUST NOT 修改已有记录数值（只追加注释）
- MUST NOT 删除任何记录（可标记 archived）
- MUST NOT 推测与事实混写在同一字段
- 每条记录包含创建时间戳
- 修改通过"补充说明"实现，保留原始

## 何时读引用文件

| 场景 | 加载文件 |
|------|----------|
| 任何 log 操作 | references/experiment_log_template.md |
| track 操作 | references/thread_timeline_template.md |
| analyze 操作 | references/analysis_guide.md + 对应 template |
| review 操作 | references/review_guide.md + review_template.md |
| 涉及经验规则 | references/experience_rules_template.md |

## Troubleshooting

| 问题 | 处理 |
|------|------|
| 描述过于简略 | 追问一次关键数值，不超过1次 |
| 历史记录找不到 | 明确告知，建议检索关键词 |
| 分析数据不足 | 标注置信度低，建议补充哪些实验 |
| 多课题交叉 | 同一实验在多线索中引用，保持边界清晰 |

## 渐进式参数暴露

首次使用后附提示：
> 「💡 你可以随时说'记一下今天的实验'、'上次用的什么条件'、'为什么总失败'、'整理本月进展'。我会记住所有实验细节。」
