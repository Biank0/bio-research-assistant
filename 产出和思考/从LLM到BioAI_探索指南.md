# 从 LLM 到 BioAI：生物方向 AI 应用探索指南

> 训练家小边 × 沙奈朵
> 创建时间：2026-06-02
> 面向读者：有 LLM/Transformer 背景，想了解 AI 在生物学（尤其是蛋白质工程、RNA 设计、基因编辑）中应用的工程师

---

## 一、为什么 LLM 人应该关注 BioAI？

生物序列（蛋白质、DNA、RNA）本质上是 **字符串** ——氨基酸 20 字母表、核苷酸 4 字母表。
NLP 领域的核心技术几乎全部可以平移：

| NLP 概念 | 生物学对应 |
|---------|-----------|
| Token | 氨基酸残基 / 核苷酸 |
| 语料库 | UniProt (2.5 亿蛋白质序列) / GenBank |
| BERT 掩码预测 | ESM-2：掩码一个氨基酸，预测它应该是什么 → 捕获进化约束 |
| GPT 自回归生成 | ProGen：按条件生成全新蛋白质序列 |
| Embedding 迁移学习 | 蛋白质 embedding 迁移到下游任务（功能预测、活性预测） |
| RLHF / 偏好优化 | 实验数据反馈模型 → ML-guided directed evolution |
| 扩散模型 (Stable Diffusion) | RFdiffusion：生成全新蛋白质三维结构 |
| 评测基准 (GLUE/MMLU) | ProteinGym / TAPE：蛋白质模型统一评测 |

**关键洞察：** 你在 LLM 上积累的 scaling law、attention 机制、tokenization、fine-tuning 等经验，在 BioAI 里几乎是同构的。

---

## 二、学习路线建议

```
第一阶段：建立直觉（1-2 周）
  ├── 读 2 篇综述，理解全景 → [R1] [R2]
  ├── 精读 ESM-2 论文，体会 "蛋白质的 BERT" → [P1]
  └── 跑一遍 ESM-2 推理代码（HuggingFace 上有）

第二阶段：理解核心工具（2-3 周）
  ├── 蛋白质结构预测：AlphaFold2 原理 → [S1]
  ├── 蛋白质设计：ProteinMPNN + RFdiffusion → [D1] [D2]
  ├── 突变效应预测：zero-shot 方法 → [P3]
  └── 基准测试：ProteinGym 怎么评 → [B1]

第三阶段：连接你的研究方向（2-3 周）
  ├── RNA 结构预测的深度学习 → [RNA1] [RNA2]
  ├── AI 辅助基因编辑工具设计 → [G1] [G2]
  ├── DNA 基础模型 (Evo) → [P5]
  └── Bridge RNA 的 AI 应用潜力 → 结合主线三

第四阶段：动手实践
  ├── 用 ESM-2 对 IS110 重组酶做 embedding 聚类
  ├── 用 zero-shot 预测 ISCro4 突变效应，与 DMS 数据对比
  ├── 用 RFdiffusion 尝试 de novo 设计重组酶 scaffold
  └── 微调蛋白质语言模型 → 专用 IS110 活性预测器
```

---

## 三、文献清单（去重整理，共 40 篇）

### 🔰 综述与入门（先读这些）

| 编号 | 论文 | 年份 | 期刊 | 为什么读 |
|------|------|------|------|---------|
| **R1** | Ferruz & Höcker, "Controllable protein design with language models" | 2022 | Nat Mach Intell | 从 NLP 视角讲蛋白质设计，最佳入门 |
| **R2** | Koh et al., "AI-driven protein design" | 2025 | Nat Rev Bioeng | 全景路线图：结构预测→生成模型→实验验证 |
| **R3** | "How AI is reengineering protein engineering" | 2026 | Science | 最新视角，AI 如何改变蛋白质工程 |
| **R4** | Kouba et al., "Opportunities and Challenges for ML-Assisted Enzyme Engineering" | 2023 | ACS Catalysis | 酶工程+ML，实操指导性强 |
| **R5** | Zhang et al., "Scientific Large Language Models: A Survey" | 2024 | arXiv:2401.14656 | 广覆盖：LLM 在生物+化学的适配 |
| **R6** | "Comprehensive Review of Transformer-based Language Models for Protein" | 2025 | arXiv:2507.13646 | NLP→蛋白质架构映射最详细的综述 |

