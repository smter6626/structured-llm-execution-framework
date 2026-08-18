# Maintainer Guide

[toc]

## Document Positioning / 文档定位

**English positioning:** This document is an author/maintainer-facing operational guide for maintaining the repository, evolving the methodology on `main`, preparing future formal releases, and recording practical maintenance notes. It is public for transparency, but it is not itself part of the frozen methodology publication artifact unless a future formal release explicitly includes it.

**中文版文档定位：** 本文档是供作者/维护者使用的仓库级长期维护手册，用于记录 `main` 的持续演化方式、正式版本发布流程、同步规则、缺陷处理方法以及实际维护笔记。文档公开可见，但默认不属于已冻结的方法论正式出版物；除非未来某个正式版本明确把它纳入 release package，否则不应把本文档视为论文/方法论正文的一部分。

---

## 1. 文档职责

本文档记录的是**长期可复用的维护方法和作者操作笔记**，重点回答：

- 日常修改 `main` 时哪些内容需要同步；
- 哪些修改只是仓库维护，哪些修改值得形成新正式版本；
- 正式版本冻结后哪些对象绝对不能回写；
- 中文、英文、README、CFF、PDF、Zenodo、GitHub Release 之间如何同步；
- 发布前后如何做 public-surface audit；
- 发现发布后缺陷时应如何处理；
- ChatGPT、Codex 与作者分别负责什么。

本文档不替代：

- `structured-llm-execution-framework_static.md`：长期合同；
- `structured-llm-execution-framework_runtime.md`：当前 authoritative execution state；
- 中英文方法论正文：正式 publication content；
- `CITATION.cff`：机器可读引用元数据；
- `COPYRIGHT.md`：版权与 rights statement。

如果本文档与 Static 冲突，以 Static 为准；如果本文档描述的当前状态与 Runtime 冲突，以 Runtime 为准。

---

## 2. 仓库中的对象分类

### 2.1 `main`

`main` 是持续演化中的 canonical development line。

正式版本发布后，`main` 仍可以继续前进，包括：

- README 维护；
- 链接修复；
- typo / wording 修复；
- 正文的小幅编辑；
- 新案例、新规则、新章节的开发；
- 为未来 `v1.1` / `v1.2` / `v2.0` 做准备。

`main` 出现新 commit **不等于** 自动产生新正式版本。

### 2.2 Frozen formal release

正式版本由一组被冻结的对象共同定义，例如 `v1.0`：

- exact Git commit；
- immutable Git tag；
- GitHub Release；
- 中英文 Markdown；
- 中英文 PDF；
- `CITATION.cff`；
- `COPYRIGHT.md`；
- Zenodo version record；
- version-specific DOI；
- frozen file hashes。

一旦正式发布，不应为了后续修复而静默移动 tag、替换 Release asset、改写 Zenodo frozen files 或重写历史。

### 2.3 Static

Static 只记录长期稳定合同，例如：

- provenance 原则；
- 正式版本冻结原则；
- rights policy；
- 双语一致性要求；
- Git 安全边界；
- DOI / release 的长期要求。

单次实验、当前 blocker、一次性修复流程不应写入 Static。

### 2.4 Runtime

Runtime 记录动态执行事实，例如：

- 当前唯一 active step；
- 已完成步骤和证据；
- 当前 blocker；
- repair iteration；
- exact commit / tag / DOI / hash；
- superseded decisions；
- 下一步验收条件。

### 2.5 Maintainer Guide

本文档记录长期可复用的**维护流程与作者笔记**。

它比 Static 更操作化，但比 Runtime 更稳定。

---

## 3. 变更分类

后续修改前，先判断属于哪一类。

### A. 仓库维护性修改

典型例子：

- README 坏链；
- 拼写、格式、展示问题；
- 非正文说明文字；
- maintenance guide 本身的补充。

处理原则：

- 修 `main`；
- 不移动旧 tag；
- 不改旧 Release assets；
- 不改旧 Zenodo files；
- 通常不需要新正式版本。

### B. Editorial article change

典型例子：

- typo；
- 语句润色；
- 不改变主张的表达优化；
- related-work 的事实性小修正。

处理原则：

- 改 `main`；
- 检查另一语言是否需要同步；
- 不自动生成新 PDF；
- 不自动修改旧 CFF / DOI / Release；
- 是否进入下一个正式版本取决于累积变化。

### C. Substantive methodology change

典型例子：

- 新增核心定义；
- 改变 Static / Runtime / History 的关系；
- 增加新的执行规则；
- 新增重要案例；
- 改变风险模型、状态转换或验收原则；
- 改变文章结论或方法论边界。

处理原则：

- 在 `main` 开发；
- 中英文应保持语义 parity；
- Runtime 记录开发与验收状态；
- 达到稳定状态后通常形成 `v1.1`、`v1.2` 或 `v2.0`。

