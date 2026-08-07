# Structured LLM Execution Framework — Copyright & Provenance Runtime

## Current Status

```text
ACTIVE — dedicated canonical repository migration completed; Step 2 (Chinese v1.0 candidate and authorship/copyright metadata) is active
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
- 2026-08-07：Step 2.1 related-work 审校发现第八节存在两类事实/定位问题：原文把 ReAct 与 CoT 一并概括为“单次推理”不够准确；同时只比较 AutoGPT / SOP 已不足以覆盖 2025–2026 的主流 structured-spec、context-engineering 和 agent-runtime 实践。已在 commit `4fcefd36666eef4f7c713fabda5e449dafb70c56`（`docs: update related-work positioning for v1.0 review`）中只修改第八节：更正 CoT / ReAct 定位，新增 GitHub Spec Kit / Kiro Specs、context engineering / `AGENTS.md` / `CLAUDE.md` / Steering、LangGraph / OpenAI Agents SDK / AutoGen 的比较，并修正“传统 SOP 是静态的”这一过度概括。commit diff 已复核，除第八节外无其他正文变化；该修改属于 editorial / factual positioning correction，不改变 Static 合同或框架核心定义，因此 Step 2.1 继续 ACTIVE。

---

# active step

## Step 2 — 冻结中文 v1.0 候选与作者 / Copyright / Citation 元数据

### 目标

在已经完成 repository split 的 canonical repository 中，把当前中文正文从“持续迭代稿”推进为 **v1.0 candidate**：完成最后一轮事实、术语和结构审校，并建立明确的作者身份、copyright / rights statement 与机器可读 citation metadata。

本步骤完成后仍然 **不创建正式 `v1.0` tag / GitHub Release，不生成 DOI，不开始美国版权登记**。这些必须等待英文版和中英文联合验收。

### 必须读取的事实来源

执行前完整读取：

1. `structured-llm-execution-framework_static.md`
2. `structured-llm-execution-framework_runtime.md`
3. `structured-llm-execution-framework-zh.md`
4. `README.md`
5. Case A / Case B 中被引用的真实仓库证据，仅在需要核对具体事实时访问

不得依赖聊天记忆替代仓库当前内容。

### 允许修改的范围

本步骤原则上只允许修改 / 新增：

```text
structured-llm-execution-framework-zh.md
README.md
CITATION.cff
COPYRIGHT.md
structured-llm-execution-framework_runtime.md
```

如发现必须修改 Static 才能继续，先停止并说明合同冲突；不得把普通编辑结果写回 Static。

### 执行顺序

#### Step 2.0 — 建立审校基线

在任何正文修改前记录并核对：

- 当前 `main` 最新 commit；
- 中文正文 blob SHA；
- README / Static / Runtime 当前 blob SHA；
- 当前不存在正式 `v1.0` tag / Release / DOI；
- 当前不存在 repository-wide open-content license。

目的：让后续所有 v1.0 candidate 修改都能明确追溯到迁移完成后的干净基线。

#### Step 2.1 — 中文正文事实与结构审校

对当前中文正文逐节检查：

- 标题、摘要、问题来源、四条设计原则是否内部一致；
- Static / Runtime / History 的定义与后文执行循环是否互相矛盾；
- `State Transition Evidence`、`Decision Supersession`、acceptance gate、artifact verification 等术语是否前后一致；
- Case A / Case B 中的具体事实、数字、日期和外部链接是否仍由对应仓库证据支持；
- 第七节风险分层是否与两个 Case Study 的定位一致；
- 是否存在重复论述、草稿占位、旧链接或已经失效的描述。

先形成问题清单，再修改正文。问题分为两类：

1. **Editorial / factual correction**：措辞、重复、链接、事实数字、术语一致性等，在证据充分时可直接修正；
2. **Framework-contract change**：会改变核心定义、角色权限、执行循环或方法论边界的修改，必须停止并交 owner 决策，不能以“润色”名义静默改写。

审校原则：

- 只修正能够由当前文章逻辑或仓库事实支持的问题；
- 不为了“显得更学术”扩张方法论主张；
- 不新增未经验证的效果量、benchmark 或普适性结论；
- 任何会改变框架核心定义的修改必须先报告 owner，不得静默完成。

#### Step 2.2 — 写入正式作者与候选版本元数据

正文顶部或摘要附近加入清晰但不过度干扰阅读的 publication metadata，至少包括：

```text
Author: Yeming Dai
Version: 1.0 candidate
Canonical repository: https://github.com/smter6626/structured-llm-execution-framework
Copyright © 2026 Yeming Dai. All rights reserved.
```

规则：

- `DOI` 在未 reserve / publish 前不写伪 identifier；
- 不把 candidate 写成正式 release；
- 不虚构“registered copyright”或 Copyright Office registration；
- 中文正文、README、`COPYRIGHT.md`、`CITATION.cff` 中的作者拼写必须完全一致。

#### Step 2.3 — 建立 `COPYRIGHT.md`

新增 rights statement，至少明确：

- `Copyright © 2026 Yeming Dai.`；
- 当前 `All rights reserved`；
- 本仓库当前没有授予 CC / MIT / GPL 等开放许可；
- 版权主张针对具体文字、结构、组织以及可受保护的人类原创贡献，不声称通过版权垄断抽象思想、方法或独立实现；
- 正常引用、评论、批评和法律允许的 fair use / statutory exceptions 不因该声明而被取消；
- 本文经历 LLM-assisted drafting / editing，但最终选择、组织、事实核验、修订和发布决策由作者完成；
- 该文件只是项目 rights statement，不是政府登记证明，也不是法律意见。

#### Step 2.4 — 建立并验证 `CITATION.cff`

采用当前 GitHub / Citation File Format 官方仍支持的 **CFF 1.2.0** 结构。由于本仓库承载的是一篇方法论文章/框架，而不是希望被当成软件包引用的程序，`CITATION.cff` 应使用 `preferred-citation` 将实际推荐引用指向该框架文章；在正式出版类型尚未锁定前，优先使用 `type: generic`，不要提前声称 journal article / conference paper。

候选元数据至少包括：

- `cff-version: 1.2.0`；
- `message`：明确要求引用 `preferred-citation`；
- top-level `title`；
- top-level `authors`：Yeming Dai；
- top-level `version: "1.0-candidate"`；
- `repository-code` 或 `url` 指向 canonical repository；
- `preferred-citation.type: generic`；
- `preferred-citation.title` 使用冻结的英文工作标题；
- `preferred-citation.authors`：Yeming Dai；
- `preferred-citation.year: 2026`；
- `preferred-citation.url` 指向 canonical repository；
- DOI 在真实获得前省略。

特别规则：

- CFF 的正式日期字段是 `date-released`；candidate 尚未形成正式 v1.0 Release 时默认省略，不用当前日期冒充 release date；
- 当前 rights strategy 是 `All rights reserved`，不要为了填 CFF 的 `license` 字段而虚构 SPDX/open license；rights 以 `COPYRIGHT.md` 和正文 notice 为准；
- 英文工作标题一旦用于 `preferred-citation`，Step 3 翻译时默认沿用，除非 owner 明确批准改名。

验证至少包括：

1. YAML 语法解析通过；
2. CFF 1.2.0 必填字段与字段名人工核对；
3. 若执行环境可用官方 CFF validator / schema validator，再增加 schema validation；
4. GitHub 默认分支出现 “Cite this repository” 后，检查生成的 citation 不应把不存在的 DOI、正式 release date 或开放许可证写进去。

#### Step 2.5 — README 同步

README 更新为 canonical landing page，并保持信息量克制：

- 中文版标记为 v1.0 candidate；
- 英文版仍标记为下一阶段；
- provenance note 和旧 `sharable` 历史入口继续保留；
- 增加 `Rights` → `COPYRIGHT.md`；
- 增加 `Citation` → `CITATION.cff`；
- About Description 与 README 一句话摘要保持语义一致；
- 不提前声称 PDF、正式 Release、DOI 或 Copyright Office registration 已完成。

#### Step 2.6 — 独立验收与状态推进

完成修改后重新从 GitHub 读取实际 `main`，而不是只相信写入结果：

- diff 审核正文所有改动；
- 重新核验 Case A / Case B 的关键事实和链接；
- 确认 `COPYRIGHT.md` 与 Static rights boundary 一致；
- 确认 `CITATION.cff` 可解析且没有虚构字段；
- 确认 README / 正文 / CFF / COPYRIGHT 的 author、version、repository、rights 状态一致；
- 确认没有误创建 tag / Release / DOI / open license；
- 将完成 commit SHA 与验证证据追加到 Runtime `done`；
- 只有全部验收通过后，Step 2 才可标记 COMPLETE，并把 Step 3 提升为唯一 active step。

### 验收条件

Step 2 只有在以下条件全部满足后才能 COMPLETE：

- [ ] 中文正文逐节审校完成，所有修改都有明确理由；
- [ ] Case A / Case B 的关键事实与链接重新核验，无已知失效引用；
- [ ] 中文正文显示 `Author: Yeming Dai` 和 v1.0 candidate 状态；
- [ ] canonical repository 指向新独立仓库；
- [ ] `Copyright © 2026 Yeming Dai. All rights reserved.` 明确出现；
- [ ] `COPYRIGHT.md` 已建立且 rights boundary 与 Static 一致；
- [ ] `CITATION.cff` 已建立并通过基础解析检查；
- [ ] GitHub citation UI 未显示虚构 DOI / release date / license；
- [ ] 未添加未经 owner 授权的开放许可证；
- [ ] 未虚构 DOI、正式 v1.0 Release 或版权登记；
- [ ] README 与正文 / rights / citation metadata 状态一致；
- [ ] GitHub 上实际文件与提交证据复核通过；
- [ ] 完成 commit SHA 写入 Runtime `done`；
- [ ] Step 3 被提升为唯一 active step。

### 失败 / 阻塞处理

- 发现文章核心定义需要改写：停止，列出问题和建议，由 owner 决定是否改变正文。
- 发现 Case Study 事实与外部仓库不一致：不得猜测；按证据修正或标记 blocker。
- `CITATION.cff` 中某字段含义不确定：查官方 CFF 规范后再写，不凭记忆猜字段。
- GitHub citation UI 把框架误呈现为软件且 `preferred-citation` 无法纠正：记录实际行为，暂停 citation metadata 定稿，不为了通过 UI 而虚构 publication type。
- rights statement 与未来 Zenodo 许可设置存在不确定性：当前维持 `All rights reserved`，把平台映射问题留到 DOI active step核对。

---

# next steps

以下只保留方向，等当前 active step 完成后再展开。

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
