# Structured LLM Execution Framework — Copyright & Provenance Runtime

## Current Status

```text
ACTIVE — Step 8 COMPLETE / PASS; Step 9 GitHub frozen v1.0 release and citation closure is the sole active step
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
- 2026-08：已确定主要正式化路线为：独立仓库迁移 → 中文 v1.0 冻结与版权/引用元数据 → 英文版 → 中英文联合审校 → 固定 PDF → Git tag / GitHub Release → Zenodo DOI → DOI 回填与双向链接 → 可选美国版权登记。该早期未来路线在 Step 4 的 PDF 前冻结审查中发现会导致正式 Release 后回填 DOI、从而修改已冻结资产，因此已由后续 evidence-backed sequencing decision 显式 supersede；详见 Step 4 完成记录与当前 next steps。
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
- 2026-08-07：Step 2.3 完成。commit `1a107cfef285e13dabf880fa39e9e1b6f158ee6d`（`docs: add copyright and rights statement`）新增 `COPYRIGHT.md`。文件明确 `Copyright © 2026 Yeming Dai. All rights reserved.`，说明仓库当前未授予 CC / MIT / Apache / GPL 等开放许可；把版权主张限制在具体文字表达、组织、选择、结构、案例呈现和其他可受保护的人类原创贡献；明确不主张通过版权垄断抽象思想、方法、系统、程序或独立实现；保留正常引用、评论、批评、学术使用和法律允许例外；如实披露 LLM-assisted drafting / editing / analysis / implementation support，并记录作者对证据选择、范围、术语、结构、事实核验、修订与最终发布的决定；同时明确该文件不是政府版权登记证明或法律意见。
- 2026-08-07：owner 冻结英文正式标题为 **Repository-Native Execution Governance for Long-Running LLM Workflows**，英文副标题为 **A Structured Constraint-Driven Framework for Durable Contracts, Runtime State, and Evidence-Backed Transitions**。中文标题与副标题保持现状，不要求逐字镜像；英文标题用于后续 CFF、英文正文、PDF、Zenodo/DOI 与 CV/portfolio identity，除非 owner 明确批准改名。
- 2026-08-07：Step 2.4 完成。执行前重新核对 GitHub 官方 CITATION 文档与 Citation File Format 1.2.0 schema guide：GitHub 支持根目录 `CITATION.cff`，并支持使用 `preferred-citation` 将引用重定向到非软件成果；`type: generic` 为合法 reference 类型。候选 CFF 在写入前通过本地 YAML parser 基础解析；当前环境未安装 `cffconvert`，因此没有伪造官方 validator 结果，而是依据 CFF 1.2.0 官方 schema guide 对字段名、必填项和层级进行人工核对。commit `dcc982a188ca0e9161d7b5b3058cdf7148203697`（`docs: add candidate citation metadata`）新增根目录 `CITATION.cff`：作者为 Yeming Dai，top-level version=`1.0-candidate`，canonical repository 正确；`preferred-citation.type=generic`，其 title 使用正式英文标题与副标题合并后的完整 citation title，year=`2026`，version=`1.0-candidate`。文件明确没有 `doi`、`date-released`、`license` 或 publication venue 字段。GitHub `main` 回读 blob SHA=`fb7162973a72ae263efe6a00cd6080e789a683ee`，内容与预期一致。
- 2026-08-07：owner 确认该框架应作为 **持续演化的方法论（evolving methodology）** 管理；正式版本只冻结具体可引用快照，而不是冻结整个项目。`main` 可继续演化，后续实质改进通过 `v1.1` / `v1.2` / `v2.0` 等新版本发布，不移动或静默改写已经正式发布的旧 tag / Release / fixed artifact。该决定与 Static 已有“正式版本冻结、后续实质修改进入新版本”的合同一致，不需要修改 Static。
- 2026-08-07：Step 2.5 完成。commit `4041ca26d61d6bc573cdd03c5b26705f6c08aee7`（`docs: sync README for v1.0 candidate`）把 README 从迁移初期 landing page 同步为当前 v1.0 candidate 的 canonical project landing page：H1 使用冻结后的正式英文标题，副标题同步；Author=`Yeming Dai`、Status=`v1.0 candidate`、canonical repository 明确；中文候选稿作为当前 source text，英文版仍标记为 in preparation；新增 Versioning 段明确“formal release = frozen citable snapshot, methodology continues through new versions”；保留 `sharable` provenance；新增 Rights → `COPYRIGHT.md` 与 Citation → `CITATION.cff`；明确当前没有正式 `v1.0` tag、GitHub Release、DOI、开放许可或 Copyright Office registration。commit diff 已复核，只修改 `README.md`。
- 2026-08-07：Step 2.6 独立总验收重新从 GitHub `main` 读取并交叉核对 Step 2 的实际产物。验收时核心 blob SHA 为：README `62b795685e0d46e219970b1232289ff002821276`；中文正文 `859a84479a3698b8eb92b007ee78d93e9ffe34c7`；`CITATION.cff` `fb7162973a72ae263efe6a00cd6080e789a683ee`；Static `45a13a5a1de105fa27c8a6352a98d20df8e7b226`；Step 2.6 开始时 Runtime `f71dcf5a0037fe98f389895b2ff370d047aca0f4`。正文、README、CFF 的 Author=`Yeming Dai`、candidate version、canonical repository 和正式英文标题均一致；正文 / README / rights statement 的 `Copyright © 2026 Yeming Dai. All rights reserved.` 语义一致；CFF 保持 1.2.0、`preferred-citation.type=generic`，并再次确认没有 `doi`、`date-released`、`license` 或 publication venue。
- 2026-08-07：Step 2.6 在总验收中发现一个非合同级 metadata inconsistency：`COPYRIGHT.md` 首段仍沿用迁移前英文工作名 `Structured Constraint-Driven LLM Execution Framework`，而 README/CFF 已冻结正式英文标题。已用 commit `bd5604e451c90eed0d4e3626770cb88267e6db4a`（`docs: align rights statement with formal framework title`）只修改这一行，改为 **Repository-Native Execution Governance for Long-Running LLM Workflows**，并明确中文标题 **结构化约束驱动的 LLM 执行框架**；diff 复核确认没有改变 rights boundary。修正后 `COPYRIGHT.md` blob SHA=`ebfd017d2c45c21a572d63f619c7f76b09c91cb3`。
- 2026-08-07：Step 2.6 provenance 复核通过：旧 `sharable` 中文正文仍存在，blob SHA=`a8cf5a821bb97855b3e45bb07bff3d5c8607f735`；旧 `sharable` Runtime 明确标记 `SUPERSEDED` 并链接到 dedicated canonical Runtime，因此不存在两个同时 active 的运行时权威来源。
- 2026-08-07：Step 2.6 Case A 关键事实重新由 `smter6626/ChoiResearch` 的真实仓库证据核验：commit `f9a5923ea9b269b30df80d62b5c62202b9c49461` 记录 K=1/3/5 各 `1120/1120` terminal configurations、总计 `3360/3360`，并记录 Adrian 对 high learning-rate `error.json` 的确认；commit `2d0451b31f9de3c1c0d45317beecff33ac6051ad` 记录 RLTPM K=3/K=5 各 `28/28`、K=3 在 L40S `j=8` 峰值约 12 GiB、K=5 在完整 A100 80GB `j=8` 峰值约 47.8 GiB；commit `1ecfab8e2ba591ed5d767a046daa4141d16f6a27` 的 History 记录 TPM/runDRO 收口、PeTeR workshop 接收公开，以及 AAAI 两项实验任务完成。正文 Case A 的关键数字、阶段关系和“task-local Static/Runtime + cross-task History”定位均有当前仓库证据支持。
- 2026-08-07：Step 2.6 Case B 关键事实重新由 `smter6626/AudioShifter` 核验：`docs/map_win_8.2.md` 记录首次仓库盘点 `2026-08-02 21:41:44 MST`；`docs/macos_rebuild_runtime.md` 记录 130-test MVP、打包与发布状态演化；`macos/release/release_verification_v0.1.0-alpha.3.md` 记录最终 `165 passed, 0 failed, 0 skipped`、75 thin-arm64 Mach-O、324 dynamic references、20 `LC_RPATH`、四格式真实处理、源文件保护、取消/冲突处理、GPL 对应源码、非开发机验收，以及 `2026-08-04T13:39:17Z` 公开 Pre-release。首扫到公开发布的时间差重新计算为 32h57m33s，正文写作“约 32 小时 58 分钟，约 33 小时”准确。
- 2026-08-07：Step 2.6 发布状态/许可边界复核：canonical repo 仍为 public、default branch=`main`；读取 `README.md` at ref `v1.0` 返回 `No commit found for the ref v1.0`，证明当前没有名为 `v1.0` 的 Git ref；根目录 `LICENSE` 与 `LICENSE.md` 均不存在，rights 仍由 `COPYRIGHT.md` 的 All Rights Reserved 管理。当前 GitHub 连接器不提供 Release list / citation UI 的直接读取接口，公开网页读取又无法稳定取得这些动态 UI，因此没有把“Release 列表为空”或 “Cite this repository UI 显示正确”伪装成独立 PASS；这是明确的**非阻塞 UI verification limitation**。CFF 文件本身、candidate 状态和无正式 `v1.0` ref 均已由仓库接口独立验证。
- 2026-08-07：**Step 2 COMPLETE / PASS**。中文版 v1.0 candidate 已完成本轮事实与结构审校；作者、candidate version、canonical repository、rights、CFF 与 README 一致；provenance 保持完整；Case A/B 关键事实重新核验；没有发现虚构 DOI、正式 release date、publication venue、Copyright Office registration 或开放许可证。Step 3（英文正式版）成为唯一 active step。
- 2026-08-07：Step 3.1 完成执行侧初稿。Codex 在 clean `main`（初始 HEAD `2be4276f041d0ac40b2b1642398cbaf96661640d`，`origin/main...HEAD=0 0`）完整读取 Static、Runtime、中文正文、README、CFF、COPYRIGHT 后，新建唯一 canonical 英文文件 `structured-llm-execution-framework-en.md`，commit `dc9b5f7a3aa141ee30fc8e0137d997b66f06a762`（`docs: add initial English v1.0 candidate draft`）并 push 到 `origin/main`。GitHub 独立回读确认该 commit 仅新增英文文件、339 lines / 339 insertions，英文文件 blob SHA=`6e1a9eda74d2d88e5cba7a0ff598e5428ba18bbd`；README、Runtime、Static、中文正文、CFF、COPYRIGHT 未被 Codex 修改。Codex 报告的 SHA-256=`436f7e6e6230fefafcfeebc91ad9512109b245be6956b61a8a6c211b29425216` 当前未由 GitHub 连接器独立重算，因此仅记为 execution-side evidence。
- 2026-08-07：Step 3.2 独立中英审阅已完成第一轮。结构、Static/Runtime/History 定义、Step 0–4.4、State Transition Evidence、Decision Supersession、Case A/B、四档 Proportional Rigor、7 个 misuse risks 与 5 类 related work 均覆盖；未发现 novelty / universal reliability / peer-reviewed publication 等 claim-strength 升级，macOS 27 限定、3360 terminal-state 语义、L40S/A100 资源边界与 related-work 定位均保持谨慎。整体判定为 `ACCEPTED WITH MINOR ISSUES`，但 Step 3.2 尚未 COMPLETE，需先完成以下四项 bilingual-parity repair 并由独立验收侧重新读取确认：① 删除英文 Case A 独有的逐 K `1120/1120` 细节，仅保留中文已有的总计 `3360/3360 terminal configurations`；② 删除 Case A Result 末尾英文独有的 theoretical-contribution 免责声明，不用新免责声明替代；③ 删除 Case B 第一段英文独有的 `The Android work is future platform context, not a completed part of this case.`，保留中文已有的 later Android port 背景；④ 将 `accepted by and made public through the UAI 2026 Workshop...` 改为更忠实的 `accepted at ... and made publicly available`。其中第①项 source-gap 部分来自执行 prompt 同时要求“中文是唯一正文事实源”又显式列出各 K `1120/1120`，因此记录为 review-side specification tension，不视为 Codex 隐瞒或无依据幻觉。
- 2026-08-07：Step 3.2 repair 已完成并独立复验通过。Codex 基于最新 Runtime 仅修改 `structured-llm-execution-framework-en.md`，commit `de4d77f7a7bbdc6e72f15f21ac8cb30dc1e11917`（`docs: align English candidate with Chinese source`）并 push。GitHub commit diff 独立确认只有英文文件发生 `4 insertions / 4 deletions`：TPM 表述改为 `accepted at ... and made publicly available`；逐 K `1120/1120` 删除而保留 K=1/3/5 总计 `3360/3360 terminal configurations` 与 `metrics.json` / `error.json` terminal-state 语义；Case A 英文独有 theoretical-contribution 免责声明删除；Case B 英文独有 Android clarification 删除。GitHub `main` 回读英文 blob SHA=`5aa66998c77c382bcb62daccda60e4ff8612622a`；仓库搜索确认英文候选不再包含 `1120/1120`、`theoretical contribution to PeTeR` 或 `future platform context`。四项修正均与中文 canonical source 一致，未发现新的 claim drift 或附带正文修改。**Step 3.2 COMPLETE / PASS**。
- 2026-08-07：Step 3.3 publication metadata / Markdown link audit 完成。GitHub `main` 回读确认英文正文 title=`Repository-Native Execution Governance for Long-Running LLM Workflows`、subtitle=`A Structured Constraint-Driven Framework for Durable Contracts, Runtime State, and Evidence-Backed Transitions`、Author=`Yeming Dai`、Version=`1.0 candidate`、canonical repository 与 `Copyright © 2026 Yeming Dai. All rights reserved.` 均与 README / CFF / COPYRIGHT / 中文 candidate 当前 publication state 一致。CFF 仍为 `1.0-candidate`，没有 `doi`、`date-released`、`license` 或 publication venue；README/COPYRIGHT 也未声称 Copyright Office registration。正文外部链接与 Case A/B evidence links 未发现损坏；owner 人工点击确认其余链接正常。`AGENTS.md` 使用语言中立 OpenAI URL `https://openai.com/index/introducing-codex/`，浏览器落到 `/zh-Hans-CN/` 属于 OpenAI locale routing，不视为坏链，不修改正文。**Step 3.3 COMPLETE / PASS**。
- 2026-08-07：Step 3.4 README 同步完成。commit `e786d07ffe8d0031f8c7a5aef06849ef9d7bf15e`（`docs: link English v1.0 candidate from README`）只修改 `README.md` 的 Current publication 两处状态文本：把 `English version: in preparation` 替换为 `[English v1.0 candidate](structured-llm-execution-framework-en.md)`，并把未来时态说明改为“英文 candidate 已由中文 candidate 产生并通过 Step 3 content/parity 与 publication-metadata review；中英文仍是 candidate，等待后续 bilingual release-candidate review 与正式 v1.0 release”。commit diff 独立复核无其他文件或 README 区域变化；新 README blob SHA=`14cc7bf39c7a070c6dfaa9c3f640436b91ceb006`。**Step 3.4 COMPLETE / PASS**。
- 2026-08-07：Step 3.5 最终仓库级验收通过。重新从 GitHub `main` 读取 Static、Runtime、中英文正文、README、`CITATION.cff` 与 `COPYRIGHT.md`：英文正文 blob SHA 仍为 `5aa66998c77c382bcb62daccda60e4ff8612622a`，中文正文 blob SHA 仍为 `859a84479a3698b8eb92b007ee78d93e9ffe34c7`，README blob SHA=`14cc7bf39c7a070c6dfaa9c3f640436b91ceb006`，CFF=`fb7162973a72ae263efe6a00cd6080e789a683ee`，COPYRIGHT=`ebfd017d2c45c21a572d63f619c7f76b09c91cb3`，Static=`45a13a5a1de105fa27c8a6352a98d20df8e7b226`。README 同时链接双语 candidate；英文 metadata 与 README/CFF/COPYRIGHT 一致；中文 metadata 未被英文流程修改；Step 3.2 四项 repair 未回退。再次读取 `README.md` at ref `v1.0` 得到 `No commit found for the ref v1.0`，根目录 `LICENSE` / `LICENSE.md` 均不存在，因此没有提前出现正式 `v1.0` ref 或 repository-wide open license。**Step 3 COMPLETE / PASS**。
- 2026-08-07：Step 4 双语 release-candidate 审查完成。完整对读当前中英文 candidate 后，章节覆盖、核心术语、execution loop、Case A/B、四档 rigor、7 个 misuse risks、5 类 related work、metadata/rights/citation identity 均保持同一作品语义。审查发现中文版有三处比英文更绝对的 claim-strength residue：`幻觉的根本原因` vs `a primary source`、`双重验证消除自评盲区 / 任何…都会暴露` vs `reduces / creates an opportunity`、以及 K=5 telemetry `证明` vs `showed`。已在 commit `86f24926167baec497fe9b733425f41aefbb19e1`（`docs: align Chinese claim strength with English candidate`）中只修改中文正文三处，分别收紧为“一个主要来源 / 稳定的约束基础”、“减少自评盲区 / 提供第二个视角”和 telemetry“表明”；commit diff 独立确认无其他正文变化。修正后中文 blob SHA=`9919093a3cde5eeae3c198af0957a43a6b18dac8`，英文仍为 `5aa66998c77c382bcb62daccda60e4ff8612622a`。再次检查未发现需要改变核心框架、Case 事实、rights 或 citation identity 的 blocker。Static 首段仍保留内部历史工作名 `Structured Constraint-Driven LLM Execution Framework`，按 Step 4 合同作为 non-blocking control-document residue，不修改长期合同。**Step 4 COMPLETE / PASS**。
- 2026-08-07：Step 4 的 PDF 前冻结审查同时发现旧未来执行顺序存在语义冲突：旧 Runtime 方向为“固定 PDF → Git tag / GitHub Release → Zenodo DOI → DOI 回填”，若照此执行，reserved/published DOI 将迫使 Markdown/CFF/PDF 在正式 Release 后修改，与 Static “正式版本冻结后不得静默修改同一版本资产”及“可在正式发布前 reserve DOI 以回填最终 PDF/Markdown/citation metadata”的合同冲突。该问题不是 Static 冲突，而是 Runtime future-plan ordering 问题，因此按 evidence-backed supersession 修正，不请求修改 Static。旧的 Step 6 Release-before-DOI / Step 7 DOI / Step 8 backfill 顺序从现在起 `SUPERSEDED`。当前有效路线为：Step 5 PDF layout/preflight candidate（非正式固定资产）→ Step 6 Zenodo DOI reservation（draft only, not publish）→ Step 7 DOI backfill + final v1.0 Markdown/CFF/PDF asset freeze → Step 8 exact-commit `v1.0` tag + GitHub Release → Step 9 Zenodo publish + DOI/Release/repository cross-link closure → Step 10 optional U.S. Copyright Office registration。
- 2026-08-07：Step 5 PDF layout/preflight pipeline 已由执行侧完成，commit `3bf8dd17a77e7f5ae9956fb42ef1bca8ea718ac0`（`docs: add reproducible bilingual PDF preflight pipeline`）并 push 到 `main`。GitHub 独立复核确认该 commit 只新增 PDF pipeline 相关内容：`.gitignore`、`docs/pdf-build.md`、`package.json`、`package-lock.json`、`scripts/build_pdfs.sh`、`scripts/markdown_to_html.mjs`、`styles/pdf.css`；canonical Markdown、README、CFF、COPYRIGHT、Static、Runtime 均未被执行侧修改。管线为 Markdown → `markdown-it` 14.1.0 → HTML/CSS → headless Chrome，A4 输出；默认 candidate binary / HTML / renders 位于 ignored `build/`，Step 7 可通过 `PDF_OUTPUT_DIR` / `PDF_VERSION_LABEL` 重用同一入口重新生成正式资产。
- 2026-08-07：Step 5 独立 PDF 验收通过。owner 上传的两个 candidate PDF 与 execution-side 报告哈希完全一致：中文 `structured-llm-execution-framework-zh-v1.0-candidate.pdf` SHA-256=`a358c9706e752e47cdc4f554bf2c7bd358222519f05e017385e342a624520e44`、913775 bytes、12 pages；英文 `structured-llm-execution-framework-en-v1.0-candidate.pdf` SHA-256=`1597d514a9f9a1475d3ee9f3ec667fca0581302e24b1d36b635034236e4a5799`、495250 bytes、14 pages。独立 `pdf_inspect` / PyMuPDF / Poppler 检查确认两者均为 A4（约 595×842 pt）、未加密、可正常 text-extract，producer=`Skia/PDF m151`，字体均 embedded/subset 且有 Unicode mapping；中文包含 STSongti/PingFang、英文包含 Georgia/Times New Roman，代码字体含 Menlo。重新以 Poppler 150 DPI 渲染全部 26 页并逐页检查，且使用 PDFium 对标题页、代码块、execution loop、Case A/B、rigor table、related-work 与末页做第二 renderer spot-check；未发现 missing glyph、黑方块、clipping、overlap、table/code/long-URL overflow 或 orphaned heading 级别的明显版式缺陷。中文 PDF 有 19 个 link annotations / 18 unique URLs（Kiro wrapped link 产生两个 annotation rectangles），英文 18/18；两种语言的 18 个唯一目标均包含 canonical repo、AudioShifter evidence、CoT/ReAct、Spec Kit、Kiro、OpenAI Codex、Claude Code、context engineering、LangGraph、OpenAI Agents SDK、AutoGen 等预期链接。`pdftotext` 关键 token 检查全部通过，且未检测到 replacement char / U+FFFE/U+FFFF 等无效抽取字符。Codex 的第二次 clean rebuild 证据显示 page count、extracted text 和全部 rendered PNG 均一致，但 Chrome 因 creation/modification timestamp 使 PDF binary SHA 不一致；因此当前结论是 **content/layout reproducible, byte-for-byte PDF identity not guaranteed**。这不阻塞 Step 5；Step 7 最终生成后必须记录并冻结那一轮 exact PDF hashes。**Step 5 COMPLETE / PASS**。
- 2026-08-07：Step 6 开始前重新核对 Zenodo 官方 deposit / DOI / license / versioning 文档及 DataCite DOI state 规则。当前证据确认：Zenodo `Reserve DOI` 在 draft 中只预留 identifier，只有 record `Publish` 后才正式注册并开始公开解析；DataCite Draft state 不在全局 Handle System / 公共 discovery 中激活，因此不应把尚未激活的 draft DOI 提前作为公开 citation identifier 使用。Zenodo License 字段默认 CC BY 4.0，但官方支持 custom license；因此本项目继续使用 `All rights reserved` custom rights statement，不改变既有版权策略。Step 4 形成的“Step 7 public DOI backfill → Step 8 GitHub Release → Step 9 Zenodo publish”未来顺序由此发现会制造公开死链窗口，现被本条 evidence-backed decision 再次显式 supersede。
- 2026-08-07：owner 在 Zenodo 建立 unpublished draft 并实际取得 reserved DOI。owner 截图核验 draft metadata：Resource type=`Publication / Technical note`；正式英文主标题与 subtitle 正确；中文 translated title=`结构化约束驱动的 LLM 执行框架`；Creator=`Dai, Yeming`；Description 使用当前英文 Abstract；默认 CC BY 已移除，只保留 custom `All rights reserved`，并设置 `Copyright © 2026 Yeming Dai. All rights reserved.`；Languages=`English` + `Mandarin Chinese`；Version=`1.0`；Publisher=`Zenodo`；keywords 已填写；candidate PDFs 未上传。Preview 因 Zenodo Files validation 要求至少存在一个文件而不可显示，但这是预期的平台校验，不是 metadata blocker。record 仍为 Draft，未 Publish，也未创建 Git `v1.0` tag / GitHub Release。由于 canonical Runtime 本身是公开 GitHub 文件，reserved DOI 的 exact string / draft identifier 在激活前**故意不写入公开 Runtime**；精确值由 owner 的 Zenodo draft 与本轮私有审阅上下文保存。该做法显式 supersede Step 6 早期“把 reserved DOI exact value 记录到 public Runtime”的字面要求，避免公开传播尚未解析的 Draft-state DOI。
- 2026-08-07：**Step 6 COMPLETE / PASS**。Zenodo unpublished draft、reserved DOI、双语/title/creator/version/ARR rights metadata 均已建立并经 owner screenshot audit；当前没有上传 preflight candidate PDFs、没有误 Publish、没有公开 tag/Release。后续有效顺序更新为：Step 7 在本地使用 reserved DOI 形成并验收 exact final v1.0 Markdown/CFF/PDF，随后把 exact final files 上传并冻结在 Zenodo draft（仍不 Publish、仍不把 DOI push 到 public GitHub）→ Step 8 Publish Zenodo 以激活 DOI，并立即验证 DOI resolution / record metadata / file hashes → Step 9 将已验收的同一 release content 推送为 GitHub frozen release commit，创建不可移动 `v1.0` tag + GitHub Release，并完成 DOI ↔ Release ↔ repository ↔ citation metadata cross-link closure → Step 10 optional U.S. Copyright Office registration。
- 2026-08-08：**Step 7 COMPLETE / PASS**。owner 确认 formal publication date=`2026-08-08`。基于 public `main` 建立 local-only branch `release/v1.0-staging`，并用 commit `365710cd6dd17e681b6e241db54769999062438c`（`release: stage v1.0 DOI-backed publication assets`）冻结 release-ready tracked content；该 commit 只修改 `README.md`、`structured-llm-execution-framework-zh.md`、`structured-llm-execution-framework-en.md` 与 `CITATION.cff`，两篇文章 body 没有语义修改。最终中文 PDF SHA-256=`e0218e643937d0e74c442cdab5ecb8fb258044781b611dc8a9a081e4b3bef9e9`，最终英文 PDF SHA-256=`44ec7ca4050f49a5fb8bffab3a2138aacf876baef424f072f119ce001851f7a1`；两份 final PDF 已通过独立 review。Zenodo exact 6-file upload set 与 review bundle hashes 对应，Zenodo Preview 在正式 Publish 前通过，Step 7 final upload set 自此冻结。
- 2026-08-08：**Step 8 COMPLETE / PASS**。Zenodo record 已正式 Publish：published date=`2026-08-08`，Version=`1.0`，specific version DOI=`10.5281/zenodo.21844275`，all-versions DOI=`10.5281/zenodo.21844274`，public record=`https://zenodo.org/records/21844275`，Rights=`All rights reserved`。正式 record 保留 Step 7 的 6 个 exact frozen files。owner 已在未登录 / Incognito 环境中成功访问 record，并确认 DOI resolver `https://doi.org/10.5281/zenodo.21844275` 跳转到正式 Zenodo record。Publish 后该版本作为 frozen version snapshot 管理，不依赖 Zenodo 的后续纠错窗口进行普通修改。

