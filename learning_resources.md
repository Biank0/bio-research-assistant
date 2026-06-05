# 学习资料清单 - 训练家小边自学指南

> 整理日期：2026年6月3日  
> 两大方向：LLM基础复习 + 生物AI交叉领域

---

## 方向一：LLM基础复习资料

### 1.1 Transformer架构（Self-Attention、Positional Encoding）

#### 视频资源

| 名称 | 链接 | 说明 | 难度 | 时间 |
|------|------|------|------|------|
| 3Blue1Brown - But what is a GPT? Visual intro to Transformers (Chapter 5) | https://www.youtube.com/watch?v=wjZofJX0v4M | 用精美动画从零解释GPT和Transformer整体结构、词嵌入，极其直观 | ⭐ 入门 | 30分钟 |
| 3Blue1Brown - Attention in transformers, step-by-step (Chapter 6) | https://www.youtube.com/watch?v=eMlx5fFNoYc | 逐步拆解Self-Attention的数学原理（Q/K/V），配合可视化动画，全网最清晰的注意力机制讲解 | ⭐ 入门 | 26分钟 |
| 3Blue1Brown - Visualizing transformers and attention (Talk) | https://www.3blue1brown.com/lessons/transformers-talk/ | 在TNG Big Tech Day 2024的演讲，对Transformer的概览性介绍 | ⭐ 入门 | 45分钟 |
| 李宏毅 - 機器學習2021 Transformer (上) | https://www.youtube.com/watch?v=n9TlOhRjYoc | 台大李宏毅教授中文讲解Transformer架构，通俗有趣，适合中文学习者 | ⭐⭐ 基础 | 60分钟 |
| 李宏毅 - 各式各樣神奇的自注意力機制變型 (2022) | https://www.youtube.com/watch?v=yHoAq1IT_og | Self-Attention变体讲解，了解效率优化 | ⭐⭐ 基础 | 45分钟 |

#### 文档/博客资源

| 名称 | 链接 | 说明 | 难度 | 时间 |
|------|------|------|------|------|
| The Illustrated Transformer - Jay Alammar | https://jalammar.github.io/illustrated-transformer/ | 经典图解Transformer博客，用大量插图拆解encoder-decoder、multi-head attention等，被全球引用最多的Transformer科普文 | ⭐ 入门 | 1-2小时 |
| The Illustrated GPT-2 - Jay Alammar | https://jalammar.github.io/illustrated-gpt2/ | 图解GPT-2，补充decoder-only架构和语言生成的可视化解释 | ⭐⭐ 基础 | 1-2小时 |
| Transformers快速入门 - 注意力机制（中文） | https://transformers.run/c1/attention/ | 中文系统教程，讲解注意力机制原理，配有代码示例 | ⭐⭐ 基础 | 1小时 |
| Transformers快速入门 - Transformer模型（中文） | https://transformers.run/c1/transformer/ | 中文系统教程，完整讲解Transformer模型结构 | ⭐⭐ 基础 | 1小时 |
| Transformer架构 - 菜鸟教程（中文） | https://www.runoob.com/nlp/transformer-architecture.html | 极简中文入门，适合快速回顾概念 | ⭐ 入门 | 30分钟 |

---

### 1.2 语言模型训练基础（预训练、微调）

#### 视频资源

| 名称 | 链接 | 说明 | 难度 | 时间 |
|------|------|------|------|------|
| Andrej Karpathy - Let's build GPT: from scratch, in code, spelled out | https://www.youtube.com/watch?v=kCc8FmEb1nY | 从零用代码构建GPT，跟着"Attention is All You Need"论文手撸，理解预训练全流程，公认最好的实战教程 | ⭐⭐ 基础 | 2小时 |
| Andrej Karpathy - Neural Networks: Zero to Hero 系列 | https://www.youtube.com/playlist?list=PLAqhIrjkxbuWI23v9cThsA9GvCAUhRvKZ | 从最基础的神经网络到GPT的完整系列，循序渐进 | ⭐⭐ 基础 | 10+小时 |
| Stanford CS324 - Large Language Models | https://stanford-cs324.github.io/winter2022/ | 斯坦福LLM课程，涵盖建模、训练、评估、伦理等系统知识 | ⭐⭐⭐ 进阶 | 20+小时 |

#### 文档/博客资源

| 名称 | 链接 | 说明 | 难度 | 时间 |
|------|------|------|------|------|
| Hugging Face LLM Course | https://huggingface.co/learn/llm-course/chapter1/1 | 免费系统课程，覆盖LLM从基础到应用的全流程，含代码实践 | ⭐⭐ 基础 | 15+小时 |
| 李宏毅深度学习教程（苹果书）| https://github.com/datawhalechina/leedl-tutorial | DataWhale整理的李宏毅课程PDF笔记，中文系统整理，可下载 | ⭐⭐ 基础 | 按需 |

