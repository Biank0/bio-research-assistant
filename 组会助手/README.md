# 研究生组会汇报助手 — Multi-Skill 系统

<sub><em>—— For the girl in the lab</em></sub>

## 架构概览

```
grad-seminar-report (编排层/调度器)
  ├── seminar-literature    文献检索与综述
  ├── seminar-experiment    实验数据整理
  ├── seminar-questions     策略性提问生成
  ├── seminar-outline       汇报大纲编排
  └── seminar-ppt           PPT 生成与演讲备注
```

## 设计原则

1. **模块独立** — 每个子 skill 独立可用、独立可测试
2. **编排层调度** — grad-seminar-report 只管流程控制，不干具体活
3. **文件系统传递** — 子 skill 间通过 `{output_dir}/` 下文件交换数据
4. **约束分级** — RFC 2119 关键词（MUST/SHOULD/MAY）
5. **证据分级** — 每条输出标注来源级别（全文/摘要/推测）
6. **冷启动友好** — 编排层首次运行自动安装所有子 skill

## 目录结构

```
组会助手/
├── README.md                  ← 你在这里
├── 需求分析.md                 ← PRD 文档
├── skills/
│   ├── grad-seminar-report/   ← 编排层
│   │   ├── SKILL.md
│   │   └── references/
│   ├── seminar-literature/    ← 文献检索
│   │   ├── SKILL.md
│   │   └── references/
│   ├── seminar-experiment/    ← 实验整理
│   │   ├── SKILL.md
│   │   └── references/
│   ├── seminar-questions/     ← 策略性提问
│   │   ├── SKILL.md
│   │   └── references/
│   ├── seminar-outline/       ← 大纲编排
│   │   ├── SKILL.md
│   │   └── references/
│   └── seminar-ppt/           ← PPT + 演讲备注
│       ├── SKILL.md
│       └── references/
└── scripts/
    └── install.sh             ← 一键安装脚本
```

## 开发计划

按依赖顺序逐个开发：

1. seminar-literature（无依赖，最先开发）
2. seminar-experiment（无依赖，可并行）
3. seminar-questions（依赖 1+2 的输出）
4. seminar-outline（依赖 1+2+3）
5. seminar-ppt（依赖 4）
6. grad-seminar-report（编排层，最后整合）

每个 skill 开发流程：写 SKILL.md → 单独测试 → 通过后注册到 hermes
