# 结构化约束驱动的 LLM 执行治理框架

> 面向长期 LLM 工作流的仓库原生治理方法：稳定合同、运行时状态与证据化迁移

作者：Yeming Dai

版本：1.2

Canonical repository：[smter6626/structured-llm-execution-framework](https://github.com/smter6626/structured-llm-execution-framework)

DOI：[10.5281/zenodo.21911982](https://doi.org/10.5281/zenodo.21911982)

Copyright © 2026 Yeming Dai. All rights reserved.

---

## 摘要

长期 LLM 工作可能跨越多个会话、执行 Agent、commit、artifact 与 Human 决策。在这种环境中，用持续演化的对话计划保存当前合同并不稳健；仅凭执行者的完成报告进行验收，也缺乏足够的证据基础。本文提出一套仓库原生执行治理方法，将稳定的 **Static** 合同与当前 **Runtime** 状态分离，并在需要时加入长期 **History**；同时分离 Human Owner、Review / Orchestrator LLM 与 Execution Agent，要求实质性状态迁移与可直接定位的证据建立关联。

v1.2 重点收紧了三部分语义。第一，独立审核必须同时具备独立证据访问、独立 verdict 形成，以及对现有证据是否足以验收的独立判断。第二，显式 supersession 用于区分“历史仍被保留”和“结论当前仍有效”。第三，文章明确区分 Observed Practice、Derived Methodology、Conceptual Positioning 与 Proposed Extension。两个 repository-backed Case 展示了这一方法：一个 Human-mediated 的求职运营工作流，用于治理继承事实、不可信岗位描述、Human Decision Gate，以及由 Executor 自检得出、随后被独立审核判定失效的 `PASS`；另一个软件发布工作流，用测试、打包审计、源码身份与下载后的 Release artifact 构成证据链。这些案例说明适用性与可追溯性，不构成对生产率或可靠性的受控因果估计。

---

## 范围与实现状态

本文描述的是一套**仓库原生执行治理方法**。它不是可通过 pip 安装的 SDK，不是 Agent runtime、编排服务或生产级多 Agent 平台。其核心抽象是文档职责、修改权限、证据化状态迁移、决策门与验收语义。

本文使用的实现证据来自 Human-mediated 的 Reviewer / Executor 工作流。Static / Runtime 分离、Git-backed evidence、task-local state、角色分离、Human Decision Gate、独立 artifact 审核与显式 supersession 都已有 repository workflow 证据。完全自主的 reviewer–executor 闭环、角色间自动 transport 与无人值守状态推进，可以作为兼容的设计方向；但 v1.2 不声称这些能力已经实现或经过评估。

本文区分 Observed Practice、Derived Methodology、Conceptual Positioning 与 Future Work / Proposed Extension；组件级 claim 与 evidence status 见 Appendix A。

---

## 一、问题来源

当 LLM 执行长期、多步骤任务时，风险不只来自单次回答是否正确。任务可能经历上下文重置、多个 Agent、Git branch、反复生成 artifact，以及语义随新证据变化的 Human 决策。此时，若干常见失效会转化为项目状态问题，而不仅是 prompt 问题。

**上下文丢失与压缩（Context Loss / Compression）。** 对话、日志、配置和中间产出持续积累。模型服务可能截断、总结或压缩旧上下文，执行者通常无法准确知道哪些细节仍然存在。因此，模型内部上下文不适合作为长期项目的权威状态存储。

**幻觉与继承事实漂移（Hallucination and Inherited-Fact Drift）。** 证据不完整时，模型可能自行补全缺口。后续步骤还可能从排版完善的文档或此前通过验收的 artifact 中继承该输出，并把它当成已经确立的事实。因此，即使后来的 Agent 没有主动发明内容，错误仍可能长期延续。

**约束漂移（Constraint Drift）。** 临时实现选择可能逐渐获得“原始要求”的地位；相反，稳定约束也可能在 Runtime 更新中消失。“owner 的硬性要求”和“当前尝试选择的实现”之间的边界因此变得不清楚。

**状态歧义与 supersession 失败（State Ambiguity / Supersession Failure）。** 某个方案或 artifact 可能在早期证据下通过，后来又被新证据推翻。Git 能保留两个状态的时间顺序，却不能自动告诉未来执行者哪个结论现在仍具权威性。若没有显式 invalidation，早期 `PASS` 或 `validated` 记录很容易被重新采信。

**跨任务污染与 provenance 丢失（Cross-Task Contamination / Provenance Loss）。** 新任务可能持续覆盖旧任务的计划与状态文档。旧任务的原始目标、最终状态和验收依据逐渐难以恢复，也就难以可靠判断一个 artifact 是在什么合同下产生的。

**Agent 自评盲区（Self-Verification Blind Spot）。** Execution Agent 往往参与实现方案与验证路径的选择。它可能真实执行测试并真诚得到 `PASS`，但所选择的 tool、fixture、extractor 或 acceptance interpretation 本身可能无法暴露实现中的缺陷。这并不必然意味着偷懒或伪造测试，而是一种 evidence-selection dependency。

**证据边界失效（Evidence-Boundary Failure）。** 执行报告作为叙述可能完全诚实，却仍不足以支持验收：对应 commit 可能尚未 push，Reviewer 可能拿到错误 artifact，外部状态可能没有进入仓库，或证据只被选择性提供。“Agent 说完成了”不能成为状态迁移规则。

这些问题有一个共同的结构特征：仅靠更好的 prompt 无法稳定处理。问题涉及信息生命周期、权限、证据身份与当前语义。因此，本方法把权威合同和状态外化，规定谁可以修改它们，并定义证据如何改变当前有效结论。

早期迭代曾用一份复合文档同时保存 requirements、详细计划与进度，结果在两个方向上失效：更新进度时会顺手改变 requirement；而提前细化所有未来步骤，又会迫使后续工作在缺少 evidence 时依据假设推进。由此得到的结论不是“未来步骤必须始终模糊”，而是：**已知约束与 evidence 可以尽早记录；依赖尚未出现的 evidence 的实现选择，则应保持未决，直到证据真正存在。**

---

## 二、设计原则

### 2.1 职责与权限分离

信息应按照职责、更新频率和修改权限分离。稳定合同与当前执行状态在物理上相互独立。同样的隔离也适用于 task：新的独立目标使用新的 task-local 文档对，而不是重写已完成任务的记录。

角色分离遵循同一逻辑。Owner 管真实意图与敏感事实；Reviewer 管验收与状态推进；Executor 在 Active Step 内管理实现。不同角色可以由不同工具承担，但工具身份不是理论核心。

### 2.2 约束前置，细节延迟

已经确认的目标、硬性边界、候选方案和验收标准，应在知晓时记录。依赖后续测量、artifact 或 owner decision 的实现选择，不应过早提升为合同。未来步骤即使已有详细信息，也不等于获得了执行授权。

### 2.3 Prompt 应保持简单

长期复杂度应由 repository 中的合同与状态承担，而不是每一轮临时 prompt。审核侧可以把 Human 已确认的意图、Static 约束、Runtime 状态与验收标准编译为当前唯一 Active Step 的执行指令。Human 需要能审核重要边界，而不必先成为 prompt engineer。

### 2.4 先有证据，再做迁移

实质性状态变化应由 Reviewer 可以独立定位的 evidence 支持，例如 commit、diff、test result、job、rendered artifact、hash、external-system observation 或显式 Human decision。执行报告可以帮助定位，但不能替代其描述的证据。

### 2.5 显式 Supersession

保留历史与保留当前真值是两个不同要求。新证据推翻旧结论时，旧记录可以继续作为 provenance 存在；但当前状态必须说明什么被 supersede、为什么失效，以及之后的执行由什么结论治理。

### 2.6 与风险匹配的工程强度

文档数量、审核深度、Git evidence 与 acceptance gate，应与失败成本、可逆性、持续时间、复现要求和状态复杂度匹配。低风险一次性 artifact 可能只需目标和关键约束；软件发布、数据转换、昂贵实验或长期仓库可能需要更严格的 evidence 与 state control。目标不是最大化流程，而是为实际风险提供足够结构。

---

## 三、文档与状态模型

核心模型由 Static 与 Runtime 构成；跨越多个阶段或任务的长期工作可以增加 History。三者都可以保存在 Git 中，但回答的问题不同。

### 3.1 Static：稳定合同

**职责：** 定义目标、范围、硬性约束、稳定输入、修改边界与验收标准。

**更新规则：** 只有当合同确实发生变化，并由 Human Owner 或合同明确委派的授权主体批准时，Static 才能修改。普通执行不得为了方便改写 Static。

**典型结构：**

```text
## Objective
[最终交付与预期结果]

## Hard Constraints
- [不得违反的边界]

## Authority and Approval
- [谁可以修改合同或批准敏感操作]

## Acceptance Criteria
- [验收所需证据]

## Stable Background
[跨执行阶段仍需保留的已确认上下文]
```

未确认 requirement 应继续显式保持未知，例如 `TO_CONFIRM` 或 `REQUIRES_OWNER_DECISION`；不能由模型自行补全后静默冻结。

### 3.2 Runtime：当前权威执行状态

**职责：** 记录已完成工作及其语义、当前唯一 Active Step、blocker、residual validation item 与后续大方向。Runtime 是当前状态文档，不是第二份 Git log。

**更新规则：** 当状态发生实质变化时更新 Runtime，例如 acceptance gate 通过或失败、blocker 出现或解除、新证据推翻结论、Human decision 消除歧义，或 Active Step 切换。

**Evidence-backed transition：** 实质性更新应指出触发它的 evidence，并解释语义变化。Git 回答“发生了什么、时间顺序如何”；Runtime 回答“现在什么具有权威性”。

**Supersession record：** 必要时，Runtime 应写明：

- 先前结论；
- 新 evidence 或 Human correction；
- 当前 verdict；
- 哪个旧 claim、artifact verdict、plan 或 assumption 被标记为 `SUPERSEDED`、`DEPRECATED` 或 `INVALIDATED`；
- 对应的 evidence locator。

**典型结构：**

```text
## Completed
- Step 1: [结果与 evidence locator]

## Active Step
### Step 2: [一个权威 Active Step]
- Objective:
- Inputs:
- Permitted changes:
- Required evidence:
- Acceptance criteria:

## State Transition
- Previous state:
- Evidence:
- Current state:
- Meaning:

## Superseded Decisions
- Previous conclusion:
- New evidence:
- Current verdict:
- Supersedes:

## Next Direction
- [已知方向；未决选择继续保持 conditional]
```

“通过但存在小问题”不意味着假装问题不存在，也不必自动阻塞整个任务。Runtime 可以推进，同时保留 residual validation item 和后续 gate。

### 3.3 History：可选的长期记录

History 记录跨 task 的里程碑式收口、阶段重新打开和方向变化，不应复制 Runtime 的步骤级细节。已完成 task 的 Static 与 Runtime 默认冻结；真正的新目标应获得新的 task-local 文档对。Owner 若重新打开旧 task，应把 reopen 及其原因记录为显式状态迁移。

### 3.4 冲突处理

没有任何一份文档永久覆盖其他所有文档，因为三者职责不同。执行前应同时读取 Static 与 Runtime，必要时再读取 History。

- Static 约束当前 task 的稳定合同；
- Runtime 说明当前进度、blocker 与显式 invalidation；
- History 在更长时间尺度上记录阶段和 task 的关闭状态。

如果 History 表明 task 已关闭，而旧 Runtime 仍显示 active，执行必须暂停并先解决状态冲突。若 Runtime 看起来与 Static 冲突，Executor 不应自行“修复”任一文档，除非合同规则明确授权。若 Runtime 已显式废止某个旧 Runtime verdict，后续 Agent 不得因为 Git 仍保留该记录就恢复旧 verdict。显式 supersession 管理当前 Runtime 语义，但不能静默取消 Static 中仍然有效的硬性约束。

---

## 四、角色与执行循环

### 4.1 Human Owner

Human Owner 确认真实目标、敏感事实、风险容忍度、主观偏好与稳定合同的变化。Human 不必参与所有机器可验证检查；但当证据无法确认真相、主观判断是任务本身的一部分、操作高风险或不可逆，或合同可能需要变化时，Human 必须参与。

### 4.2 Review / Orchestrator LLM

Reviewer 读取治理文档、协助澄清要求、把 Active Step 编译为执行指令、直接访问实际 evidence、形成验收 verdict，并在证据支持时推进 Runtime。它管理合同解释与证据充分性，但不能发明 owner 尚未提供的意图或事实纠正。

### 4.3 Execution Agent

Executor 实现当前 Active Step，操作工具，构建或编辑 artifact，运行 self-check，并使产出可被审核。它应准确报告 locator 与 limitation。默认情况下，它既不修改 Static / Runtime，也不充当自己的最终验收者。

职责边界可以压缩为：

```text
Human Owner 管真实意图与权威纠正。
Reviewer 管合同解释、证据充分性与验收。
Executor 在 active contract 内管理实现与执行。
```

### 4.4 Git 与 Artifact 作为证据边界

Repository 是角色之间共享的 evidence surface。Executor 可以写入 code、diff、report、test、hash 与 artifact locator；Reviewer 随后可以在不共享 Executor 内部上下文的情况下检查这些材料。因此，审核对复制日志或叙述性总结的依赖更低。

但 Git 是 evidence boundary，并不天然是 trusted boundary。Commit identity、branch stability、artifact identity、credential、external state 和 repository content 仍需要 implementation-specific control，详见 Threat Model。

Evidence governance 也不要求所有 artifact 都公开。可复用 system-layer code 可以公开，敏感 task artifact 可以保持私有。关键要求是：获得授权的 Reviewer 能访问形成 verdict 所需的证据，同时 public claim 不超过安全且可支持的抽象层级。[^privacy-boundary]

### 4.5 执行循环

```text
Step 0  一致性预检
        读取 Static + Runtime（必要时加 History）
        若合同、状态或阶段关闭信息仍冲突，则停止

Step 1  需求对齐
        Human 确认目标、敏感事实与必要选择
        Reviewer 通过授权路径记录合同或当前状态

Step 2  Active-Step 编译
        Reviewer 把唯一 Active Step 转换为有边界的执行指令
        明确 permitted mutation、evidence requirement 与 acceptance criteria

Step 3  执行
        Executor 实现、自检并暴露可定位 evidence
        未明确授权时不修改治理状态

Step 4  独立审核
        Reviewer 直接检查合同与 evidence，独立形成 verdict
        ├── 4.1 ACCEPTED
        │         → 推进 Runtime，激活下一步
        ├── 4.2 ACCEPTED WITH MINOR ISSUE
        │         → 推进；保留 residual validation item
        ├── 4.3 REJECTED
        │         → 给出有边界的 repair instruction；返回 Step 3
        └── 4.4 HUMAN DECISION REQUIRED
                  → 暂停状态推进；请求 owner 裁决
```

修复尝试可以记录为 Step i-a、i-b 等。若后续审核推翻此前的 `ACCEPTED`，Runtime 应记录 invalidation，而不是在缺少语义关系的情况下再追加一个新 verdict。

### 4.6 Independent Review：三个必要条件

独立审核不等于“第二个模型阅读第一个模型的总结”。它必须同时满足以下三项：

1. **独立 evidence access。** Reviewer 能直接检查合同、diff、test output、artifact、hash 或相关 external observation。Executor report 是定位辅助，不是 evidence boundary。
2. **独立 verdict formation。** Reviewer 根据这些 evidence 评估 acceptance criteria，而不是继承 Executor 的结论。
3. **对 evidence sufficiency 的独立判断。** Reviewer 可以判断 Executor 选择的测试或 extractor 是否足以挑战验收 claim，并在必要时选择不同验证路径。

第三项尤其重要。重复同一测试可以确认该测试可复现，却可能原样保留其 blind spot。只有当 Reviewer 能质疑什么才算充分 evidence、在合理时采用其他 tool 或 interpretation，并在更直接的 artifact-level evidence 发生冲突时 invalidate 旧 `PASS`，审核才具有真正的可证伪性。

独立性首先是 review process 的属性，而不是模型身份的属性。[^review-independence]

在本文报告的 deployment 中，GPT-5.6 Sol 承担 Reviewer，GPT-5.6 Terra 承担 Executor。[^review-capability]

更稳定的角色抽象是：

```text
Executor optimizes execution success.
Reviewer optimizes acceptance correctness.
```

### 4.7 Human Decision Gate

当现有 evidence 无法确认事实、需要提供主观意图或语气、稳定约束可能变化、操作敏感或不可逆，或执行与审核之间的分歧无法由证据解决时，循环应暂停。Reviewer 应暴露未决选择及其后果，而不是代替 owner 猜测。

---

## 五、Framework Invariants 与状态语义

以下 invariants 是对现有 protocol 的压缩总结，不是另一套状态机。

| Invariant | 工程语义 |
| --- | --- |
| **Single Active Step** | 正常执行时，一个 task 最多只有一个权威 Active Step。即使允许并行实现，结果仍需汇入同一个治理状态决策。 |
| **Static Mutation Authority** | 只有当合同确实发生变化，并由 Human Owner 或合同明确委派的授权主体批准时，才可改变稳定合同；Executor 不得自行推断或扩大该权限。 |
| **Evidence-Backed Transition** | 实质性 Runtime transition 必须引用可外部定位的 artifact evidence 或显式 Human decision。 |
| **Supersession Persistence** | 结论一旦被显式 supersede，即使它仍存在于 Git 或旧 artifact 中，也不会恢复当前有效性；重新打开需要新 evidence 或 authorization。 |
| **Task-Local Freeze** | 已完成 task 的治理文档默认冻结。新目标使用新的 task-local state，除非 owner 明确 reopen 旧 task。 |
| **Reviewer Evidence Access** | 最终 acceptance 不能只依据 executor self-report；Reviewer 必须能够检查该 acceptance claim 所要求的 evidence。 |

这些 invariants 约束权限和语义，而不绑定实现技术。团队可以人工执行，也可以通过 repository check 或未来 orchestration service 执行。

---

## 六、机制层解释：为什么这种结构可能有帮助

以下内容是从已观察工作流中抽象出的机制解释，不是受控因果结论。

**收窄约束空间。** 稳定合同使 requirement 更少在实现过程中被临时重新解释。模型仍可能误解合同，但不必只依赖长对话重新构造合同。

**外化权威状态。** Static 与 Runtime 使后续会话能够从 repository artifact 恢复预期合同和当前状态。这为上下文重置后的 trace-back 提供基础。

**集中局部执行上下文。** 唯一 Active Step 为 Executor 提供有边界的 objective、permitted mutation surface 与 acceptance target。未来选择可以被记录，但依赖缺失 evidence 的决定继续保持 conditional。

**显式 supersession。** 被 invalidated 的结论可以保留 provenance，同时不再拥有当前 authority。这处理了 Git chronology 本身无法消除的一类语义歧义。

**独立 evidence challenge。** 直接访问 evidence 的 Reviewer 不仅能检查 Executor 是否运行了测试，还能判断这些测试是否支持 acceptance claim。这为推翻真诚的 self-`PASS` 提供路径，而不把分歧处理成模型投票。

**Proportional rigor。** 让治理开销与风险匹配，可以避免方法本身变成交付物。更强证据链用于 stateful 或高成本工作；简单任务则使用更小子集。

**在不可约边界设置 Human Gate。** 只有 owner 知道的事实、主观 motivation、policy decision 和高风险操作，不应为了维持自动循环而被转换成模型猜测。

---

## 七、Case Study

两个案例刻意覆盖不同的治理强度。Case A 展示长期、多角色、状态持续变化的工作流中较高强度的用法；Case B 展示较低 ceremony 的 proportional subset，在风险更集中时只采用覆盖主要风险所需的治理结构。

以下案例按 **Observed Problem → Governance Intervention → Observed Outcome** 组织。它们说明该方法可以与真实执行共同运行，并保留可审核 evidence；它们没有把方法本身隔离为因果 treatment，因此不能证明生产率、可靠性或成本改善。[^observational-evidence]

### 7.1 Case A：求职运营 Agent 工作流中的执行治理

#### 运行结构与 evidence boundary

本案例来自一个持续运行的求职运营工作流：在受控 candidate-fact baseline 下分析岗位描述并生成 application artifact。实际结构为：

```text
Human Owner
→ Review / Orchestrator LLM
→ Execution Agent
→ Git 与 artifact evidence
→ independent review
→ Runtime state transition
```

Human 管真实求职目标、敏感事实、主观选择与 approval boundary；Reviewer 管合同、事实与 artifact evidence 检查、验收及状态推进；Executor 执行当前 implementation，包括在授权范围内获取来源、分析、生成与渲染 artifact、运行测试和操作 repository。Public system code 与 private candidate artifact 分离，但 Reviewer 仍可在授权后的共享 evidence boundary 内验收。

这是 Human-mediated 的 supervised review–repair workflow，不是自主多 Agent 服务。Executor report 可以帮助定位 evidence，但不能验收自己的产出。

#### 继承事实纠正 → Human Gate → supersession

**Observed Problem。** 一份历史候选人 profile 包含过度具体化的教育凭证表述。由于该 profile 外观上具有权威性，并且已经被早期 artifact 使用，Executor 继承了这一 claim，而不是重新发明一个新 claim。独立审核发现现有 evidence 不足以支持原表述；Reviewer 也没有权限猜测正确替代内容。

**Governance Intervention。** 该问题进入 Human Decision Gate。Owner 提供权威纠正，active candidate baseline 被收窄为该纠正所支持的表述。历史 artifact 继续作为 provenance 保留，但旧 claim 被显式标记为 historical-only 与 superseded。当前状态规则禁止后续 Executor 仅因为旧 resume、commit 或早期 `PASS` 仍含该 wording，就重新恢复它。

**Observed Outcome。** Active material 与后续生成的 artifact 使用了收窄后的事实。Repository 保留旧记录的时间顺序，Runtime 则声明该记录不再是 current truth。这个事件展示了 inherited-fact drift、仅 owner 能提供的事实权限，以及“保留 provenance”与“授权重新使用”之间的区别。

#### 外部岗位描述是不可信 optimization input

**Observed Problem。** 一次真实岗位 smoke test 的 desirable qualification 超出了候选人的 direct evidence。Tailoring system 有提高词面 overlap 的优化动机，但把这些 requirement 复制进 candidate baseline，会把 employer request 变成 candidate claim。

**Governance Intervention。** 工作流把外部岗位描述视为 untrusted optimization input。它可以影响 qualification analysis、evidence selection 与 tailoring，但不能修改 candidate fact。审核明确区分 **direct evidence**、**transferable evidence** 与 **gap**。可迁移的 engineering 或 documentation experience 继续标为 transferable；不存在的 enterprise tool 或 responsibility 继续保留为 gap。Education、experience type 与其他敏感事实不能为了提高表面匹配度而改变。

**Observed Outcome。** 已完成的 smoke test 给出 conditional route，并生成 tailored artifact；其中较窄的 claim 通过了适用 fact check 与工作流内的独立审核。[^case-a-evaluation]

#### 主观意图的简短 Human Gate

求职信中的事实可以来自 approved evidence，但对岗位的 motivation 与 tone 不能安全地从 JD 或 resume 推断。因此，finalization 暂停等待 owner input 和 approval；之后才完成 source、PDF 与审核侧独立验收。敏感 application answer 与最终提交继续处于 autonomous generation 之外。

#### Executor self-`PASS` → Reviewer overturn → invalidation

**Observed Problem。** Execution Agent 生成最终 PDF artifact，并完成视觉检查与 reading-order verification。页面视觉顺序正确；Agent 选择的 extraction path 看起来也保留了预期顺序，因此 Agent 真诚报告 `PASS`。

Independent Reviewer 直接取得同一 PDF，并选择不同的 text-extraction path。该 extractor 显示两个正文内容块在 PDF content stream 中被移动到了签名之后。视觉 layout 没有问题，但 semantic reading order 不满足 robust acceptance。矛盾存在于 artifact 本身，不需要假设 Agent 没有测试或伪造报告。

**Governance Intervention。** Reviewer 判断旧 evidence 不足以支持 acceptance claim，并 invalidate 原 reading-order `PASS`。旧 PDF、report 与 verdict 继续作为 historical evidence 保留；Runtime 则把该 acceptance claim 标记为 `INVALIDATED`。随后进行最小 renderer repair，使正文恢复 ordinary content flow。修订后的 PDF 通过视觉检查与多条 extraction path 复核后，才获得新的 `PASS`。

**Observed Outcome。** Repaired output 消除了 artifact-level contradiction，current state 指向修订后的 evidence，而不是历史 verdict。更重要的是，该事件收紧了 independent review 的定义：Reviewer 必须能够独立判断什么 evidence 才足够，而不只是重复 Executor 选择的测试。

即使 self-verification 真实且诚实，implementation choice 与 evidence-path selection 仍可能在同一执行角色内相关；独立 Reviewer 对 evidence sufficiency 的判断使旧 `PASS` 可以被证伪。

#### 支持性状态语义

另一个 layout observation 被判断为 non-blocking：workflow 继续推进，同时 Runtime 保留页面利用率 residual issue。已经知道的 acceptance constraint——例如必须保留 text extraction 与 reading order——立即被记录；尚未测试的 layout redesign 则继续保持未决。这是“约束前置，细节延迟”的实际含义：保留已知边界，不猜测实现方案。

本案例还说明 evidence governance 与隐私隔离可以同时成立。Public system-layer change 可以公开审核，candidate-specific source 与 application artifact 则保持私有，只在授权边界内检查。为了支持机制级叙述，不需要把任何敏感 artifact 复制进公开方法正文。

### 7.2 Case B：AudioShifter 软件发布与 artifact identity

Case B 展示较低 ceremony 的治理方式。本文报告的 bounded macOS Release task 不需要 Case A 那样的多角色状态循环；治理重点集中在稳定的 platform / product 约束、必要的 owner decision，以及 build、package 与 Release artifact identity。

Case B 来自 [AudioShifter](https://github.com/smter6626/AudioShifter)。该 macOS 应用从作者自有历史原型重新构建，而早期 macOS 源码已不可用。任务的产品边界稳定，但 release identity 风险较高：开发机上运行的 code、实际 package、tag 对应 source 与 public Release asset 必须指向同一个可审计产品。

**Human input remained lightweight.** 在这个案例中，Human 的任务级 prompt 主要是直接要求完成当前工作，并在完成后进行验收；Human 并没有逐项指定后续验证体系中的具体工程检查。最终验收也没有停留在一句泛化的“检查完成”，而是具体落到了后文记录的 `165 passed, 0 failed, 0 skipped`、75 个 thin-arm64 Mach-O、324 条 dynamic reference、20 个 `LC_RPATH`、corresponding source 与 checksum、非开发机验收，以及三项 public Release asset 的 download-back verification。通俗地说，Human 输入的 prompt 很简陋，但执行过程并没有停留在 prompt 的字面粒度，而是实际采用了明显更规范、更工程化的工作方式。[^case-b-engineering-emergence]

**Observed Problem。** Development environment dependency 可能让本地 build 看似自包含，而真正 package 并非如此。技术上接近完成的候选版本还遇到一个 owner policy 问题：项目许可证选择无法由 executable test 决定。

**Governance Intervention。** 治理强度围绕实际风险配置，而不是机械展开整个 Framework：Static 保存稳定 platform 与 product contract，同时不声称未经测试的 compatibility；Runtime 记录 implementation、packaging、owner decision 与 release state；许可证问题在需要时进入 Human Decision Gate，而不是由 Agent 补全。Release tooling 从 tagged detached worktree 重新 build，生成 corresponding-source 与 checksum artifact，审核 package，并对从 Release surface 下载的 asset 重复验证。

**Observed Outcome。** 公开的 [`v0.1.0-alpha.3` verification record](https://github.com/smter6626/AudioShifter/blob/main/macos/release/release_verification_v0.1.0-alpha.3.md) 记录了 `165 passed, 0 failed, 0 skipped`；对 75 个 thin-arm64 Mach-O、324 条 dynamic reference 与 20 个 `LC_RPATH` 的审计；checksum file 与 corresponding-source package；非开发机验收；以及三项 public Release asset 的 download-back verification。这些记录建立了该 Release 的 artifact evidence chain。

Case B 展示了这套方法较低 ceremony 的一端：治理结构可以随 failure cost、state persistence 与 artifact-identity risk 调整。这里不需要独立 History，也不需要 Case A 那样的多角色治理强度；Static、Runtime、必要的 Human Gate 与 Release evidence 已经覆盖这个 bounded task 的主要风险。Case A 展示高状态复杂度下的强治理，Case B 展示风险较集中时的 proportional subset。

---

## 八、适用边界与误用风险

### 8.1 适用场景

本方法更适合可阶段化、可检查，并且状态或 evidence 需要跨越单次对话保存的工作，例如 code change、文档生产、repository maintenance、data transformation、experiment execution、packaging、release engineering，以及其他具有明确验收条件的 workflow。

| Task 特征 | 可能采用的工程强度 |
| --- | --- |
| 一次性、可逆、失败成本低 | Goal + key constraints |
| 多步骤但容易人工检查 | Static + simplified Runtime |
| Code、data、artifact 或 Release work | Static + Runtime + artifact review |
| 长期、高成本、高复现要求 | Task-local Static / Runtime + optional History + strong evidence gates |

任务标签本身不是决定因素。短期 production migration 可能需要严格控制；低风险脚本则未必需要。

### 8.2 不适合完整套用的场景

当初始化与审核成本高于任务风险、工作无法划分为有意义的验收阶段、结果持续依赖主观 Human judgment，或 external state 变化快于 checkpoint / direct inspection 的捕获速度时，完整方法并不合适。

### 8.3 误用风险

**把发明的 requirement 冻结为合同。** 将 unknown 当作事实写入 Static，会把早期推测变成稳定错误。

**让 Runtime 失去时效。** 如果状态变化绕过 Runtime，或旧 `PASS` 缺少语义限定，双文档结构本身不会自动解决问题。

**只读取一份治理文档。** 只读 Static 会丢失当前 state；只读 Runtime 可能把 contract violation 正常化；两者都读但忽略相关 History，则可能重新打开已关闭阶段。

**把 Runtime 写成第二份 Git log。** Runtime 应保存当前语义和 evidence locator，而不是叙述每条 command 或 commit。

**让 Executor 同时修改并验收合同。** 如果同一角色能重写 requirement、实现、选择 evidence 并宣告 final acceptance，权限边界就已经失效。

**把模型数量误认为独立性。** 两个只共享 Executor summary 的模型仍共享同一个 evidence boundary。反过来，不同 vendor 也无法弥补缺失的 artifact access。

**公开所有 evidence。** 可审核性不要求暴露 private、regulated 或 personally sensitive artifact。Access control 与 public claim minimization 仍然必要。

**机械采用最高强度。** 治理开销可能超过 task value，并遮蔽真正 deliverable。方法应被主动缩减。

**从成功项目推断因果收益。** 一个带有 test 与 review 的项目成功完成，只能说明 compatibility 与 traceability，不能说明没有该方法时会发生什么。

---

## 九、Threat Model

**Git 可以作为 evidence boundary，但并不天然是 trusted boundary。** 本方法只能部分结构化 evidence handling，不能替代 repository security、identity 或 deployment control。

| Threat | 当前方法层缓解 | Residual risk 或实现责任 |
| --- | --- | --- |
| 文档、issue、diff 或 artifact 中的 repository prompt injection | 把 repository content 当作待评估 evidence，而不是自动具有 authority 的指令；保留角色与修改边界 | Content sanitization、tool isolation、least privilege 与 model-specific defense 仍是实现责任 |
| Executor credential 被攻破 | Reviewer 独立形成 verdict，并可要求 signed 或 reproducible evidence | Credential protection、branch protection、signing 与 incident response 不属于文档方法本身 |
| Mutable branch 或 HEAD drift | 为已审核状态记录 commit、tag、hash 或 artifact identity | Pinning、immutable storage、protected refs 与 CI policy 需要实现层强制 |
| Review-time race | 对 pinned commit 或 hashed artifact 审核，并在 Runtime 记录 locator | Atomic snapshot 与 concurrency control 需要实现支持 |
| 错误或 stale artifact | 将 acceptance claim 绑定到明确 artifact hash、build、tag 或 download source | Build provenance 与 artifact-store integrity 属于系统责任 |
| Reviewer / Executor correlated failure | 分离 context、objective、evidence access 与 verdict formation；允许不同 evidence path | 共享模型、infrastructure 或 assumption 仍可能共同失效；多样性与 adversarial review 仍待评估 |
| Git 未捕获 external state | Repository evidence 不足时，要求直接 external observation 或显式 Human evidence record | Connector、freshness guarantee 与 capture integrity 依赖部署 |
| Evidence 不完整或被选择性提供 | Reviewer 判断 sufficiency，可以要求补证或拒绝 transition | 本方法无法保证发现被故意隐藏的 evidence |

因此，本方法只能部分缓解 semantic confusion 与 self-report dependence；它不声称解决 credential compromise、恶意 repository、安全 provenance 或所有 correlated model failure。更强的 identity、isolation 与 adversarial-review mechanism 属于实现责任与 Future Work。

---

## 十、局限与评估计划

### 10.1 当前局限

本文案例是 observational case，并因 repository 或 artifact evidence 可用而被选中；方法没有被隔离为 treatment，也没有建立 counterfactual baseline。[^observational-evidence]

当前证据不建立量化 process benefit、comparative superiority，或 fully autonomous orchestration 的 reliability / advantage。

Repository case 还可能受到作者熟悉度、选择偏差、task-specific tooling 与高参与度 Human Owner 的影响。Git 中的 evidence 可能遗漏相关 external state；Reviewer 与 Executor 可能共享 correlated assumption；显式治理文档本身也可能过时、错误、恶意或维护成本过高。

### 10.2 Evaluation Plan

未来评估可以在 matched task 上比较以下条件：

```text
Baseline
单一 evolving plan 与 conversational state

Treatment
Task-local Static + Runtime + evidence-backed transitions
```

比较前应预先定义 acceptance criteria、task class、model/tool configuration、Human intervention rule，以及如何引入 state reset。候选指标包括：

| 指标 | 可操作化问题示例 |
| --- | --- |
| Frozen-constraint violation | 输出违反已确认 hard constraint 的频率是多少？ |
| Stale superseded-decision reuse | 已显式 invalidated 的 claim 或 route 被恢复的频率是多少？ |
| Context reset 后恢复 | 从 verified state 恢复需要多少时间与 Human correction？ |
| Human correction count | Owner 需要纠正 fact、scope 或 intent 多少次？ |
| Reviewer rejection 与 rework | 每个 completed step 需要多少个 acceptance cycle？ |
| Executor false-`PASS` 被 Reviewer 推翻 | Independent artifact review 推翻 self-verification 的频率是多少？ |
| Context 与 token use | 达到 accepted completion 需要多少 context 与 token？ |
| Repeated / unnecessary work | 因 state 或 evidence 不清而重复多少执行？ |
| Completion latency | 包含 review overhead 后，accepted task completion 用时多久？ |

任何结果都应区分 artifact quality 与 process cost，并同时报告失败与成功。Token 更少、步骤更少或完成更快，只有在最终输出仍满足同一 acceptance criteria 时，才能算作改善。本版本没有执行这些实验；该表是一条可证伪的评估方向，不是收益证据。

---

## 十一、Related Work and Conceptual Positioning

以下内容基于公开论文与官方文档，用于比较不同方法管理的 semantic layer；属于 conceptual positioning，而不是 empirical superiority test。[^related-work-scope]

**Chain-of-Thought 与 ReAct。** [Chain-of-Thought prompting](https://arxiv.org/abs/2201.11903) 在模型任务内部引出中间推理步骤；[ReAct](https://arxiv.org/abs/2210.03629) 则在交互轨迹中交错 reasoning 与 action。二者都可以运行在某个 Active Step 内。本文治理方法关注的是跨 execution 保存的外层 project semantics：稳定约束、当前已验收状态、evidence identity 与 supersession。

**Spec-driven development。** [GitHub Spec Kit](https://github.com/github/spec-kit/blob/main/docs/index.md) 的官方文档给出默认 `Spec → Plan → Tasks → Implement` 流程；[Kiro Specs](https://kiro.dev/docs/cli/v3/specs/) 则生成 requirements、design 与 task artifact，并包含 execution phase。这些系统用于外化开发意图与计划。Static / Runtime / History 按信息稳定性、修改权限与时间尺度分类，因此可以与 development-phase workflow 叠加，而不需要替代它。

**Context engineering 与 repository instruction file。** Context engineering 关注推理时应该提供和维护什么信息。官方文档分别描述了 [Codex `AGENTS.md`](https://learn.chatgpt.com/docs/agent-configuration/agents-md)、[Claude Code `CLAUDE.md`](https://code.claude.com/docs/en/memory) 与 [Kiro Steering](https://kiro.dev/docs/steering/) 的 repository / workspace guidance；[Anthropic 对 context engineering 的讨论](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) 将 context 视为需要策划的有限资源。这类文件可以保存 convention、architecture 与 instruction。本文方法则让稳定合同、当前状态和可选长期历史具有不同 mutation semantics，而不是把所有 repository context 视为同一类信息。

**Agent orchestration 与 runtime state。** [LangGraph persistence](https://docs.langchain.com/oss/python/langgraph/persistence) 描述了 checkpointed graph state；[OpenAI Agents SDK](https://developers.openai.com/api/docs/guides/agents) 官方文档覆盖 agent loop、state、handoff、guardrail、tracing 与 approval flow；[AutoGen](https://microsoft.github.io/autogen/) 提供构建 single-agent 与 multi-agent application 的 AgentChat / Core abstraction。这些 framework 管理可执行 Agent 与 application state。Repository-native governance 可以位于该层之上或旁边，记录哪个 project contract 当前有效、什么 evidence 允许推进，以及哪个旧 verdict 已经失效。未来 autonomous implementation 可以使用这类 runtime infrastructure，但 runtime library 本身并不等于本文方法。

**传统 SOP 与 project documentation。** Requirement document、SOP、task list、decision record 与 project log 都可以 version control 和动态更新。本文提出的区别是明确的责任与权限组合：`Static contract → Runtime state → evidence-backed transition → optional History`，再加上显式 acceptance 与 supersession semantics。这是对既有 artifact 的方法性组织，不是声称传统 project documentation 天生静态或不兼容。

---

## 十二、结论

仓库原生执行治理把长期 LLM 工作视为合同、状态、权限与 evidence 问题，而不仅是 prompting 问题。Static 保存稳定合同；Runtime 说明当前什么具有权威性；可选 History 保存长期阶段收口；task-local freeze 防止后续任务抹去旧 provenance；supersession 则把 historical truth 与 current validity 分开。

v1.2 的核心升级主要是认识论层面的，而不是增加更多架构组件：independent review 需要直接 evidence access、独立形成的 verdict，以及对 evidence 是否充分的独立判断。求职运营 PDF 事件说明了第三点为什么重要，并展示持续状态与多角色工作流中较高强度的治理；AudioShifter Release Case 则展示风险集中在 package 与 release identity 时，同一方法可以采用较低 ceremony 的 proportional subset。

现有 evidence 支持本文所报告 Human-mediated workflow 的 applicability、traceability 与 evidence-preserving execution；它不支持量化收益或 autonomous-orchestration claim。明确这些边界本身就是方法的一部分：一个稳定的执行框架不仅要记录什么被认为有效，也应记录什么仍未实现、未测量，或继续依赖 Human judgment。

---

## Appendix A — Claim 与 Evidence Status

### A.1 Component Status

| 组件或主张 | v1.2 中的状态 |
| --- | --- |
| Static / Runtime 分离与 task-local state | Observed Practice；同时被抽象为 Derived Methodology |
| Git-backed 状态迁移证据与 artifact review | Observed Practice |
| Human / Reviewer / Executor 角色分离 | Observed human-mediated workflow |
| Human Decision Gate 与显式 supersession | Observed Practice；同时属于 Derived Methodology |
| Independent Review | Observed Practice；包含独立 evidence access、独立 verdict formation 与对 evidence sufficiency 的独立判断；定义由 artifact-level contradiction 进一步收紧 |
| 与 specification、context file 和 Agent runtime 的定位 | 基于文档与论文的 Conceptual Positioning |
| 完全自主的 reviewer–executor 编排 | Future Work / Proposed Extension；在本文报告的 evidence 中尚未实现或评估 |
| 量化的生产率、token、延迟、failure rate 或 reviewer catch-rate 改善 | Not established |

### A.2 Outcome Claims Not Established in v1.2

v1.2 尚未建立以下 outcome claim：

- 生产率或 accepted task completion time 的百分比变化；
- failure rate、frozen-constraint violation 或 stale-decision reuse 的变化；
- token saving 或 context-size saving；
- context reset 后恢复更快；
- Human correction 或 repair iteration 更少；
- Reviewer catch rate，或 Reviewer capability 对该比例的影响；
- 相比单一 evolving plan、conversational state 或 Agent runtime 的 superiority；
- fully autonomous orchestration 的 reliability 或 cost advantage。

---

最后更新：2026 年 8 月

[^observational-evidence]: 本文案例是 observational cases，并因具有可用的 repository 或 artifact evidence 而被选中。由于该方法没有被隔离为 treatment，也没有建立 counterfactual baseline，这些案例不能支持关于量化 process benefit、comparative superiority 或 autonomous-orchestration advantage 的因果结论。v1.2 尚未建立的 outcome claim 完整清单保存在 Appendix A.2。

[^review-independence]: 这里的独立性是 review process 的属性，不是 statistical independence 或完全 epistemic independence 的主张。只要 context、objective、直接 evidence access、verdict formation 与对 evidence sufficiency 的判断相互分离，就不要求不同 vendor、model family、account 或 infrastructure。反过来，如果 Reviewer 只看到 Executor summary，或继承其 acceptance judgment，即使模型身份不同也不构成独立审核。共享模型、基础设施、假设或 evidence source 仍可能产生 correlated failure。

[^review-capability]: GPT-5.6 Sol 作为 Reviewer、GPT-5.6 Terra 作为 Executor，是本文案例中的实际 deployment configuration，不构成模型能力排序，也不是 Framework requirement。v1.2 没有建立两个模型之间的一般能力差异，也没有测量 Reviewer capability 对 catch rate 的影响。Framework 要求的是独立 evidence access、独立 verdict formation 与独立的 evidence-sufficiency judgment，而不是某个特定模型组合。

[^case-a-evaluation]: 该岗位描述工作流的 observed outcome 只支持一个较窄命题：生成的 candidate claim 在该工作流内通过了适用的 fact check 与 independent review。它不测量 ATS ranking、hiring-prediction accuracy、雇主决策、申请成功率或简历 tailoring 的一般化质量。

[^related-work-scope]: 除非段落另有明确说明，这些比较均基于公开论文与官方文档，用于定位 semantic scope；它们不是 hands-on production integration study、head-to-head benchmark 或 empirical superiority test。被引用的系统通常管理不同层级，并可能与 repository-native governance 组合使用。产品行为也可能在所引文档之后变化，因此比较只覆盖支撑当前定位的 documented capability。

[^privacy-boundary]: Evidence boundary 可以是私有的。可审核性要求获得授权的 Reviewer 能检查形成 verdict 所需的 evidence，但不要求公开 candidate-specific、personally sensitive、regulated、credential-bearing 或其他 confidential artifact。Public claim 应停留在 private evidence 能安全支持的抽象层级，access control 仍然适用。

[^case-b-engineering-emergence]: 这里描述的是本案例中实际观察到的 Human input 与 execution structure 之间的差异，不是“简单 prompt 必然产生规范软件工程”的因果主张，也不表示系统在缺少约束、审核或 evidence requirement 时会自动采用适当的 engineering practice。“更规范、更工程化”仅指本案例中实际形成且有 repository / artifact evidence 支持的 testing、packaging validation、Release verification 与 evidence-chain structure；它不建立生产率、可靠性、质量提升或相对其他开发方式的 superiority claim。
