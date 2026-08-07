# Structured LLM Execution Framework — Copyright & Provenance Runtime

## Current Status

```text
ACTIVE — Step 2 is active; Step 2.3 rights statement is complete and Step 2.4 (CITATION.cff) is the current substep
```

当前 canonical repository：

- `smter6626/structured-llm-execution-framework`

当前 canonical Chinese article：

- `structured-llm-execution-framework-zh.md`

早期 provenance 继续保留于：

- `smter6626/sharable/structured-llm-execution-framework/`

---

# done

- 2026-08：中文文章已在 `smter6626/sharable` 中持续公开迭代，并形成 Case A（长期科研工程）与 Case B（AudioShifter 软件发布工程）两个实际案例。
- 2026-08：已明确本任务的核心目的不是阻止他人借鉴抽象思想，而是强化文章及框架论述的 authorship / priority / provenance，使其可以作为直博、实习和其他职业/学术材料中的可验证成果。
- 2026-08：已决定保留 `sharable` 的既有 Git commit 历史，不通过 history rewrite、force push 或删除早期 commits 的方式“清理”来源证据。
- 2026-08：已决定将成熟后的框架文章从杂项 `sharable` 仓库拆分为独立 canonical repository；后续英文版、正式版本、GitHub Release、DOI 和 citation metadata 原则上都应落在独立仓库。
- 2026-08：当前默认 rights strategy 为 `Copyright © 2026 Yeming Dai. All rights reserved.`；在 owner 明确改变许可前，不主动授予 CC 或其他开放内容许可。
- 2026-08：已确定主要正式化路线为：独立仓库迁移 → 中文 v1.0 冻结与版权/引用元数据 → 英文版 → 中英文联合审校 → 固定 PDF → Git tag / GitHub Release → Zenodo DOI → DOI 回填与双向链接 → 可选美国版权登记。
- 2026-08-07：创建长期合同 `structured-llm-execution-framework_static.md`，原 `sharable` commit `8d5e706c6f258cc10813274e7f765008e1fb5756`。Static 明确 provenance、安全边界、版权目标、正式版本、DOI、英文版、Git 安全和可选美国版权登记的长期规则。
- 2026-08-07：创建初始 Runtime，原 `sharable` commit `5caf7600188bc1990bd416607374fe12c743beb8`，将独立仓库迁移设为唯一 active step。
- 2026-08-07：owner 创建公开仓库 `smter6626/structured-llm-execution-framework`。GitHub metadata 核验：visibility=`public`，default branch=`main`，仓库在迁移写入前 size=0。
- 2026-08-07：在新仓库建立 README，commit `930628a06df27f2b74fa59374a392e80098d3f57`（`chore: initialize canonical framework repository`）。README 明确 `Author: Yeming Dai`、pre-v1.0 状态、新仓库 canonical 身份，并链接回 `smter6626/sharable` 的原始正文和历史入口。
- 2026-08-07：迁移中文正文到新仓库根目录，commit `ec1397369b80ba0029ab51e9850bdbe653568180`（`docs: migrate Chinese framework article from sharable`）。迁移后新文件 blob SHA 为 `a8cf5a821bb97855b3e45bb07bff3d5c8607f735`，与迁移前 `sharable` 当前正文 blob SHA **完全相同**，证明本次 repository split 没有夹带正文修改。
- 2026-08-07：迁移 Static 到新仓库，commit `32b1a79fc4436fa3f7464ae2f76e8b0463145c36`（`docs: migrate copyright and provenance static contract`）。Static 作为 internal execution-control document 保留，不作为 DOI deposit 的默认主体。
- 2026-08-07：迁移并推进 Runtime 到新仓库，commit `d53a7e7b15d7abbc805c3037b568cd2ae298a01e`（`docs: migrate runtime and activate v1.0 metadata step`），新仓库自此承载唯一当前执行状态。
- 2026-08-07：按已完成的 repository split 更新新仓库 Static 中的稳定 canonical 路径和 provenance 边界，commit `514af202f7a8e07806ede337d43c6051a86be8e4`（`docs: align static contract with canonical repository split`）；未改变版权、DOI、版本或 Git 安全合同。
- 2026-08-07：迁移后再次从 GitHub 读取新旧两份中文正文；两者 blob SHA 均为 `a8cf5a821bb97855b3e45bb07bff3d5c8607f735`，确认旧正文仍存在且新仓库迁移副本逐字节一致。
- 2026-08-07：Step 1 验收通过：独立 public canonical repository 已存在；main 为默认分支；中文正文完成内容恒等迁移；README 明确作者与 provenance；旧 `sharable` 正文和 commits 未删除、未重写；未添加开放许可证；未虚构 DOI、v1.0 Release 或 Copyright Office registration。状态从 `Step 1 ACTIVE` → `Step 1 COMPLETE`，Step 2 成为唯一 active step。
- 2026-08-07：owner 通过 GitHub About UI 完成仓库展示元数据设置，按已确认方案使用英文 Description `A structured constraint-driven LLM execution framework for reliable, auditable multi-step workflows.`，Website 暂留空，并设置面向 LLM / agent workflow / software engineering / reproducibility / context management 的 Topics；首页仅保留 Releases 入口，不启用 Deployments / Packages。当前连接器不返回 About Description / Topics 字段，因此该 UI 状态作为 **owner-confirmed evidence** 记录，不伪装成 API 独立验证。
- 2026-08-07：在 owner 完成 About 设置后重新检查 canonical repository：仓库仍为 public、default branch=`main`；README、Static、Runtime 状态一致；最新内容 commit 仍沿迁移验收链连续前进，没有发现意外正文改动、额外 license、tag、Release 或 DOI 声明。此前 About metadata 非阻塞遗留项关闭。
- 2026-08-07：Step 2.1 related-work 审校发现第八节存在两类事实/定位问题：原文把 ReAct 与 CoT 一并概括为“单次推理”不够准确；同时只比较 AutoGPT / SOP 已不足以覆盖 2025–2026 的主流 structured-spec、context-engineering 和 agent-runtime 实践。已在 commit `4fcefd36666eef4f7c713fabda5e449dafb70c56`（`docs: update related-work positioning for v1.0 review`）中只修改第八节：更正 CoT / ReAct 定位，新增 GitHub Spec Kit / Kiro Specs、context engineering / `AGENTS.md` / `CLAUDE.md` / Steering、LangGraph / OpenAI Agents SDK / AutoGen 的比较，并修正“传统 SOP 是静态的”这一过度概括。commit diff 已复核，除第八节外无其他正文变化；该修改属于 editorial / factual positioning correction，不改变 Static 合同或框架核心定义。
- 2026-08-07：owner 明确要求从 Step 2.1 继续进入 Step 2.2；当前没有新的 2.1 blocker 被提出，因此按 owner acceptance 结束本轮中文正文审校子步骤，后续若在 Step 2.6 独立验收中发现新的事实/结构问题仍可回退修正。
- 2026-08-07：Step 2.2 完成。commit `ae3d866afc85f155aea2268c9647d528403625e7`（`docs: add v1.0 candidate authorship metadata`）只在中文正文标题下新增四项 publication metadata：`Author: Yeming Dai`、`Version: 1.0 candidate`、canonical repository，以及 `© 2026 Yeming Dai. All rights reserved.`。commit diff 已复核，除这四项元数据外正文无其他变化；没有写入 DOI、正式 `v1.0`、版权登记或开放许可证声明。
- 2026-08-07：Step 2.3 完成。commit `1a107cfef285e13dabf880fa39e9e1b6f158ee6d`（`docs: add copyright and rights statement`）新增 `COPYRIGHT.md`。文件明确 `Copyright © 2026 Yeming Dai. All rights reserved.`，说明仓库当前未授予 CC / MIT / Apache / GPL 等开放许可；把版权主张限制在具体文字表达、组织、选择、结构、案例呈现和其他可受保护的人类原创贡献；明确不主张通过版权垄断抽象思想、方法、系统、程序或独立实现；保留正常引用、评论、批评、学术使用和法律允许例外；如实披露 LLM-assisted drafting / editing / analysis / implementation support，并记录作者对证据选择、范围、术语、结构、事实核验、修订与最终发布的决定；同时明确该文件不是政府版权登记证明或法律意见。GitHub 回读 blob SHA=`98b7814b82d11c9d0727fedbfe3a3203e690db94`，内容与 Static rights boundary 一致。Step 2.4 成为当前子步骤。

