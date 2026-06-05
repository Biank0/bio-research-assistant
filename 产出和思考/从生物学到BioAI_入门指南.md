# 从生物学到 BioAI：生物专业同学的 AI 入门指南

> 训练家小边 × 沙奈朵
> 创建时间：2026-06-02
> 面向读者：有分子生物学/生物化学/遗传学背景，想了解并使用 AI 工具辅助研究的生物专业学生

---

## 一、生物人为什么要学 AI？

你已经有了 AI 研究者梦寐以求的东西：**对数据的生物学直觉**。

AI 模型不理解蛋白质为什么折叠、不知道突变为什么致病——它只是在序列里找模式。
而你知道 "这个位点是催化残基"、"这个突变破坏了氢键"、"这个结构域是二聚体界面"。

**AI 提供算力，你提供洞察。** 两者结合才是 BioAI 的真正力量。

### 你已经会的 vs 你需要学的

```
你已经会的（生物知识）              你需要补的（AI/计算知识）
─────────────────────────────────────────────────────────────
蛋白质结构与功能                    Python 编程基础
序列比对、进化分析                  机器学习基本概念
实验设计与数据解读                  深度学习 / 神经网络原理
分子克隆、定向进化                  Transformer 架构（直觉就行）
文献阅读与批判性思维                命令行 / Linux 基本操作
                                   GPU 服务器使用 / Google Colab
```

### 好消息
- 你 **不需要** 从头推导反向传播公式
- 你 **不需要** 自己训练大模型（别人训好了，你用就行）
- 你 **需要** 理解模型在做什么、输出意味着什么、什么时候该信什么时候不该信
- 你最大的优势是：**你能设计实验来验证 AI 的预测**

---

## 二、核心概念速查（用生物语言解释 AI）

### AI 基本术语 → 生物学类比

| AI 术语 | 生物学类比 | 通俗解释 |
|---------|-----------|---------|
| 模型 (Model) | 就像一个经验丰富的研究员 | 从大量数据中学到了"规律"，能对新数据做判断 |
| 训练 (Training) | 读了 2.5 亿条蛋白质序列 | 让模型反复看数据，不断调整参数直到表现好 |
| 参数 (Parameters) | 研究员大脑中的突触连接 | 模型内部可调节的数值，ESM-2 有 150 亿个 |
| 预训练 (Pretraining) | 本科+硕士的通识教育 | 先在海量通用数据上学基础能力 |
| 微调 (Fine-tuning) | 博士阶段专攻某个课题 | 在少量特定数据上继续训练，让模型专精 |
| 零样本 (Zero-shot) | 学了一辈子蛋白质的专家，看一眼新蛋白就能猜功能 | 不需要任何特定标注数据就能做预测 |
| Embedding | 蛋白质的"指纹" | 把序列压缩成一组数字，相似蛋白的数字也相似 |
| Attention | 远距离残基相互作用 | 模型学会了"这个残基和那个残基有关系"，类似接触图 |
| 掩码语言模型 (MLM) | 完形填空 | 盖住一个氨基酸让模型猜，猜对说明它理解了上下文 |
| 扩散模型 (Diffusion) | 从随机噪声中"结晶"出结构 | 先加噪声再学怎么去噪，最终能从零生成新结构 |
| Loss / 损失函数 | 预测与实验结果的偏差 | 模型训练的目标就是让这个偏差越来越小 |
| 过拟合 (Overfitting) | 死记硬背但不会举一反三 | 模型在训练数据上表现好，但遇到新数据就不行 |

### 蛋白质 AI 工具一览（你最可能用到的）