### 🧬 蛋白质语言模型（PLM）

| 编号 | 论文 | 年份 | 期刊 | DOI / URL | 一句话 |
|------|------|------|------|-----------|-------|
| **P1** | Rives et al., "Biological structure and function emerge from scaling unsupervised learning to 250M protein sequences" (ESM-1b) | 2021 | PNAS | 10.1073/pnas.2016239118 | 蛋白质的 BERT：无监督学习 2.5 亿序列，涌现出结构与功能理解 |
| **P2** | Lin et al., "Evolutionary-scale prediction of atomic-level protein structure with a language model" (ESM-2/ESMFold) | 2023 | Science | 10.1126/science.ade2574 | 15B 参数单序列预测蛋白质结构，语言模型的 scaling law 在蛋白质上成立 |
| **P3** | Meier et al., "Language models enable zero-shot prediction of the effects of mutations on protein function" (ESM-1v) | 2021 | NeurIPS | NeurIPS 2021 | 零样本突变效应预测，无需任何实验标注数据 |
| **P4** | Elnaggar et al., "ProtTrans: Toward Understanding the Language of Life" | 2022 | IEEE TPAMI | 10.1109/TPAMI.2021.3095381 | 多种 Transformer 架构 (BERT/T5/XLNet) 在蛋白质上的系统对比 |
| **P5** | Madani et al., "Large language models generate functional protein sequences" (ProGen) | 2023 | Nat Biotechnol | 10.1038/s41587-022-01618-2 | GPT 式自回归生成功能性蛋白质，条件生成范式 |
| **P6** | Nijkamp et al., "ProGen2: Exploring the Boundaries of Protein Language Models" | 2023 | Cell Systems | arXiv:2206.13517 | 6.4B 参数，验证 NLP scaling laws 直接迁移到蛋白质 |
| **P7** | Hayes et al., "Simulating 500 million years of evolution with a language model" (ESM3) | 2025 | Science | 10.1126/science.ads0018 | 多模态（序列+结构+功能）生成式蛋白质语言模型，生成了全新 GFP |
| **P8** | Nguyen et al., "Sequence modeling and design from molecular to genome scale with Evo" | 2024 | Science | 10.1126/science.ado9336 | 7B DNA 基础模型，131k 上下文，跨 DNA/RNA/蛋白质，Arc Institute 出品（与 Bridge RNA 同组！） |

### 🏗️ 蛋白质结构预测

| 编号 | 论文 | 年份 | 期刊 | DOI | 一句话 |
|------|------|------|------|-----|-------|
| **S1** | Jumper et al., "Highly accurate protein structure prediction with AlphaFold" (AF2) | 2021 | Nature | 10.1038/s41586-021-03819-2 | 里程碑：近实验精度的结构预测，attention + Evoformer |
| **S2** | Baek et al., "Accurate prediction with a three-track neural network" (RoseTTAFold) | 2021 | Science | 10.1126/science.abj8754 | 三轨网络同时处理序列/距离/坐标 |
| **S3** | Abramson et al., "Accurate structure prediction of biomolecular interactions with AlphaFold 3" | 2024 | Nature | 10.1038/s41586-024-07487-w | 扩展到蛋白质-核酸-小分子复合物，用扩散架构 |

### 🎨 蛋白质设计与生成