---

# active step

## Step 2.4 — 建立并验证 `CITATION.cff`

### 目标

在不虚构正式 v1.0、DOI、release date 或开放许可证的前提下，为当前 v1.0 candidate 建立机器可读的 Citation File Format（CFF）元数据，使 GitHub 和后续 Zenodo / DOI 流程能够识别作者、工作标题、版本和 canonical repository。

本子步骤只处理 citation metadata，不创建正式 `v1.0` tag / GitHub Release，不生成 DOI，不修改 Static，也不开始美国版权登记。

### 必须读取

执行前重新读取：

1. `structured-llm-execution-framework_static.md`
2. `structured-llm-execution-framework_runtime.md`
3. `structured-llm-execution-framework-zh.md`
4. `COPYRIGHT.md`
5. `README.md`

### 实现要求

建立仓库根目录 `CITATION.cff`，采用当前 GitHub / Citation File Format 官方支持的 CFF 1.2.0 结构。

由于仓库承载的是方法论文章/框架，而不是希望被当作软件包引用的程序：

- 使用 `preferred-citation` 指向框架文章本身；
- 在正式出版类型尚未锁定前，优先使用 `type: generic`；
- 不提前声称 journal article / conference paper；
- 英文工作标题应与后续 Step 3 的英文正式版保持一致，除非 owner 明确批准改名。

