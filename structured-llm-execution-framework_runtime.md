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
- 2026-08-07：Step 1 验收通过：独立 public canonical repository 已存在；main 为默认分支；中文正文完成内容恒等迁移；README 明确作者与 provenance；旧 `sharable` 正文和 commits 未删除、未重写；未添加开放许可证；未虚构 DOI、v1.0 Release 或 Copyright Office registration。状态从 `Step 1 ACTIVE` → `Step 1 COMPLETE`，Step 2 成为唯一 active step。

### 非阻塞遗留项

- GitHub 仓库 About 区的 `Description` 字段当前可用连接器没有写入接口，因此本轮未能直接修改该 UI metadata；这不影响 repository provenance migration 的验收，也不阻塞 Step 2。
- 已确定推荐 Description 使用英文，以便公开检索和国际读者识别：

  ```text
  A structured constraint-driven LLM execution framework for reliable, auditable multi-step workflows.
  ```

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

### 2.1 中文正文最终审校

对当前中文正文逐节检查：

- 标题、摘要、问题来源、四条设计原则是否内部一致；
- Static / Runtime / History 的定义与后文执行循环是否互相矛盾；
- `State Transition Evidence`、`Decision Supersession`、acceptance gate、artifact verification 等术语是否前后一致；
- Case A / Case B 中的具体事实、数字、日期和外部链接是否仍由对应仓库证据支持；
- 第七节风险分层是否与两个 Case Study 的定位一致；
- 是否存在重复论述、草稿占位、旧链接或已经失效的描述。

审校原则：

- 只修正能够由当前文章逻辑或仓库事实支持的问题；
- 不为了“显得更学术”扩张方法论主张；
- 不新增未经验证的效果量、benchmark 或普适性结论；
- 任何会改变框架核心定义的修改必须先报告 owner，不得静默完成。

### 2.2 正式作者与版本元数据

在中文 v1.0 candidate 中加入清晰但不过度干扰正文阅读的 publication metadata。至少包括：

```text
Author: Yeming Dai
Version: 1.0 candidate
Canonical repository: https://github.com/smter6626/structured-llm-execution-framework
Copyright © 2026 Yeming Dai. All rights reserved.
```

`DOI` 在未 reserve / publish 前不得伪造或占位成看似真实的 identifier；可以写 `DOI: not yet assigned`，也可以在正式 DOI 阶段前暂时不显示 DOI 字段。

### 2.3 Copyright / rights statement

新增 `COPYRIGHT.md`，至少明确：

- Copyright © 2026 Yeming Dai；
- 当前 `All rights reserved`；
- 没有通过本仓库授予 CC / MIT / GPL 等开放许可；
- 版权主张针对具体文字、结构、组织和可受保护的人类原创贡献，而不声称通过版权垄断抽象思想、方法或独立实现；
- 正常引用、评论、批评及法律允许的 fair use / exceptions 不因该声明而被取消；
- 本文经历 LLM-assisted drafting / editing，但最终选择、组织、事实核验和发布决策由作者完成；
- 该文件是项目 rights statement，不应伪装成法律意见或政府登记证明。

### 2.4 `CITATION.cff`

新增可解析的 `CITATION.cff`，至少包含：

- `cff-version`；
- message；
- 正式英文工作标题（作为 citation title，可在英文正文生成前先固定工作标题）；
- author：Yeming Dai；
- release-date / date 字段只填写能够真实支持的日期；
- version 标记为 pre-v1.0 / candidate，不得虚构已经存在的正式 release；
- repository URL 指向 canonical repository；
- DOI 字段在没有真实 DOI 前省略。

创建后必须做 YAML / CFF 基础语法验证；若当前工具无法执行官方 CFF validator，至少使用 YAML parser 并人工核对 CFF 关键字段。

### 2.5 README 同步

README 更新为：

- canonical project landing page；
- 明确中文 v1.0 candidate 状态；
- 保留 provenance note 和旧 `sharable` 历史入口；
- 新增 Rights / Citation 入口；
- 不提前声称英文版、PDF、Release、DOI 或 Copyright Office registration 已完成。

### 验收条件

Step 2 只有在以下条件全部满足后才能 COMPLETE：

- [ ] 中文正文逐节审校完成，所有修改都有明确理由；
- [ ] Case A / Case B 的关键事实与链接重新核验，无已知失效引用；
- [ ] 中文正文显示 `Author: Yeming Dai` 和 v1.0 candidate 状态；
- [ ] canonical repository 指向新独立仓库；
- [ ] `Copyright © 2026 Yeming Dai. All rights reserved.` 明确出现；
- [ ] `COPYRIGHT.md` 已建立且 rights boundary 与 Static 一致；
- [ ] `CITATION.cff` 已建立并通过基础解析检查；
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
- rights statement 与未来 Zenodo 许可设置存在不确定性：当前维持 `All rights reserved`，把平台映射问题留到 DOI active step 核对。

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