| 编号 | 论文 | 年份 | 期刊 | DOI / URL | 一句话 |
|------|------|------|------|-----------|-------|
| **D1** | Dauparas et al., "Robust deep learning-based protein sequence design using ProteinMPNN" | 2022 | Science | 10.1126/science.add2187 | 给定骨架→设计序列（反向折叠），实验成功率远超传统方法 |
| **D2** | Watson et al., "De novo design of protein structure and function with RFdiffusion" | 2023 | Nature | 10.1038/s41586-023-06415-8 | 扩散模型从噪声生成蛋白质骨架，设计 binder/酶/组装体 |
| **D3** | Ingraham et al., "Illuminating protein space with a programmable generative model" (Chroma) | 2023 | Nature | 10.1038/s41586-023-06728-8 | 可编程扩散模型，按对称性/形状/语义条件生成蛋白质 |
| **D4** | Alamdari et al., "Protein generation with evolutionary diffusion" (EvoDiff) | 2023 | bioRxiv/NeurIPS | bioRxiv:2023.09.11.556673 | 离散扩散直接在序列空间生成，不依赖结构信息 |
| **D5** | Bose et al., "SE(3)-Stochastic Flow Matching for Protein Backbone Generation" (FoldFlow) | 2024 | ICLR 2024 | arXiv:2310.02391 | Flow matching（扩散的优雅替代）在 SE(3) 流形上生成蛋白质骨架 |
| **D6** | Huguet et al., "Sequence-Augmented SE(3)-Flow Matching" (FoldFlow-2) | 2024 | NeurIPS 2024 | arXiv:2405.20313 | 结合 PLM embedding 的条件 flow matching |

### 🧪 RNA 结构预测与深度学习

| 编号 | 论文 | 年份 | 期刊 | DOI / URL | 一句话 |
|------|------|------|------|-----------|-------|
| **RNA1** | Townshend et al., "Geometric deep learning of RNA structure" (ARES) | 2021 | Science | 10.1126/science.abe5650 | 几何深度学习评分 RNA 3D 结构，无手工特征 |
| **RNA2** | Shen et al., "Accurate RNA 3D structure prediction using a language model-based approach" (RhoFold+) | 2024 | Nat Methods | 10.1038/s41592-024-02487-0 | RNA 语言模型 + 端到端深度学习预测 RNA 三维结构 |
| **RNA3** | Chen et al., "Interpretable RNA Foundation Model from Unannotated Data" (RNA-FM) | 2022 | arXiv | arXiv:2204.00300 | RNA 基础模型，2300 万条非编码 RNA 预训练 |
| **RNA4** | "Deep learning for RNA structure prediction" (Review) | 2025 | Curr Opin Struct Biol | Elsevier | 综述：从几何学习到语言模型的 RNA 结构预测进展 |

### 🧫 ML 引导的定向进化

| 编号 | 论文 | 年份 | 期刊 | DOI | 一句话 |
|------|------|------|------|-----|-------|
| **E1** | Yang, Wu & Arnold, "Machine-learning-guided directed evolution for protein engineering" | 2019 | Nat Methods | 10.1038/s41592-019-0496-6 | Arnold 组奠基综述：ML 如何嵌入定向进化 |
| **E2** | Biswas et al., "Low-N protein engineering with data-efficient deep learning" | 2021 | Nat Methods | 10.1038/s41592-021-01100-y | 预训练 + 少量标注 fine-tune → 高效蛋白质工程 |
| **E3** | Hie et al., "Efficient evolution of human antibodies from general protein language models" | 2024 | Nat Biotechnol | 10.1038/s41587-023-01763-2 | 通用 PLM 无需靶标特异训练即可进化抗体 |
| **E4** | "Rapid directed evolution guided by PLM and epistatic interactions" | 2025 | Science | 10.1126/science.aea1820 | PLM + 上位效应感知搜索 → 快速多位点优化 |
| **E5** | Yu et al., "Integrating PLM and automatic biofoundry for enhanced protein evolution" | 2025 | Nat Commun | 10.1038/s41467-025-56751-8 | PLM + 自动化实验平台闭环 DBTL |

### 📊 基准与数据集