---

# active step

## Step 9 — GitHub frozen v1.0 release + citation closure

### 当前判定

```text
ACTIVE — publish the independently verified Step 7 release-content commits to public `main`, create the immutable `v1.0` tag and GitHub Release from that exact commit, and verify the downloaded release assets against the frozen hashes
```

### 目标

在 specific version DOI 已公开激活、Step 7 exact assets 已冻结并通过独立 review 的前提下，将 local-only staging branch 以 fast-forward 方式发布到 public `main`。从包含 release content 与 Step 7/8 closure evidence 的 exact commit 创建不可移动 annotated `v1.0` tag，再创建 GitHub Release，上传与 Zenodo 对应的 6 个 frozen files 和额外 `SHA256SUMS` integrity asset。发布前后均不得重新生成或替换 Step 7 PDF。

### 当前 authoritative publication identity

- Formal publication date: `2026-08-08`
- Version: `1.0`
- Specific version DOI: `10.5281/zenodo.21844275`
- All-versions DOI: `10.5281/zenodo.21844274`
- Zenodo record: `https://zenodo.org/records/21844275`
- Rights: `Copyright © 2026 Yeming Dai. All rights reserved.`

### Git 与 release 边界

- public `main` 必须以 fast-forward 接收 staging commits；禁止 force push、rebase 或 history rewrite。
- 只有 `origin/main` 与 release snapshot HEAD 完全一致后，才可创建 annotated `v1.0` tag；tag 发布后不得移动或删除。
- GitHub Release 必须先作为 Draft 创建并核对 7 个 explicit assets，且不得使用 asset clobber。
- 只有 UTC 日期进入 `2026-08-08` 后，才可 Publish GitHub Release。
- 发布后必须重新下载 7 个 assets；6 个核心文件必须与 Step 7 frozen SHA-256 完全一致，`SHA256SUMS` 必须验证通过。
- 不得重新生成 PDF，不得修改 Zenodo files，不得创建 Zenodo New version。