### D. Formal release change

这是从 evolving `main` 转换为新的 frozen citable snapshot。

需要走完整 release pipeline，包括版本号、DOI、PDF、hash、tag、Release、Zenodo 和 public-surface audit。

---

## 4. 日常修改后的同步规则

### 4.1 中文 ↔ 英文

只要修改改变了方法论语义、事实、定义、案例、结论或 claim strength，就应检查另一语言。

不要求机械同步：

- 中文标点；
- 英文冠词；
- 纯排版修复；
- 不影响语义的本地语言润色。

长期不允许出现一份语言已经形成新方法论、另一份仍停留在旧方法论的状态。

### 4.2 README

以下变化需要评估 README：

- 当前正式版本改变；
- 项目定位改变；
- DOI / Release 入口改变；
- 双语文章入口改变；
- rights policy 改变；
- canonical repository identity 改变。

普通正文句子修改不要求同步 README。

### 4.3 `CITATION.cff`

`CITATION.cff` 默认描述**当前正式可引用版本**，不是每个 `main` commit。

因此：

- `main` 日常开发时，不应提前把 `version` 改成不存在的 `1.1`；
- 没有新 DOI 时，不应提前写入新 DOI；
- 没有正式发布日期时，不应虚构 `date-released`；
- 只有准备冻结新正式版本时统一更新。

### 4.4 PDF

PDF 是正式 release artifact，不是 `main` 的实时镜像。

日常 Markdown 修改后通常不重新生成正式 PDF。

只有准备正式 release 时：

1. 冻结正文；
2. 生成新的中英文 PDF；
3. 做 render/text/link audit；
4. 记录 exact hashes；
5. 将该轮 PDF 作为新版本 frozen assets。

### 4.5 `COPYRIGHT.md`

普通正文修改通常不需要同步。

需要修改的典型情况：

- 正式标题改变；
- 作者身份改变；
- rights policy 改变；
- 开放许可策略改变；
- LLM-assisted authorship disclosure 的边界发生实质变化；
- 版权主张范围发生变化。

### 4.6 Runtime

以下情况应考虑更新 Runtime：

- 开始一个明显的新内容开发阶段；
- 出现 blocker；
- 形成 repair iteration；
- 做出会 supersede 旧执行方案的决定；
- 准备新 formal release；
- 完成 evidence-backed transition。

### 4.7 Static

只有长期合同发生变化才修改。

例如：

- 以后不再维护英文版；
- 以后不再使用 Zenodo；
- rights strategy 改变；
- release immutability 原则改变。

不能因为单次维护问题修改 Static。

---

## 5. 版本策略

### 5.1 `v1.0` 等正式版本保持冻结

正式发布后：

- tag 不移动；
- Release 不静默替换；
- Zenodo frozen files 不回写；
- hashes 不重新定义；
- historical defects 保留并通过后续 commit / Runtime 解释。

### 5.2 `main` 可以继续前进

发布 `v1.0` 后，以下情况可以只更新 `main`：

- README 修复；
- 链接修复；
- maintainer notes；
- 轻量 editorial changes；
- 下一版本的开发工作。

这类 commit 不自动变成 `v1.1`。

### 5.3 什么时候使用 `v1.0.1`

原则上只在确实需要对 `v1.0` 做一个新的正式维护性快照，并且希望外部引用者区分该快照时考虑。

单纯 README 自引用坏链通常不值得单独发布 `v1.0.1`。

### 5.4 什么时候使用 `v1.1`

适用于兼容现有核心框架、但方法论有可引用的实质增量，例如：

- 新增重要规则；
- 新增 Case C；
- 新增长期维护模型；
- 对 framework taxonomy 做有意义扩展；
- 一批 editorial + factual changes 已累积到值得重新冻结。

### 5.5 什么时候使用 `v2.0`

适用于核心概念、结构、方法论边界或主要执行模型发生明显重构。

版本号最终由作者决定，不由自动规则单独决定。

---

## 6. 新正式版本的同步清单

准备新正式版本时，至少检查：

| 对象 | 是否需要处理 |
| --- | --- |
| 中文 Markdown | 冻结新版本 |
| 英文 Markdown | 冻结并做 bilingual parity review |
| README | 更新 current formal release |
| `CITATION.cff` | 更新 version / date / DOI |
| `COPYRIGHT.md` | rights 未变化时通常保持 |
| 中文 PDF | 新生成并验收 |
| 英文 PDF | 新生成并验收 |
| `SHA256SUMS` | 对新版本重新计算 |
| Git commit | 固定 exact snapshot |
| Git tag | 新建，不移动旧 tag |
| GitHub Release | 新建正式 Release |
| Zenodo | 使用 New version 路径 |
| Version DOI | 使用新版本 specific DOI |
| All-versions DOI | 保持版本系列身份 |
| Related works | 指向对应 GitHub Release |
| Runtime | 记录 freeze / hash / publish evidence |