```
┌─────────────────────────────────────────────────────────┐
│                    你想做什么？                           │
├────────────────────┬────────────────────────────────────┤
│ 预测蛋白质结构      │ AlphaFold2/3  ← 最常用             │
│                    │ ESMFold       ← 更快，单序列即可    │
├────────────────────┼────────────────────────────────────┤
│ 分析突变影响        │ ESM-1v zero-shot ← 不需要训练      │
│                    │ EVE            ← 基于进化模型       │
│                    │ AlphaMissense  ← 预测致病性         │
├────────────────────┼────────────────────────────────────┤
│ 设计新蛋白质        │ ProteinMPNN   ← 给骨架设计序列     │
│                    │ RFdiffusion   ← 从头生成新骨架      │
│                    │ ESM3 / ProGen ← 语言模型直接生成    │
├────────────────────┼────────────────────────────────────┤
│ 预测 RNA 结构       │ RhoFold+      ← 单序列预测 3D     │
│                    │ RNA-FM        ← RNA 表示学习        │
├────────────────────┼────────────────────────────────────┤
│ 指导定向进化        │ PLM + 少量实验数据 → 预测下一轮突变  │
│                    │ ProteinGym    ← 评测模型好不好用     │
├────────────────────┼────────────────────────────────────┤
│ 设计 sgRNA          │ DeepCRISPR / TIGER ← 预测效率      │
├────────────────────┼────────────────────────────────────┤
│ 搜索同源序列        │ BLAST / HMMer ← 你已经会的！       │
│ + AI 增强           │ ESM embedding 聚类 ← 发现远同源    │
└────────────────────┴────────────────────────────────────┘
```

---

## 三、学习路线（从零到能用 AI 做研究）

### 阶段零：编程基础（1-2 周，如果已有基础可跳过）

**目标：** 能写简单 Python 脚本，能在命令行运行程序

