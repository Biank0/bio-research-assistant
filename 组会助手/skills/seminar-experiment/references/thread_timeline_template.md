# 实验线索时间轴模板

```markdown
# 实验线索: {thread_name}

**课题**: {project}
**启动日期**: {start_date}
**当前状态**: 活跃 / 暂停 / 完成 / 放弃
**目标**: {一句话描述这条线索要达成什么}

---

## 时间轴

### {date_1} — {experiment_title} {status_emoji}
- 条件: {key_conditions_brief}
- 结果: {one_line_result}
- 决策: {what_was_decided_next}

### {date_2} — {experiment_title} {status_emoji}
- 条件: {key_conditions_brief}
- 结果: {one_line_result}
- 决策: {what_was_decided_next}

⚠️ **阻塞点**: {date} — 连续 {n} 次失败
   可能原因: {hypotheses}
   突破方式: {how_resolved / still_blocked}

🎯 **里程碑**: {date} — {milestone_description}

---

## 依赖关系
- 上游: {what_this_depends_on}
- 下游: {what_depends_on_this}
- 并行: {related_threads}

## 经验规则（从本线索提炼）
- {rule_1}
- {rule_2}

## 当前待办
- [ ] {next_todo_1}
- [ ] {next_todo_2}
```

## 时间轴格式说明

- 每个节点一行核心信息，保持 scannable
- 状态 emoji: 🟢成功 🟡待验证 🔴失败 ⚪进行中
- 阻塞点和里程碑用特殊格式高亮
- 默认只展示最近 2 周，用户说"展开"时显示全部
- 依赖关系帮助理解"为什么要做这个实验"