候选字段至少包括：

```text
cff-version: 1.2.0
message
title
authors
version: 1.0-candidate
repository-code / url
preferred-citation.type: generic
preferred-citation.title
preferred-citation.authors
preferred-citation.year: 2026
preferred-citation.url
```

### 禁止事项

- 没有真实 DOI 前不得写 `doi`；
- candidate 阶段不得用当前日期冒充正式 `date-released`；
- 当前 `All rights reserved`，不得为了填 `license` 字段虚构 SPDX / open license；
- 不得把作者写成 LLM / OpenAI / Anthropic / Codex；
- 不得把本仓库描述成已正式发表的 journal / conference paper；
- 不修改正文方法论内容。

### 验证

至少完成：

1. YAML 语法解析通过；
2. CFF 1.2.0 关键字段与层级人工核对；
3. 若执行环境可用官方 CFF validator / schema validator，则增加 schema validation；
4. 从 GitHub `main` 回读 `CITATION.cff`，确认写入内容与预期一致；
5. 如果 GitHub 出现 “Cite this repository”，检查生成 citation 不包含不存在的 DOI、正式 release date 或开放许可证。

### 验收条件

- [ ] `CITATION.cff` 已创建；
- [ ] 作者为 Yeming Dai；
- [ ] version 明确为 candidate，而不是正式 v1.0；
- [ ] canonical repository 正确；
- [ ] `preferred-citation` 指向框架文章；
- [ ] 没有虚构 DOI / release date / license / publication venue；
- [ ] 基础 YAML / CFF 验证通过；
- [ ] GitHub 回读验证通过；
- [ ] 完成 commit SHA 和验证证据追加到 `done`；
- [ ] 验收后 Step 2.5 成为唯一当前子步骤。

### 失败 / 阻塞处理

- 如果 CFF 字段或 `preferred-citation` 语义不确定：先查当前官方 CFF / GitHub 文档，不凭记忆猜字段。
- 如果 GitHub citation UI 把框架错误呈现为软件且 `preferred-citation` 无法纠正：记录实际行为并暂停，不通过虚构 publication type 修复 UI。
- 如果英文工作标题需要改变框架定位：停止并交 owner 决定。

---

# next steps

## Step 2.5 — README 同步

方向：把 README 更新为 v1.0 candidate 的 canonical landing page，增加 Rights 与 Citation 入口，保留 provenance，英文版仍标记为下一阶段。

## Step 2.6 — 独立验收与 Step 2 收口

方向：重新从 GitHub `main` 拉取正文、README、`COPYRIGHT.md`、`CITATION.cff`、Static 和 Runtime，核对作者、版本、rights、canonical repository、Case A/B 事实和无虚构状态；全部通过后关闭 Step 2，并把 Step 3 提升为唯一 active step。

## Step 3 — 制作英文正式版

方向：以冻结后的中文 v1.0 candidate 为唯一事实源进行英文翻译与学术英语润色；保持框架定义、Case A / Case B、数字、作者身份和 rights metadata 一致。

## Step 4 — 中英文联合一致性验收

方向：交叉检查标题、作者、版本、术语、链接、案例事实、数字、rights metadata 和 citation metadata，形成 v1.0 release candidate。

## Step 5 — 生成固定版 PDF 与发布资产

方向：生成中英文固定 PDF，验证字体、链接、分页、作者信息、版本和版权信息；生成 SHA-256 或等价资产校验记录。

## Step 6 — Git v1.0 tag 与 GitHub Release

方向：从干净且已验收的 commit 创建不可移动的正式 `v1.0` tag 和 GitHub Release；正式资产不得在发布后静默替换。

## Step 7 — Zenodo DOI

方向：核对届时 Zenodo 最新规则，建立 deposit，优先 reserve DOI → 回填 Markdown / PDF / CITATION → 最终 Publish；确保 creator、版本、发布日期、rights、repository 与文件一致。

## Step 8 — DOI 回写与 citation closure

方向：把正式 DOI 回写 GitHub README、中文 / 英文文档、PDF、`CITATION.cff` 等入口，并验证从 DOI、Release 和 repository 任何一端都能定位到同一正式成果。

## Step 9 — 可选：美国版权登记

方向：仅在 owner 确认要做时启动；届时重新核对 U.S. Copyright Office 最新规则、发表状态、deposit copy、AI-assisted authorship disclosure 和申请类型。该步骤不阻塞主要任务完成。

---

# stop condition

主要任务可判定为：

```text
PASS — v1.0 authorship/provenance package publicly frozen, citable, DOI-backed, and cross-linked
```

前提是 Static 的主要验收标准全部通过。

美国版权登记若未执行，应标记为 `OPTIONAL / NOT STARTED`，不得因此把主要任务判定为 PARTIAL。