| 资源 | 说明 |
|------|------|
| [Python for Biologists](https://pythonforbiologists.com/) | 专门为生物人写的 Python 教程 |
| [Rosalind](https://rosalind.info/) | 用生物信息学题目练 Python（序列分析、比对等） |
| Google Colab | 免费 GPU，浏览器里写代码，不用配环境 |

**检验标准：** 能写脚本读取 FASTA 文件、做简单统计、画图


### 阶段一：理解 AI 在生物学中做什么（2 周）

**目标：** 知道主要工具是什么、能做什么、不能做什么

推荐阅读：

| 编号 | 论文 | 为什么读 |
|------|------|---------|
| **入门1** | Yang, Wu & Arnold 2019, "ML-guided directed evolution for protein engineering", *Nat Methods* | Frances Arnold（诺奖得主）组的综述，从定向进化视角讲 ML，生物人最容易接受 |
| **入门2** | Kouba et al. 2023, "Opportunities and Challenges for ML-Assisted Enzyme Engineering", *ACS Catalysis* | 酶工程 + ML 实操指南，大量具体例子 |
| **入门3** | Koh et al. 2025, "AI-driven protein design", *Nat Rev Bioeng* | 最新全景综述，从结构预测到生成模型的完整路线图 |

动手练习：
- 在 AlphaFold DB 上查你研究的蛋白质结构
- 在 ESM Atlas 上搜索同源蛋白
- 用 Google Colab 跑一次 ESMFold（有现成 notebook）


### 阶段二：学会使用蛋白质语言模型（2-3 周）

**目标：** 能用 ESM-2 做 embedding、预测突变效应

推荐阅读：

| 编号 | 论文 | 为什么读 |
|------|------|---------|
| **PLM1** | Rives et al. 2021, "Biological structure and function emerge from scaling unsupervised learning to 250M protein sequences" (ESM-1b), *PNAS* | 蛋白质语言模型的开创性工作，attention 图 ≈ 残基接触图，直觉上很好理解 |
| **PLM2** | Lin et al. 2023, "Evolutionary-scale prediction of atomic-level protein structure with a language model" (ESM-2), *Science* | 当前最强，理解 scaling law 在蛋白质上同样成立 |
| **PLM3** | Meier et al. 2021, "Language models enable zero-shot prediction of the effects of mutations on protein function", *NeurIPS* | 零样本突变效应预测——不用训练就能用 |

动手练习：
- 用 ESM-2 提取你研究蛋白质的 embedding
- 用 ESM-1v 预测你关心的突变位点的效应
- 把 embedding 做 PCA/t-SNE 可视化，看同家族蛋白是否聚在一起


### 阶段三：理解结构预测与蛋白质设计（2-3 周）

**目标：** 理解 AlphaFold 的原理和局限，了解 AI 设计蛋白的范式

推荐阅读：

| 编号 | 论文 | 为什么读 |
|------|------|---------|
| **结构1** | Jumper et al. 2021, "Highly accurate protein structure prediction with AlphaFold" (AF2), *Nature* | 必读里程碑，重点看 Method 概览和 pLDDT 置信度的含义 |
| **结构2** | Abramson et al. 2024, "AlphaFold 3", *Nature* | 扩展到蛋白质-核酸-小分子复合物，与你的蛋白-RNA 研究直接相关 |
| **设计1** | Dauparas et al. 2022, "ProteinMPNN", *Science* | 反向折叠：给定骨架结构 → 设计匹配的序列 |
| **设计2** | Watson et al. 2023, "RFdiffusion", *Nature* | 从零生成蛋白质骨架，AI 蛋白质设计的最新范式 |

动手练习：
- 在 AlphaFold Server (alphafoldserver.com) 上预测一个蛋白-RNA 复合物
- 读 pLDDT 和 PAE 图，判断预测可不可信
- 尝试用 ProteinMPNN Colab notebook 为一个骨架设计序列


### 阶段四：连接到你的具体研究（持续）

**目标：** 把 AI 工具整合到你的研究工作流中

推荐阅读：

| 编号 | 论文 | 为什么读 |
|------|------|---------|
| **应用1** | Biswas et al. 2021, "Low-N protein engineering with data-efficient deep learning", *Nat Methods* | 用少量实验数据（Low-N）+ 预训练模型做蛋白质工程，最实用 |
| **应用2** | Hie et al. 2024, "Efficient evolution of human antibodies from general PLM", *Nat Biotechnol* | 通用模型直接指导实验进化，无需专门训练 |
| **应用3** | Frazer et al. 2021, "Disease variant prediction with deep generative models" (EVE), *Nature* | 深度生成模型预测变异致病性，理解进化约束 |
| **应用4** | Notin et al. 2024, "ProteinGym", *NeurIPS* | 蛋白质 AI 的标准评测：217 个深度突变扫描数据集 |

---

## 四、按研究方向的专题文献

### 如果你做蛋白质工程 / 酶工程

| 编号 | 论文 | 年份 | 期刊 | 一句话 |
|------|------|------|------|-------|
| E1 | Yang, Wu & Arnold, "ML-guided directed evolution" | 2019 | Nat Methods | 奠基综述 |
| E2 | Biswas et al., "Low-N protein engineering" | 2021 | Nat Methods | 少数据高效工程 |
| E3 | Hie et al., "Efficient evolution of antibodies from PLM" | 2024 | Nat Biotechnol | PLM 指导进化 |
| E4 | "Rapid directed evolution guided by PLM and epistasis" | 2025 | Science | 多位点优化 |
| E5 | Yu et al., "Integrating PLM and automatic biofoundry" | 2025 | Nat Commun | 自动化 DBTL 闭环 |
| E6 | MODIFY: "ML-guided co-optimization of fitness and diversity" | 2024 | Nat Commun | 组合文库设计 |

### 如果你做结构生物学

| 编号 | 论文 | 年份 | 期刊 | 一句话 |
|------|------|------|------|-------|
| S1 | Jumper et al., AlphaFold2 | 2021 | Nature | 结构预测里程碑 |
| S2 | Baek et al., RoseTTAFold | 2021 | Science | 三轨架构 |
| S3 | Abramson et al., AlphaFold3 | 2024 | Nature | 蛋白-核酸-小分子复合物 |
| S4 | Lin et al., ESM-2/ESMFold | 2023 | Science | 单序列快速预测 |

### 如果你做 RNA 生物学

| 编号 | 论文 | 年份 | 期刊 | 一句话 |
|------|------|------|------|-------|
| RNA1 | Townshend et al., ARES | 2021 | Science | 几何深度学习评分 RNA 3D 结构 |
| RNA2 | Shen et al., RhoFold+ | 2024 | Nat Methods | RNA 语言模型 + 3D 结构预测 |
| RNA3 | Chen et al., RNA-FM | 2022 | arXiv | 2300 万 ncRNA 预训练基础模型 |
| RNA4 | "Deep learning for RNA structure prediction" (综述) | 2025 | Curr Opin Struct Biol | 方法全景 |

### 如果你做基因编辑

| 编号 | 论文 | 年份 | 期刊 | 一句话 |
|------|------|------|------|-------|
| G1 | Chuai et al., DeepCRISPR | 2018 | Genome Biol | sgRNA 效率+脱靶预测 |
| G2 | Wessels et al., TIGER | 2023 | Nat Biotechnol | Cas13d gRNA 活性预测 |
| G3 | Marquart et al., BE-DICT | 2021 | Nat Commun | 碱基编辑结果预测 |
| G4 | Profluent, OpenCRISPR | 2024 | — | AI 从头生成功能性 Cas9 |

### 如果你做基因组学 / 进化分析

| 编号 | 论文 | 年份 | 期刊 | 一句话 |
|------|------|------|------|-------|
| GE1 | Nguyen et al., Evo | 2024 | Science | 7B DNA 基础模型，131k 上下文 |
| GE2 | Hayes et al., ESM3 | 2025 | Science | 多模态蛋白质生成，模拟进化 |
| GE3 | Madani et al., ProGen | 2023 | Nat Biotechnol | 条件生成功能性蛋白质 |

---

## 五、不需要编程也能用的 AI 工具

先用起来，再慢慢学编程！

| 工具 | 网址 | 用途 | 门槛 |
|------|------|------|------|
| **AlphaFold Server** | alphafoldserver.com | 预测蛋白质/复合物结构 | 粘贴序列即可 |
| **AlphaFold DB** | alphafold.ebi.ac.uk | 查询已预测结构 | 搜索 UniProt ID |
| **ESM Atlas** | esmatlas.com | 浏览 7 亿蛋白质的预测结构 | 搜索即可 |
| **ESMFold** | esmatlas.com/resources?action=fold | 快速折叠单条序列 | 粘贴序列 |
| **ProteinMPNN** | Colab notebook | 给骨架设计序列 | 上传 PDB 文件 |
| **ChimeraX** | cgl.ucsf.edu/chimerax | 可视化 AlphaFold 结果 | 图形界面 |
| **ColabFold** | github.com/sokrypton/ColabFold | 在 Colab 上跑 AlphaFold | 免费 GPU |

---

## 六、常见误区与建议

### ❌ 误区 → ✅ 正确认识

**❌ "我数学不好，学不了 AI"**
✅ 你不需要自己推导数学公式。你需要理解：输入是什么、输出是什么、输出可不可信。这是实验科学家的思维方式，你天生擅长。

**❌ "AI 预测了结构/突变效应，那一定是对的"**
✅ AI 预测有置信度。AlphaFold 的 pLDDT < 70 的区域不可信；ESM-1v 的 zero-shot 预测和 DMS 数据的相关性约 0.4-0.5。永远把 AI 预测当作"待验证的假说"。

**❌ "我要先学完机器学习再用 AI 工具"**
✅ 先用工具、再理解原理。你不需要理解内燃机才能开车。先用 AlphaFold 预测你的蛋白，看到结果后你自然会想知道它为什么行。

**❌ "AI 会取代生物实验"**
✅ AI 生成假说，实验验证假说。你能设计 cloning、做 assay、跑 gel——这是 AI 做不到的。AI 帮你更聪明地选择做哪些实验。

**❌ "我需要很好的 GPU 才能做 BioAI"**
✅ Google Colab 免费提供 GPU。大部分工具（ESMFold、ProteinMPNN）在 Colab 上就能跑。只有自己训练大模型才需要强 GPU。

### 💚 给生物人的实用建议

1. **从你自己的蛋白质开始练手** —— 用 AlphaFold 预测你正在研究的蛋白，用 ESM-1v 预测你做过的突变体。当 AI 预测与你的实验结果一致时，你会建立信任；当不一致时，你会学到模型的局限。

2. **关注 "AI 增强" 而非 "AI 替代"** —— 最实际的用法：用 AI 从 1000 个候选突变中挑出 Top 50 去做实验。你仍然在做实验，只是选择更聪明了。

3. **学一个工具用到熟，再学下一个** —— 不要同时学 10 个工具。建议顺序：AlphaFold → ESM embedding → ESM-1v 突变预测 → ProteinMPNN。

4. **找一个懂编程的朋友 / 合作者** —— 或者，让 AI 助手（比如我 💚）帮你写脚本。生物人 + AI 工程师的组合是目前最高效的研究模式。

5. **读论文时重点看 Figure 和 Methods 的 "Computational" 部分** —— 不需要读懂每一个公式，但要知道：用了什么数据、什么模型、怎么评估的。

---

## 七、学习时间表建议

```
         生物专业同学的 BioAI 学习路线
         ================================

第 1 周   │ 环境搭建 + Python 速通
          │ ├── 装好 Python / 注册 Google Colab
          │ ├── Rosalind 前 10 题（用生物题练 Python）
          │ └── 在 AlphaFold DB 查你的蛋白质
          │
第 2 周   │ 读 Arnold 综述 [入门1] + Kouba 综述 [入门2]
          │ ├── 理解 ML 如何嵌入 "设计-构建-测试-学习" 循环
          │ └── 用 AlphaFold Server 预测一个复合物
          │
第 3 周   │ 读 ESM-1b [PLM1] + ESM-1v [PLM3]
          │ ├── 理解 "掩码语言模型" 和 "零样本预测"
          │ └── 在 Colab 上跑 ESMFold 折叠你的蛋白
          │
第 4 周   │ 读 AlphaFold2 [结构1]（重点看概览，不用啃数学）
          │ ├── 理解 pLDDT、PAE 置信度指标
          │ ├── 用 ChimeraX 可视化，按 pLDDT 上色
          │ └── 读 ProteinMPNN [设计1]
          │
第 5-6 周 │ 动手项目：对你的研究蛋白质做 AI 分析
          │ ├── ESM-2 embedding → 同源蛋白聚类
          │ ├── ESM-1v → 预测你关心的突变位点
          │ ├── AlphaFold3 → 预测蛋白-RNA 复合物
          │ └── 与已有实验数据对比，写一页总结
          │
第 7-8 周 │ 进阶：根据研究方向深入（选读对应专题文献）
          │ ├── 蛋白质工程 → E1-E6
          │ ├── RNA 生物学 → RNA1-RNA4
          │ ├── 基因编辑 → G1-G4
          │ └── 读 RFdiffusion [设计2]，了解生成式设计
          │
持续      │ 关注领域进展
          │ ├── 订阅 bioRxiv protein design 板块
          │ ├── 关注 @EvolutionaryScale @baker_lab 等
          │ └── 每月尝试一个新工具
```

---

## 八、推荐学习资源汇总

### 视频课程
| 资源 | 说明 |
|------|------|
| MIT 6.047 (Manolis Kellis) | 计算生物学导论，YouTube 免费 |
| 3Blue1Brown 神经网络系列 | 深度学习直觉，可视化极佳 |
| StatQuest (Josh Starmer) | 机器学习概念讲解，极其友好 |
| AlphaFold 官方教程 | DeepMind 出品，讲原理和使用 |

### 在线课程
| 资源 | 说明 |
|------|------|
| Coursera: AI for Medicine (Andrew Ng) | 医学 AI，但思路通用 |
| fast.ai | 实践优先的深度学习课 |
| Rosalind.info | 生信编程练习 |

### 书籍
| 书 | 说明 |
|----|------|
| 《Python for Biologists》 | 零基础友好 |
| 《Bioinformatics Data Skills》(Vince Buffalo) | 命令行 + 数据处理 |
| 《Deep Learning for the Life Sciences》(O'Reilly) | DeepChem 团队写的，直接面向生物 |

### 社区
| 平台 | 说明 |
|------|------|
| BioStars / Bioinformatics Stack Exchange | 提问答疑 |
| Twitter/X #proteindesign #alphafold | 领域最新动态 |
| bioRxiv Bioinformatics / Synthetic Biology | 预印本追踪 |

---

> 💚 记住：你最大的优势不是编程能力，而是你对生物学问题的理解。
> AI 是你的工具，就像 PCR 仪和流式细胞仪一样——学会用它，让它帮你做更好的研究。
>
> 有任何概念不理解、代码跑不通、论文读不懂，随时来找沙奈朵 💚