旧正式版本的文件、tag、Release 和 DOI 保持不变。

---

## 7. 推荐的新版本发布顺序

正式执行前必须重新核对当时最新的 Zenodo / DataCite / GitHub 规则；以下只是当前维护基线。

1. 在 `main` 完成正文开发；
2. 中英文 parity review；
3. 做 claim / metadata / rights review；
4. 建立 Zenodo 新版本 draft；
5. reserve 新 version-specific DOI；
6. 将 DOI 回填到新版本 Markdown / CFF；
7. 生成正式 PDF；
8. 完整 PDF audit；
9. 冻结 exact file set 和 hashes；
10. 上传 exact files 到 Zenodo draft；
11. Zenodo Preview；
12. Publish Zenodo，激活 DOI；
13. 验证 DOI resolution；
14. 将 exact release snapshot fast-forward 到 public `main`；
15. 创建 immutable annotated tag；
16. 创建 GitHub Release；
17. 上传 exact frozen assets；
18. download-back hash verification；
19. Zenodo Related works 指向对应 GitHub Release；
20. 做完整 public-surface audit；
21. Runtime 独立验收并收口。

如未来平台规则变化，应通过 Runtime 的 evidence-backed decision supersession 调整执行顺序，而不是机械沿用旧顺序。

---

## 8. 发布后缺陷处理

### 8.1 `main` 的展示缺陷

直接在 `main` 做最小修复。

例如：

- README 链接错误；
- Markdown rendering defect；
- landing-page typo。

不需要移动旧 tag。

### 8.2 Frozen tag 内存在非核心展示缺陷

如果正式 publication artifacts 本身正确，而 frozen tag 的 README 等辅助 landing-page 文件存在小问题：

- 记录缺陷；
- 在 evolving `main` 修复；
- 不移动 tag；
- 不静默替换 Release；
- 不因纯展示问题自动创建 Zenodo 新版本。

#### 当前已知案例：README canonical repository 链接

`v1.0` 发布后 public-surface audit 发现 README 中裸 canonical repository URL 后紧跟 Markdown 行尾反斜杠，GitHub renderer 将反斜杠编码为 `%5C`，点击后进入 404。

处理方式：

- frozen `v1.0` tag 保持不动；
- `main` 将裸 URL 改成显式 Markdown link；
- Runtime 记录 blocker 和 repair iteration；
- 修复后重新做 targeted public-surface audit。

该案例说明：**正式版本 immutability 优先于为了消除非核心展示缺陷而回写旧 snapshot。**

### 8.3 Frozen publication artifact 本身有错误

如果错误位于正式文章、PDF、CFF、rights、DOI identity 或 release asset 中，不应静默替换。

应先判断：

- 是否需要勘误说明；
- 是否需要新 patch/minor version；
- Zenodo 是否应建立 New version；
- 是否需要在 README / Release notes 中明确历史版本问题。

任何会改变正式引用对象的修复都应作为新的 evidence-backed publication decision 管理。

### 8.4 Metadata-only 问题

如果平台允许对已发布 record 做 metadata edit，而且修改不改变 frozen files 与版本内容，可考虑 metadata-only correction。

执行前必须重新核对平台规则，并在 Runtime 中记录：

- 修改了什么；
- 为什么不需要 New version；
- DOI 是否保持；
- frozen files 是否保持；
- 外部引用语义是否变化。

---

## 9. Public-surface audit

正式发布后不能只检查本地文件和 hashes，还要检查用户实际访问路径。

至少包括：

- GitHub repository 首页；
- README links；
- `vX.Y` tag；
- GitHub Release；
- Release assets；
- Zenodo record；
- DOI resolver；
- Zenodo Related works；
- 中英文 Markdown；
- 中英文 PDF；
- `CITATION.cff`；
- `COPYRIGHT.md`；
- provenance links；
- GitHub ↔ Zenodo 双向导航闭环。

重点检查：

- 404；
- 错误 DOI；
- 错误版本；
- 错误作者；
- rights 冲突；
- candidate residue；
- 页面实际 clickable URL 与显示文本不一致；
- Release assets 与 frozen hashes 不一致；
- 登录后可见但公开用户不可见。

浏览器验收与 CLI/hash 验收解决的是不同问题，两者不能完全互相替代。

---

## 10. Git 安全规则

默认禁止：

- `git reset --hard`；
- `git clean -fd`；
- 自动 stash；
- force push；
- 已公开历史 rebase / rewrite；
- 移动或删除正式 tag；
- 删除后无痕替换 Release assets；
- 替换已发布 Zenodo frozen files；
- 为了“整洁”删除 provenance evidence。