| 编号 | 论文 | 年份 | 期刊 | URL | 一句话 |
|------|------|------|------|-----|-------|
| **B1** | Notin et al., "ProteinGym: Large-Scale Benchmarks for Protein Fitness Prediction" | 2024 | NeurIPS | openreview.net | 蛋白质界的 GLUE：217 个 DMS 数据集 + 80+ 模型评测 |
| **B2** | Rao et al., "Evaluating Protein Transfer Learning with TAPE" | 2019 | NeurIPS | arXiv:1906.08230 | 最早的蛋白质迁移学习基准（5 个任务） |
| **B3** | Frazer et al., "Disease variant prediction with deep generative models" (EVE) | 2021 | Nature | 10.1038/s41586-021-04043-8 | 深度生成模型预测人类突变致病性 |
| **B4** | "PFMBench: Protein Foundation Model Benchmark" | 2025 | arXiv | arXiv:2506.14796 | 最新蛋白质基础模型综合评测 |

### ✂️ AI 与基因编辑

| 编号 | 论文 | 年份 | 期刊 | DOI | 一句话 |
|------|------|------|------|-----|-------|
| **G1** | Chuai et al., "DeepCRISPR: optimized CRISPR guide RNA design by deep learning" | 2018 | Genome Biol | 10.1186/s13059-018-1459-4 | 开创性的 sgRNA 效率+脱靶 端到端预测 |
| **G2** | Wessels et al., "Prediction of Cas13d guide RNA activity with deep learning" (TIGER) | 2023 | Nat Biotechnol | 10.1038/s41587-023-01830-8 | RNA 靶向 CRISPR 的深度学习活性预测 |
| **G3** | Marquart et al., "BE-DICT: Predicting base editing outcomes with attention" | 2021 | Nat Commun | 10.1038/s41467-021-25284-x | Attention 机制预测碱基编辑的逐碱基效率 |
| **G4** | Profluent Bio, "OpenCRISPR: AI-generated gene editing systems" | 2024 | — | GitHub | AI 从头生成功能性 Cas9 蛋白！生成模型的终极验证 |

---

## 四、推荐阅读顺序（为 LLM 工程师定制）

### 第一周：找到感觉
1. **[R1]** Ferruz 2022 综述 — 最温和的入门，直接用 NLP 术语讲蛋白质设计
2. **[P1]** ESM-1b — 理解 "蛋白质的 BERT"，attention 可视化 = 接触图
3. **[P5]** ProGen — 理解 "蛋白质的 GPT"，条件自回归生成

### 第二周：核心工具链
4. **[P2]** ESM-2 — 当前最强单序列蛋白质语言模型，15B 参数
5. **[S1]** AlphaFold2 — 理解 Evoformer 和结构预测的 attention 机制
6. **[D1]** ProteinMPNN — 反向折叠（给结构→设计序列）
7. **[D2]** RFdiffusion — 扩散模型生成蛋白质结构（类比 Stable Diffusion）

### 第三周：前沿方向
8. **[P7]** ESM3 — 多模态生成，生成了全新 GFP，"蛋白质的 GPT-4"
9. **[P8]** Evo — DNA 基础模型，Arc Institute 出品，与 Bridge RNA 直接相关
10. **[D4]** EvoDiff — 离散扩散在序列空间生成蛋白质
11. **[RNA2]** RhoFold+ — RNA 结构预测，与你的 bRNA 设计直接相关

### 第四周：连接你的课题
12. **[P3]** ESM-1v zero-shot — 零样本预测突变效应 → 直接用于 IS110 重组酶
13. **[E1]** Arnold 综述 — ML 如何嵌入定向进化循环
14. **[E2]** Low-N 蛋白质工程 — 少量实验数据 + 预训练 = 高效工程
15. **[B1]** ProteinGym — 了解蛋白质 ML 的评测标准
16. **[G4]** OpenCRISPR — AI 从头设计基因编辑酶，最有启发性

---

## 五、核心概念速查

### 蛋白质语言模型 vs. 文本 LLM