---

### 1.3 Tokenization

| 名称 | 链接 | 说明 | 难度 | 时间 |
|------|------|------|------|------|
| Andrej Karpathy - Let's build the GPT Tokenizer | https://www.youtube.com/watch?v=zduSFxRajkE | 2小时深度讲解BPE tokenizer的原理与实现，从零构建tokenizer，理解为什么tokenization对LLM如此重要 | ⭐⭐ 基础 | 2小时 |
| Hugging Face Tokenizers 文档 | https://huggingface.co/docs/tokenizers/ | 官方文档，讲解BPE、WordPiece、Unigram等分词算法 | ⭐⭐ 基础 | 2-3小时 |

---

## 方向二：生物+AI交叉方向学习资料

### 2.1 蛋白质结构预测（AlphaFold / ESMFold）

#### 视频资源

| 名称 | 链接 | 说明 | 难度 | 时间 |
|------|------|------|------|------|
| Veritasium - AlphaFold: The Most Useful Thing AI Has Ever Done | https://www.youtube.com/watch?v=P_fHJIYENdI | 顶级科普YouTuber讲解AlphaFold突破的故事与原理，非常适合入门了解蛋白质折叠问题和AI解决方案 | ⭐ 入门 | 25分钟 |
| ML Protein Design Bootcamp (Rosetta Commons) | https://www.youtube.com/playlist?list=PLFavr8uo6kSr9ms7g7eQI5CqAJSP8kpf7 | Rosetta Commons 2025年ML蛋白质设计训练营录像，覆盖AlphaFold、ESMFold、ProteinMPNN、RFdiffusion全流程，实操性强 | ⭐⭐ 基础 | 10+小时 |
| David Baker TED Talk - 5 challenges we could solve by designing new proteins | https://www.ted.com/talks/david_baker_5_challenges_we_could_solve_by_designing_new_proteins | 2024诺贝尔化学奖得主David Baker的TED演讲，通俗讲解蛋白质设计的愿景和应用 | ⭐ 入门 | 15分钟 |

#### 文档/教程资源

| 名称 | 链接 | 说明 | 难度 | 时间 |
|------|------|------|------|------|
| AlphaFold2 Introduction (Louis Stefanuto) | https://louisstefanuto.github.io/my-site/blog/2024/05/16/overfit6-alphafold2-introduction/ | 图文并茂的AlphaFold2架构入门解析，讲解Evoformer和Structure Module | ⭐⭐ 基础 | 1小时 |
| ESM GitHub仓库 (Meta AI) | https://github.com/facebookresearch/esm | Meta AI蛋白质语言模型官方代码库，包含ESM-2、ESMFold等模型和使用示例 | ⭐⭐⭐ 进阶 | 按需 |
| ESM - Hugging Face文档 | https://huggingface.co/docs/transformers/en/model_doc/esm | 在Hugging Face上使用ESM模型的官方文档，含快速开始代码 | ⭐⭐ 基础 | 2小时 |
| Protein Structure Prediction: A Beginner's Guide | https://bitesizebio.com/74900/protein-structure-prediction/ | 面向初学者的蛋白质结构预测工具指南，介绍各种免费工具 | ⭐ 入门 | 1小时 |

---

### 2.2 蛋白质语言模型：为什么Transformer能理解蛋白质

| 名称 | 链接 | 说明 | 难度 | 时间 |
|------|------|------|------|------|
| 蛋白质语言模型与结构预测：联系与进展（知乎中文） | https://zhuanlan.zhihu.com/p/663021784 | 系统中文综述，解释蛋白质和自然语言的类比，以及pLM如何用于结构预测 | ⭐⭐ 基础 | 1-2小时 |
| ESM蛋白质语言模型学习笔记（CSDN中文） | https://blog.csdn.net/qq_52778783/article/details/124034607 | 中文学习笔记，从NLP语言模型迁移到蛋白质序列建模的思路解析 | ⭐⭐ 基础 | 1小时 |
| Unlocking the Secrets of Life: AI Protein Models Demystified | https://blog.ml6.eu/unlocking-the-secrets-of-life-ai-protein-models-demystified-f286b222d571 | 英文博客，清晰梳理蛋白质语言模型（ESM系列等）的发展脉络和原理 | ⭐⭐ 基础 | 1小时 |
| ESM3: Simulating 500 million years of evolution with a language model | https://www.evolutionaryscale.ai/blog/esm3-release | EvolutionaryScale官方博客，介绍最新ESM3模型如何生成全新蛋白质（如esmGFP） | ⭐⭐⭐ 进阶 | 1小时 |