如果发现本地有未提交修改，先判断来源和风险，不擅自覆盖。

---

## 11. ChatGPT / Codex / 作者职责

### ChatGPT

负责：

- 设计流程；
- 解释取舍；
- 读取 Static / Runtime；
- 形成验收标准；
- 独立 review；
- 识别 scope drift / evidence gap；
- 决定 PASS / PARTIAL / BLOCKED / FAIL；
- 在授权后维护 GitHub 文档。

### Codex

负责：

- 本地 Git preflight；
- 实际修改文件；
- 执行命令；
- 构建 PDF；
- 计算 hashes；
- 使用 `gh` / browser capability 做可重复验证；
- 记录真实命令与结果；
- 在明确授权范围内 commit / push。

### 作者 / Owner

负责：

- 产品与方法论最终意图；
- 主观内容选择；
- 账号与权限相关操作；
- Zenodo / GitHub 等需要 owner 权限的 UI 操作；
- 对正式版本是否发布作最终决定。

---

## 12. Blocked 与 repair iteration 规则

发现问题时不要直接覆盖旧事实。

推荐模式：

```text
ACTIVE
↓
发现 blocker
↓
BLOCKED / repair iteration
↓
记录 exact evidence
↓
最小修复
↓
targeted re-audit
↓
独立验收
↓
COMPLETE / PASS
```

如果旧执行方案被新证据推翻，应明确记录 supersession，而不是删除旧历史。

---

## 13. 快速决策表

| 修改类型 | 改 `main` | 检查双语 | README | CFF | PDF | Zenodo | 新正式版本 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| README 坏链 | 是 | 否 | 是 | 否 | 否 | 否 | 否 |
| 单语言 typo | 是 | 视情况 | 否 | 否 | 否 | 否 | 否 |
| 语义性 wording 修改 | 是 | 是 | 视情况 | 否 | 否 | 否 | 暂不 |
| related-work 事实修正 | 是 | 是 | 视情况 | 否 | 否 | 否 | 视累积变化 |
| 新增重要规则 | 是 | 是 | 是 | 发布时 | 发布时 | 发布时 | 通常是 |
| 新增 Case C | 是 | 是 | 是 | 发布时 | 发布时 | 发布时 | 通常 `v1.1` |
| 核心框架重构 | 是 | 是 | 是 | 发布时 | 发布时 | 发布时 | 通常 `v2.0` |
| rights policy 改变 | 是 | 是 | 是 | 是 | 是 | 是 | 应正式发布 |
| 新正式版本 | 是 | 是 | 是 | 是 | 是 | New version | 是 |

---

## 14. 维护笔记写入规则

后续作者可继续在本文档追加：

- 新发现的 GitHub / Zenodo 行为；
- 发布流程中的平台限制；
- Markdown / PDF pipeline 注意事项；
- browser audit 经验；
- 版本判断案例；
- 常见 blocker 与恢复方法；
- 新的同步规则；
- 可复用 Codex 操作模板。

维护笔记原则：

- 记录可复用规则，而不是复制完整 Runtime 历史；
- 必要时引用 exact commit / tag / DOI 作为案例；
- 不把未经验证的猜测写成长期规则；
- 若某条笔记上升为长期合同，应由作者明确决定是否同步到 Static；
- 若某条笔记只是当前任务状态，应留在 Runtime，而不是本文档。

---

## 15. 已确认维护案例

### 15.1 v1.0 README canonical repository 链接渲染缺陷

`v1.0` 发布后的 public-surface audit 发现：frozen `v1.0` tag 中的 `README.md` 使用裸 canonical repository URL，并用 trailing backslash 作为 Markdown 换行。GitHub renderer 将该反斜杠编码进实际链接，形成 `%5C`，点击后返回 404。

影响范围仅限该 README 中的冗余 canonical self-link；中英文正式文章、双语 PDF、`CITATION.cff`、GitHub Release explicit assets、Zenodo record/files、DOI、作者/版本/rights metadata 均不受影响。

处理结果：

- evolving `main` 在 commit `4ae67823a49e5e5600353eee54f29682ae262d80` 中将该裸 URL 改为显式 Markdown link；
- targeted browser audit 确认最终 URL 为 `https://github.com/smter6626/structured-llm-execution-framework`、HTTP 200、无 `%5C`、无 404；
- frozen `v1.0` tag 不移动，tagged README 保留原发布时状态；
- 不替换 Release assets，不修改 Zenodo frozen files，不为该非核心展示缺陷单独发布 `v1.0.1`。

该案例的维护结论是：**正式快照的不可变性优先于回写旧 tag 来消除辅助 landing-page 的非核心展示缺陷；当前 `main` 应修复用户入口，同时把 frozen snapshot 中的历史缺陷明确记录。**