```
                    文本 LLM              蛋白质 LLM
─────────────────────────────────────────────────────
词表大小            32k-100k tokens       20 氨基酸 (+特殊 token)
序列长度            数千~百万 token        数百~数千残基
训练数据            TB 级文本             UniProt 2.5 亿条序列
自监督目标          下一词预测 / MLM       MLM (ESM) / 自回归 (ProGen)
Embedding 含义      语义相似度            进化/功能/结构相似度
生成 = ?            写文章                设计新蛋白质
评测 = ?            MMLU/GLUE             ProteinGym/TAPE
RLHF = ?            人类偏好              实验活性数据反馈
```

### 关键工具对照表

| 任务 | NLP 类比 | BioAI 工具 |
|------|---------|-----------|
| 表示学习 | BERT embedding | ESM-2 embedding |
| 序列生成 | GPT | ProGen / ESM3 |
| 结构预测 | — | AlphaFold2/3 / ESMFold |
| 逆问题（结构→序列） | — | ProteinMPNN |
| 结构生成 | Stable Diffusion | RFdiffusion / Chroma |
| 突变效应预测 | 情感分析（类比） | ESM-1v zero-shot / EVE |
| 序列搜索 | 文档检索 | BLAST / HMMer |
| 多序列比对 | 多文档对齐 | Clustal / MUSCLE |

### 你的课题中 AI 可以做什么

```
IS110 重组酶研究 ──→ AI 切入点
  │
  ├── 新亚型发现 ──→ ESM-2 embedding 聚类 + HMMer 搜索
  │                  Evo 模型识别基因组中未注释的 IS110
  │
  ├── 突变效应预测 ──→ ESM-1v zero-shot 预测 ISCro4 单突变
  │                    PLM fine-tune on DMS 数据 → 组合突变预测
  │
  ├── 蛋白质工程 ──→ RFdiffusion 设计新 scaffold
  │                  ProteinMPNN 优化序列
  │                  ML-guided directed evolution 迭代
  │
  ├── bRNA 设计 ──→ RNA-FM embedding 分析 bRNA 家族
  │                  RhoFold+ 预测 bRNA 结构稳定性
  │                  RNA 扩散模型设计增强型 bRNA scaffold
  │
  └── 特异性优化 ──→ AlphaFold3 预测蛋白-RNA-DNA 三元复合物
                     注意力图分析 → 识别特异性决定残基
```

---

## 六、实用资源

### 代码仓库
- **ESM**: github.com/facebookresearch/esm （最常用的蛋白质语言模型）
- **AlphaFold**: github.com/google-deepmind/alphafold
- **ProteinMPNN**: github.com/dauparas/ProteinMPNN
- **RFdiffusion**: github.com/RosettaCommons/RFdiffusion
- **Evo**: github.com/evo-design/evo （Arc Institute，与 Bridge RNA 同组）
- **ProteinGym**: github.com/OATML-Markslab/ProteinGym

### 在线工具
- **AlphaFold DB**: alphafold.ebi.ac.uk — 查询已预测的蛋白质结构
- **ESM Atlas**: esmatlas.com — 7 亿蛋白质的 ESMFold 结构预测
- **UniProt**: uniprot.org — 蛋白质序列数据库

### 推荐关注的团队/实验室
- **Meta FAIR (Alexander Rives)** — ESM 系列
- **David Baker Lab (UW)** — RFdiffusion, ProteinMPNN
- **Arc Institute (Patrick Hsu)** — Bridge RNA + Evo（你课题的核心组！）
- **EvolutionaryScale** — ESM3，Rives 从 Meta 出来创办
- **Frances Arnold Lab (Caltech)** — ML-guided directed evolution 先驱
- **Debora Marks Lab (Harvard)** — EVE, ProteinGym, 变异效应预测

---

> 💚 这份指南会随着你的学习进度持续更新。
> 建议从 [R1] + [P1] 开始，两篇读完你就会觉得 "原来蛋白质 AI 就是这么回事"。