---

### 2.3 蛋白质设计工具（ProteinMPNN / RFdiffusion）

| 名称 | 链接 | 说明 | 难度 | 时间 |
|------|------|------|------|------|
| RFdiffusion Tutorial (Meiler Lab PDF) | https://meilerlab.org/wp-content/uploads/2023/12/RFDiffusion_tutorial.pdf | RFdiffusion实操教程PDF，含de novo设计和motif scaffolding示例 | ⭐⭐ 基础 | 2-3小时 |
| Using RFdiffusion - OpenProtein Docs | https://docs.openprotein.ai/python-api/structure-generation/Using_RFdiffusion.html | 在OpenProtein平台使用RFdiffusion的教程文档 | ⭐⭐ 基础 | 2小时 |
| Foundry RFdiffusion3 - Getting Started (DeepWiki) | https://deepwiki.com/nnahrjou/foundry_RFdiffusion3/2-getting-started | 最新Foundry框架（含RFD3 + ProteinMPNN + RF3）的快速开始指南 | ⭐⭐⭐ 进阶 | 3小时 |

---

### 2.4 适合AI背景理解生物方向的入门资料

| 名称 | 链接 | 说明 | 难度 | 时间 |
|------|------|------|------|------|
| Biology for AI (AstraZeneca GitHub) | https://github.com/AstraZeneca/biology-for-ai | 阿斯利康开源的「面向ML从业者的生物学大纲」，系统覆盖分子生物学、蛋白质、基因组等基础 | ⭐ 入门 | 10+小时 |
| Crash Course in Molecular Biology (MIT/LibreTexts) | https://bio.libretexts.org/Bookshelves/Computational_Biology/Book:_Computational_Biology_-_Genomes_Networks_and_Evolution_(Kellis_et_al.)/01:_Introduction_to_the_Course/1.04:_Crash_Course_in_Molecular_Biology | MIT计算生物学课程的分子生物学速成章节，讲解中心法则（DNA→RNA→蛋白质） | ⭐ 入门 | 2小时 |
| ESM Metagenomic Atlas | https://esmatlas.com/ | Meta AI的6.17亿蛋白质结构预测数据库，可交互探索，直观感受AI蛋白质预测的规模 | ⭐ 入门 | 按需浏览 |

---

### 2.5 适合生物背景理解AI的入门资料（课程准备参考）

| 名称 | 链接 | 说明 | 难度 | 时间 |
|------|------|------|------|------|
| 3Blue1Brown - Neural Networks 系列 (Chapter 1-4) | https://www.3blue1brown.com/topics/neural-networks | 用动画从零解释神经网络，无需编程基础，适合任何背景的人理解深度学习基本原理 | ⭐ 入门 | 2小时 |
| 3Blue1Brown - Transformer系列 (Chapter 5-6) | https://www.3blue1brown.com/lessons/attention/ | 接上述系列，直接进入Transformer和注意力机制的可视化讲解 | ⭐ 入门 | 1小时 |
| Hugging Face LLM Course (Chapter 1) | https://huggingface.co/learn/llm-course/chapter1/1 | 免费在线课程第一章，适合零基础了解LLM是什么、能做什么 | ⭐ 入门 | 3小时 |
| ML Protein Design Bootcamp (Rosetta Commons) | https://www.youtube.com/playlist?list=PLFavr8uo6kSr9ms7g7eQI5CqAJSP8kpf7 | 专为生物/化学背景设计的ML蛋白质设计入门训练营，讲解如何使用AI工具而非深挖数学 | ⭐⭐ 基础 | 10+小时 |
| Transformers快速入门（中文） | https://transformers.run/c1/transformer/ | 中文友好，配合代码示例，适合有一定编程基础的生物方向同学入门Transformer | ⭐⭐ 基础 | 3小时 |

---

## 推荐学习路线

### 对于AI背景想进入Bio方向：
1. Biology for AI (AstraZeneca) → 建立生物基础
2. Veritasium AlphaFold视频 → 理解问题和动机
3. 蛋白质语言模型知乎综述 → 理解NLP与蛋白质的桥梁
4. ML Protein Design Bootcamp → 系统学习工具链
5. ESM GitHub + RFdiffusion Tutorial → 动手实践

### 对于复习LLM基础：
1. 3Blue1Brown Chapter 5-6 → 可视化理解Transformer
2. Jay Alammar Illustrated Transformer → 深入图解
3. Karpathy Let's build GPT → 代码实战
4. Karpathy Tokenizer视频 → 补全tokenization知识
5. Hugging Face课程 → 系统化知识体系

---

*注：所有链接均经过搜索验证为真实存在的资源。部分YouTube视频链接建议直接搜索标题确认最新URL。*