### Step 9 完成条件

只有以下全部满足才可 COMPLETE：

- Step 7 release content 与本条 Step 7/8 closure Runtime commit 已 fast-forward 到 public `main`；
- annotated `v1.0` tag 指向 exact release snapshot commit 并已 push；
- GitHub Release 在 publication-time gate 后正式发布，且不是 prerelease；
- 7 个 release assets 的 name/size 正确；
- download-back 后 6 个核心文件 hash 与 Step 7 frozen values 完全一致，`SHA256SUMS` 验证通过；
- repository / Markdown / PDF / CFF / Zenodo / GitHub Release 能围绕 specific DOI 相互定位；
- Runtime 不在本执行侧提前标记 Step 9 COMPLETE，最终状态由独立 review side 验收后推进。

# next steps

## Step 10 — 可选：美国版权登记

方向：仅在 owner 确认要做时启动；届时重新核对 U.S. Copyright Office 最新规则、发表状态、deposit copy、AI-assisted authorship disclosure 和申请类型。该步骤不阻塞主要任务完成。

---

# stop condition

主要任务可判定为：

```text
PASS — v1.0 authorship/provenance package publicly frozen, citable, DOI-backed, and cross-linked
```

前提是 Static 的主要验收标准全部通过。

美国版权登记若未执行，应标记为 `OPTIONAL / NOT STARTED`，不得因此把主要任务判定为 PARTIAL。
