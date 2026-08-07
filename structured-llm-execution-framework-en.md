# Repository-Native Execution Governance for Long-Running LLM Workflows

> A Structured Constraint-Driven Framework for Durable Contracts, Runtime State, and Evidence-Backed Transitions

Author: Yeming Dai

Version: 1.0 candidate

Canonical repository: https://github.com/smter6626/structured-llm-execution-framework

Copyright © 2026 Yeming Dai. All rights reserved.

---

## Abstract

This article documents an LLM execution framework iteratively validated in real projects. Its central idea is not to optimize prompt wording, but to constrain an LLM's freedom during execution through **separation of document responsibilities** and **fixed role boundaries**. This structural approach systematically improves output quality and predictability without making either depend on the quality of any single prompt.

---

## 1. Problem Origin

When a single LLM executes a multi-step task, two failure modes are common:

**Hallucination Drift:** When context is insufficient, an LLM tends to fill in missing details on its own. In a multi-step task, hallucinations introduced early are inherited and amplified by later steps, eventually moving the output away from the original requirements.

**Constraint Drift:** While executing a dynamic task, an LLM may modify the original constraints without recognizing that it has done so. When the task description and execution state share the same context, the boundary between "how this should be done" and "what was originally required" gradually becomes blurred.

Early versions of the framework used a single composite document to record project goals, the step-by-step plan, and execution state. In practice, this exposed failures in two directions:

- **Contamination of the static portion:** While updating execution state, the LLM would also modify the original requirements, allowing hard constraints to change quietly.
- **Over-constraining of the dynamic portion:** Every step was planned in detail at the start of the project, even though later steps depended on outputs from earlier ones. Locking in details too early forced the LLM to proceed from assumptions, concentrating hallucinations in those later steps.

Both problems have the same root cause: **one document cannot simultaneously serve the opposing needs of stability and change**.

---

## 2. Design Principles

The framework is organized around four principles derived from these failure modes.

**Principle 1: Separation of Concerns**

Documents are classified strictly by update frequency and modification authority. The document that describes "what to do" is physically separated from the document that describes "how far the work has progressed," and the LLM has different modification authority over each.

**Principle 2: Constraints First, Details Late**

Stable constraints are written once when the project begins. Implementation details for a later step are not planned in depth until that step becomes active. This avoids premature planning based on assumptions.

**Principle 3: Prompts Should Be Dumb**

The framework's complexity resides in the document structure, not in the prompt. Ideally, the prompt that triggers the next LLM action should be simple enough for anyone to write, for example: "Codex has finished and reported the following... Please inspect and verify the repository, then decide whether to advance." The framework's robustness therefore does not depend on prompting technique.

Case B also provided an unplanned practical illustration of this principle. The user simply described real constraints: the source code had been lost, the intended user was not comfortable operating a computer, and a cross-platform rebuild was needed. The user did not ask for a "software engineering process." The LLM derived the Static / Runtime structure from those constraints, and the subsequent work naturally developed into an auditable software delivery chain.

**Principle 4: Proportional Rigor**

The framework does not require the same level of engineering control for every task. The number of documents, acceptance gates, independent checks, degree of Git tracking, and frequency of Runtime updates should be proportional to failure cost, reversibility, task duration, reproducibility needs, and state complexity. Tasks such as code implementation, research experiments, data processing, and long-term repository maintenance warrant strict use of Static / Runtime documents, explicit acceptance gates, and verification against actual repository artifacts when an error could contaminate later steps, incur substantial compute cost, or need to be reproduced across sessions. Tasks such as slide decks, speeches, one-off copy, and low-risk content organization may retain the goal and key constraints while using fewer state documents, Git gates, and staged reviews, so that the framework's management cost does not exceed the task's value.

The objective, then, is not to maximize engineering rigor. It is to **use enough structure to constrain uncertainty where the uncertainty creates real risk, while minimizing the engineering cost required to reach the needed level of reliability**.

---

## 3. Document Structure

The framework uses two core documents, with an optional third document for long-running projects. All are stored in a Git repository.

### 3.1 Static Document (Durable Contract)

**Responsibility:** Describe what remains fixed: project goals, requirements, constraints, and acceptance criteria.

**When to update:** Only when the project's overall direction or core requirements change. It is not touched during routine execution.

**Modification authority:** The Static document should not be modified incidentally during an ordinary execution step. An LLM may update it only when the user explicitly authorizes the change, the task contract has genuinely changed, and the reason for the modification is recorded.

**Typical contents:**

```text
## Project Goal
[One-sentence description of the final deliverable]

## Hard Constraints
- [Limits that must not be violated, such as technology stack, format, or deadline]

## Acceptance Criteria
- [Specific acceptance conditions for each deliverable]

## Background
[Stable context needed by the LLM during execution]
```

### 3.2 Runtime Document (Current Execution State)

**Responsibility:** Track execution state. Record completed steps and their results, describe the sole current active step in detail, and give only a broad direction for subsequent steps.

**When to update:** Whenever execution state changes materially—for example, when an acceptance gate passes or fails, a blocker appears or is resolved, the active step changes, the project enters a new phase, or evidence invalidates the current plan. An update may be confirmed manually by the user or written back through an automated API. What matters is that updating Runtime is part of the execution loop.

**Key design:** Steps after the active step retain only a broad direction and are not planned in detail. Their details are expanded only when each step becomes active. By then, outputs from prerequisite steps are known, so planning can use real context rather than assumptions.

**State Transition Evidence:** For a meaningful Runtime update, the framework recommends recording the commit, PR, job, artifact, or other locatable evidence that triggered the state change, together with one or two sentences explaining what that evidence means for the current state. This is not a duplicate of the full Git history. Git history answers "what happened, and in what order?" Runtime answers "what state did those changes produce?"

**Decision Supersession:** Runtime should record not only the new correct state, but also, when needed, which earlier conclusions are no longer valid. In a long-running task, a plan may pass an acceptance gate under early evidence and later be overturned by a new experiment, bug, resource test, or owner clarification. Recording only the new plan is insufficient, because an old commit, Runtime snapshot, or historical note may still contain conclusions such as `PASS`, `validated`, or `recommended` that were correct at the time but are no longer valid.

When new evidence overturns a previous conclusion, Runtime should explicitly record:

- the previous conclusion;
- the new evidence that overturned it;
- the current conclusion;
- the old records, plans, or assumptions now marked `SUPERSEDED`, `DEPRECATED`, or `INVALIDATED`; and
- the corresponding commit, PR, job, or artifact evidence.

The purpose is not to turn Runtime into a second Git log, but to establish a **semantic invalidation relationship**. Git history provides chronology; Runtime provides current semantics.

**Typical structure:**

```text
## Completed
- Step 1: [Description + result summary] ✓
- Step 2: [Description + result summary] ✓  [2026-06-20 14:23]

## Active Step
### Step 3: [Detailed description]
- Concrete objective:
- Inputs:
- Expected output:
- Acceptance criteria:
- Known dependencies:

## State Transition
- Evidence: commit `abc1234` / job `12345678` / artifact `[path]`
- State change: [ACTIVE → COMPLETE / BLOCKED → ACTIVE / plan A → plan B]
- Meaning: [What this evidence means for the current execution state]

## Superseded Decisions (only when needed)
- Previous conclusion: [Earlier conclusion]
- New evidence: [Evidence that overturned it]
- Current verdict: [Current authoritative conclusion]
- Supersedes: [Earlier Runtime conclusion / commit / route / assumption]

## Next Steps (broad direction only)
- Step 4: [Direction; details deferred until Step 3 is complete]
- Step 5: [Depends on the output of Step 4; not yet expanded]
```

### 3.3 History Document (Optional Long-Horizon History)

**When to use:** For ongoing projects that span months, such as research programs or long-term product development.

**Responsibility:** Record milestone-level completions and changes in direction. It does not record step-level detail, which belongs in Runtime.

### 3.4 Document Priority and Conflict Handling

The three documents serve different responsibilities; no single document permanently overrides the others. Before execution, conflicts must be interpreted according to their source:

- `STATIC_SPEC` constrains the current task's goals, scope, hard limits, and acceptance criteria.
- `RUN_STATE` describes the current task's latest execution state, blockers, active step, and earlier runtime conclusions that new evidence has explicitly invalidated.
- `History` records long-term state changes and phase closures across stages and tasks.

If `History` shows that a task or phase has been closed while an old `RUN_STATE` still marks it active, execution must not continue under the old Runtime. The conflict must be reported, and the user must be asked whether to open a new task, resume the old task, or update Runtime.

If `STATIC_SPEC` conflicts with `RUN_STATE`, the LLM must not correct either document on its own. The relevant document may be updated only when the user has authorized the change or an explicit execution-loop rule permits it.

If the current Runtime explicitly marks an earlier runtime conclusion as `SUPERSEDED`, `DEPRECATED`, or `INVALIDATED`, a later LLM must not restore that conclusion merely because an old commit, Runtime snapshot, or early note contains words such as `PASS` or `validated`. Unless new evidence reopens the decision, the explicit invalidation statement is part of the current runtime semantics. It cannot override a hard contract in Static that remains in force.

---

## 4. Execution Loop

```text
Step 0  Document-consistency preflight
        The LLM reads Static and Runtime together, plus History for a long-running project
        If they conflict on task state, goals, active phase, or stop condition
        the LLM must not choose one version and continue on its own
        it must report the conflict and wait for the user or a higher-level document to resolve it

Step 1  Initialization
        The LLM analyzes the task requirements, aligns them with the user,
        generates the Static and Runtime documents, and writes them directly to the Git repository

Step 2  Execution-prompt generation
        The LLM uses the Active Step in the current Runtime to produce a prompt for Codex

Step 3  Agent execution
        Codex CLI executes the task, performs its own checks and smoke tests,
        and pushes the work to the Git repository after acceptance

Step 4  LLM verification
        The LLM accesses the repository directly and verifies the Step 3 changes
        ├── 4.1 Accepted                    → advance; update Runtime, mark Step i complete, and make Step i+1 Active
        ├── 4.2 Accepted with minor issues  → advance; record the remaining issues in Runtime
        ├── 4.3 Rejected                    → analyze the cause, issue a repair prompt, and return to Step 3
        └── 4.4 Human decision required     → pause; wait for the user's decision, then continue from Step 2,
                                               or accept the work and terminate the loop
```

**Three design decisions in Step 4 warrant emphasis:**

The LLM verifies the actual artifacts in the Git repository rather than relying on Codex's report. Codex's self-assessment has blind spots; an LLM that independently retrieves and stress-tests the repository content supplies a second perspective for cross-checking.

Repair iterations under 4.3 are recorded as Step i-a, Step i-b, and so on. This preserves the complete repair trajectory for later analysis of the failure.

When Step 4 causes a meaningful state transition, Runtime should include the commit, job, or artifact evidence that locates the change. If the evidence overturns a previously accepted plan, Runtime should also record the supersession relationship instead of merely appending another "current plan."

---

## 5. Why It Works

**Constraint-space compression:** A primary source of LLM hallucination is the need to "guess" when context is missing. The Static document provides a stable foundation. During execution, the LLM does not need to guess the original requirements: they are fixed in the durable contract, which the LLM cannot casually modify during an ordinary execution step.

**Maximizing local context:** During each execution, the LLM's attention is concentrated on the current Active Step, whose description is the most detailed of all steps. The ambiguity of later steps is deliberate; it prevents the LLM from making early decisions based on assumptions.

**Dual verification reduces self-assessment blind spots:** Codex evaluates its own work, and the LLM verifies it independently. They use the same Git repository but occupy different execution roles, creating an opportunity for Codex's self-justifications to be exposed by the independent review.

**Explicit invalidation propagation reduces historical ambiguity:** An old conclusion does not automatically disappear from the LLM's context when a newer commit appears. By explicitly declaring supersession in Runtime, the framework distinguishes "the earlier evidence once supported this conclusion" from "the conclusion remains valid now." This reduces the risk that the model must infer knowledge validity from mutually inconsistent historical records.

**Risk-adjusted rigor limits process overhead:** Strict controls are worthwhile only when failure cost and state complexity are high enough. Reducing documents and gates for low-risk work keeps the framework's own management cost proportionate; retaining a complete evidence chain for high-risk work preserves verifiability and reproducibility.

**Simple prompts reduce human-introduced variation:** When prompts are sufficiently simple, the prompt itself no longer needs to be the quality bottleneck. The framework's stability comes from its document structure rather than prompting technique at each execution step.

---

## 6. Case Studies

### Case A: From a Research Prototype to a Paper, Extended Experiments, and Reproducible Delivery

**Task type:** A long-running research-engineering effort spanning multiple rounds of experiment execution, resource scheduling, result auditing, paper support, and reproducible delivery for work involving probabilistic circuits, optimal transport, and PeTeR. This was not a single task governed from beginning to end by one plan. It was a sequence of tasks with different boundaries along one research line.

**Time span and phase evolution:** The early work began with GCW, `fastcircuits`, and an old optimal-transport pipeline. It progressed through single-file end-to-end integration, simplification of the DEBD HCLT runner, and sample-DRO execution before converging on `runDRO`, a reviewer-facing supplementary package. The research then produced the paper **PeTeR: Post-Training Robustification of Probabilistic Circuits**, which was accepted by and made public through the UAI 2026 Workshop on Tractable Probabilistic Modeling (TPM). Once the TPM phase closed, the old `runDRO` Runtime was not expanded indefinitely. Separate tasks were opened for an AAAI full-length extension: first a K=1/3/5 hyperparameter sweep, then RLTPM K=3/K=5 GPU learning experiments. After the AAAI full-paper submission, production experiment execution closed again, and the focus shifted to the appendix, supplementary materials, tables and charts, and external reproducibility preparation.

**Separation of document responsibilities:** Toward the end of the task, `runDRO_STATIC_SPEC.md` explicitly closed internal execution branches that had been completed or canceled. It narrowed the durable contract to a standalone supplementary ZIP, one reviewer-facing runner, 20 DEBD datasets, the complete `fastcircuits/` module, and CSV table output. `runDRO_RUN_STATE.md`, by contrast, retained only the authoritative state at that time: the clean ZIP and clean delivery repository had been produced, the remote check had passed, and only handoff remained. After the TPM phase, the cross-task History marked both `runDRO` and the workshop paper as completed history. This prevented an old Runtime from being mistaken for an active research mainline.

The AAAI phase reused the document structure without reusing the old contract. `peter_sweep_STATIC_SPEC.md` locked only the three sweep commands specified by Adrian, the execution environment, result boundaries, and the constraint that the scientific method must not be changed merely to make the jobs run. The corresponding Runtime tracked progress from Python-version and dependency blockers through production completion. For K=1, K=3, and K=5, each sweep reached `1120/1120 terminal configurations`, for `3360/3360 terminal configurations` overall. A `metrics.json` or `error.json` file represented a terminal state; the total therefore did not mean that every scientific run succeeded. Adrian explicitly confirmed that the high learning-rate numerical failures recorded as terminal errors were expected results. The work could then be committed and pushed without the Agent misclassifying those experimental outcomes as code defects that had to be repaired.

The second AAAI task further illustrates Runtime's dynamic role. `peter_rltpm_gpu_STATIC_SPEC.md` fixed K=3/K=5, Python 3.11, and Adrian's PyTorch/CUDA/Triton/PyJuice stack, while leaving `-j` concurrency as a variable that could be tuned based on evidence. Runtime continuously incorporated observed evidence: after Triton failed because `Python.h` was missing, it recorded and verified a task-local header fix. For K=3 on an L40S, `j=8` was verified with sampled peak GPU memory of approximately **12 GiB**. For K=5, actual telemetry showed that L40/L40S should not be treated as a safe default for `j=8`; the jobs ultimately ran stably at `j=8` on a full A100 80GB, with sampled peak GPU memory of approximately **47.8 GiB**. K=3 reached **28/28** complete artifacts, and K=5 also reached **28/28**. Both groups were audited, committed, and pushed in batches. Static did not become a log of these runtime discoveries, and Runtime did not turn temporary resource conditions into permanent scientific constraints.

**Core problem addressed by the framework:** The "next step" in a long-running research project changes repeatedly, while the scientific boundaries of each concrete task must remain stable. With one ever-growing master plan, assumptions about datasets, runners, Slurm, and artifacts from the early `runDRO` work could readily contaminate later PeTeR and AAAI tasks. Conversely, consulting only the latest Runtime would lose the long-term fact that TPM had closed and AAAI had begun as a separate task. Layering task-local Static / Runtime documents with cross-task History expressed both the continuity of the research line and the discontinuity of its execution contracts.

**Result:** The framework supported more than the delivery of a single supplementary package. It supported a research chain that produced an actual paper: the PeTeR workshop paper was completed, accepted, and made public; all `3360/3360` sweep configurations reached an audited terminal state; RLTPM experiments completed for **K=3: 28/28** and **K=5: 28/28** datasets and were pushed; and after production execution closed, work could move explicitly to paper and supplementary reproducibility without reopening tasks that had already been accepted or archived. The value of Static / Runtime / History in this case was not merely progress recording. The structure kept task boundaries verifiable, evidence traceable, and stop conditions explicit across a research project that lasted for months and changed direction repeatedly. The contribution documented by this case is execution governance and production experiment execution, not a theoretical contribution to PeTeR, GCW, or probabilistic circuits; the case does not establish their scientific claims.

---

### Case B: From an Author-Owned Windows Prototype to an Auditable macOS Application Release

**Task type:** AudioShifter began as a tool the author built for his mother to shift the pitch and speed of accompaniment tracks. Early Windows and macOS prototypes were usable in practice, but they were not placed in Git or developed through a systematic software-engineering process. The macOS source code was later lost, leaving only a packaged App. When a mobile version became desirable, limited home-computer performance, an intended user who was not comfortable operating a computer, and the burden of manual desktop maintenance made the earlier approach unsuitable. A new public repository was therefore established. The traceable Windows implementation was retained as a read-only historical reference, the macOS application was re-engineered, and the same product contract was used to prepare for a later Android port. The Android work is future platform context, not a completed part of this case.

The macOS work was a single software-engineering and release task with a stable boundary. The case repository is [AudioShifter](https://github.com/smter6626/AudioShifter). Throughout the macOS phase, the work remained centered on one goal: rebuild and release a standalone macOS application from the author's own historical prototype. Unlike Case A, it did not cross between separate research tasks or directions. It therefore used **Static + Runtime + artifact verification**, without mechanically adding History, corresponding to the **strict** level of rigor described in Section 7.

**Time span and phase evolution:** Runtime records the first repository inventory at **2026-08-02 21:41 MST**. On 2026-08-03, the project completed the behavioral contract, `behavior_spec.md`, `architecture_plan.md`, `verification_matrix.md`, a modular-source MVP, real-audio and GUI acceptance, and **130 automated tests**, then advanced to the PyInstaller phase. On 2026-08-04, it completed a standalone `.app` build, a packaging audit, and four-format verification in a restricted environment. It then moved through three release-candidate iterations—alpha.1 → alpha.2 → alpha.3—on the same day. The technical assets for alpha.1 passed, but the overall state remained `PARTIAL` because the license decision was unresolved. Work continued only after the owner decided on GPL-3.0-or-later and clarified the branding boundary. **`v0.1.0-alpha.3`** became a public GitHub Pre-release at **2026-08-04 06:39 MST**. From the first repository inventory to the requirements contract, implementation, testing, packaging, dependency audit, license decision, release build, non-development-machine acceptance, and public Pre-release, the work took approximately **32 hours 58 minutes—about 33 hours**. The final test suite passed in full.

**Separation of document responsibilities:** [**`macos_rebuild_static.md`**](https://github.com/smter6626/AudioShifter/blob/main/docs/macos_rebuild_static.md) locked the durable product and platform contract. It specified Apple Silicon `arm64` only, no Intel / Rosetta / `universal2` support, and no first-phase target for Developer ID signing or Apple notarization. It also fixed four input formats, a pitch range of `-24` to `+24` semitones, relative speed adjustment from `-95%` to `+400%`, fixed 44.1 kHz / 320 kbps stereo MP3 output, the Downloads directory, conflict-safe output allocation that did not overwrite existing files, protection of original input media, and cleanup on cancellation.

Static deliberately did not claim "minimum support for macOS 27" in advance. Instead, it required the minimum compatible version to be determined from the final dependencies, packaged artifact, and physical-machine verification. The recorded fact is that **only macOS 27.0 build `26A5378n` was tested**; this is not a statement of compatibility, a support range, or a minimum requirement. Static likewise did not choose a project license before the owner decided. It required only that the GPL compatibility route and corresponding-source obligations be resolved before binary distribution. The facts that alpha.1 was blocked by the missing license decision and that the owner later selected GPL-3.0-or-later were recorded during state transitions in [**`macos_rebuild_runtime.md`**](https://github.com/smter6626/AudioShifter/blob/main/docs/macos_rebuild_runtime.md) and dedicated legal documentation, rather than being written backward into the earlier Static contract. Evidence for source, packaging, and release acceptance was separated into [`mvp_test_report.md`](https://github.com/smter6626/AudioShifter/blob/main/macos/mvp_test_report.md), [`packaging_test_report.md`](https://github.com/smter6626/AudioShifter/blob/main/macos/packaging_test_report.md), and [`release_verification_v0.1.0-alpha.3.md`](https://github.com/smter6626/AudioShifter/blob/main/macos/release/release_verification_v0.1.0-alpha.3.md).

**Core problem addressed by the framework:** Unlike Case A's scientific experiments, the main risk here was whether code that ran on a development machine, the packaged `.app`, the source corresponding to the tag, and the final GitHub distribution assets were genuinely the same reproducible product. Homebrew, virtual environments, and local dynamic libraries can give a false sense of security when a build works only on its development machine. Each phase transition therefore required evidence from repository artifacts and independent scripts rather than accepting the Agent's statement that it had tested the build.

`build_release_assets.sh` reran the complete test suite from a clean tag in a detached worktree, rebuilt the App, and generated both corresponding source and SHA-256 checksums. The assets were then downloaded again from the GitHub Draft / Public Release and the audits were repeated against those downloaded copies. This translated the Case A principle that independent LLM verification is stronger than Agent self-assessment into **artifact identity verification** for release engineering. Alpha.1 remaining `PARTIAL` after its technical assets passed corresponds to branch 4.4 of the execution loop: when the blocker was an owner-policy decision rather than a technical implementation issue, the Agent had to stop and await human judgment instead of completing the contract on its own.

**Result:** `v0.1.0-alpha.3` finished with **165 passed, 0 failed, 0 skipped**, completing the test evolution from **130 tests → 165 passed**. The package audit covered **75 thin-arm64 Mach-O files, 324 dynamic references, and 20 `LC_RPATH` entries**, with **0 external non-system runtime references to Homebrew, virtual environments, or the repository**. The Pre-release provided an App ZIP, a SHA-256 checksum file, and an auditable GPL corresponding-source package. A non-development Apple Silicon Mac completed ZIP download, hash verification, per-application Gatekeeper allowance, launch, and hands-on acceptance testing. After the Pre-release became public, a fresh GitHub download-back verification downloaded all three assets again and confirmed that their byte counts and digests were unchanged. Together with original-input protection, cancellation cleanup, conflict-safe output allocation, and artifact identity verification, these checks formed the task's evidence chain.

This case shows why the strict level does not require History by default. For a stable-boundary software task with substantial build and release-consistency risk, Static + Runtime + artifact verification supplied the needed evidence chain. Set beside the full level used in Case A, it also makes Proportional Rigor a concrete choice between different task structures rather than an abstract slogan.

---

## 7. Applicability Boundaries and Misuse Risks

This framework is not a universal methodology and does not attempt to cover every use of an LLM. It is intended for execution-oriented tasks that can be divided into stages, verified, and tracked—especially computer-related workflows such as code implementation, experiment scripts, data processing, repository audits, document generation, batch jobs, and research-engineering support. Applicability is not binary: the same type of task may use different levels of rigor depending on failure cost and reproducibility needs.

### Suitable Task Types

- Engineering tasks with explicit acceptance criteria, including code, documentation, data processing, experiment scripts, and repository maintenance.
- Multi-stage tasks with clear dependencies between steps.
- Tasks that require traceability, for which Git commits, logs, artifact metadata, and History documents together provide an audit trail.
- Research-engineering tasks whose requirements can be reconfirmed at stage boundaries—for example, reconnaissance first, then contract finalization, implementation, and verification.

### Recommended Levels of Rigor

| Task characteristics | Recommended level of rigor |
| --- | --- |
| One-off, reversible, and low cost of failure | **Lightweight:** goal + key constraints |
| Multi-step but easy to inspect manually | **Moderate:** Static + simplified Runtime |
| Code, experiments, or data pipelines | **Strict:** Static + Runtime + artifact verification |
| Long-running research, expensive experiments, or high reproducibility needs | **Full:** Static + Runtime + History + Git evidence + acceptance gates |

Slide decks, speeches, one-off copy, and similar work usually fall into the lightweight or moderate range, so their level of process can be reduced deliberately. Code and research tasks more often fall into the strict or full range. The task label is not the deciding factor, however: a one-off low-risk script may warrant lightweight treatment, while a short code change that migrates production data may still require strong controls. The appropriate level depends on failure cost, reversibility, reproducibility needs, task duration, and state complexity.

### Unsuitable Task Types

- Simple, one-step, low-risk, one-off tasks for which the full framework's initialization cost would exceed its likely benefit. Such tasks should retain only the necessary constraints rather than mechanically applying every component.
- Open-ended creative tasks that cannot establish stage-level acceptance criteria.
- Tasks that require real-time human judgment, aesthetic judgment, or value judgment.
- Tasks whose external state changes rapidly and cannot be synchronized through an automated API or mandatory checkpoints.

### Misuse Risks

**Risk 1: Writing unconfirmed requirements into Static.**

Static should preserve only confirmed goals, constraints, inputs, and acceptance criteria. If a requirement is unclear, the LLM should not complete it on its own and promote the result to a durable contract. It should mark the uncertainty explicitly as `UNKNOWN`, `TO_CONFIRM`, or `REQUIRES_OWNER_DECISION`. Otherwise, Static turns an early hallucination into an "authoritative constraint" for every later step.

**Risk 2: Failing to require Runtime updates in the execution loop.**

A stale Runtime is not an inherent limitation of the two-document mechanism; it means the execution loop did not make Runtime updates part of the acceptance gate. Whether triggered manually by the user or written back through the GitHub API, Runtime should be updated whenever a meaningful subtask completes, a blocker appears or is resolved, the active step changes, or evidence overturns the current plan.

**Risk 3: Continuing after reading only one document.**

Before entering a task, the LLM must read Static and Runtime, plus History for a long-running project. If the documents disagree on task state, goals, active phase, or stop condition, the LLM should not choose one version on its own. It should report the conflict and wait for a decision.

**Risk 4: Treating Runtime as a historical archive.**

Runtime is a snapshot of the current authoritative state; it is not responsible for preserving the complete history. The full trajectory belongs in Git commits, History documents, logs, and artifact metadata. Runtime's purpose is to tell the next execution immediately where the work stands, what is blocked, and what happens next. Its commit, evidence, and supersession entries explain the current state and its validity; they should not expand into a commit-by-commit changelog.

**Risk 5: Exposing the internal control system as the final deliverable.**

Static, Runtime, and the audit machinery serve execution control; they are not necessarily the final product. If the goal is to deliver a script, README, or public runner to external users, that deliverable should remain simple, readable, and runnable. The internal verification framework should support the public-facing artifact rather than contaminate it.

**Risk 6: Fixing the framework at one level of rigor.**

Applying full research-grade controls to low-risk work creates unnecessary process cost; over-simplifying high-risk work removes traceability. The level of rigor should be selected according to failure cost, reversibility, reproducibility needs, task duration, and state complexity, rather than applied uniformly merely because an LLM is involved.

**Risk 7: Appending new conclusions without invalidating old ones.**

When new evidence overturns an old plan, recording only the new current state leaves earlier `PASS`, `validated`, or recommendation records available as ambiguous evidence. Runtime should explicitly identify the superseded conclusion and its evidence source, so a later LLM does not have to infer knowledge validity from the Git timeline. Experiments and commits from the earlier route can remain as historical evidence, but their current applicability must be explicitly withdrawn.

---

## 8. Distinction from Related Methods and Tools

**Chain-of-Thought / ReAct:** [Chain-of-Thought](https://arxiv.org/abs/2201.11903) primarily operates on a model's explicit reasoning within a task. [ReAct](https://arxiv.org/abs/2210.03629) further interleaves reasoning with external actions, allowing a model to gather information, update plans, and act across a multi-step interaction. This framework does not attempt to replace either reasoning or action pattern. It addresses an outer layer of long-running execution governance: when a task spans multiple Agent sessions, commits, and phases, which constraints remain stable, how the current state persists, when a state transition is permitted, and how old conclusions are explicitly invalidated. CoT or ReAct may be used as the execution strategy inside an Active Step.

**Spec-Driven Development / GitHub Spec Kit / Kiro Specs:** [GitHub Spec Kit](https://github.com/github/spec-kit) and [Kiro Specs](https://kiro.dev/docs/specs/) likewise discourage moving directly from an ambiguous prompt to implementation. They drive development through structured artifacts such as specifications or requirements, designs or plans, and tasks. Spec Kit uses a `Spec → Plan → Tasks → Implement` phase sequence, while Kiro Specs separates requirements, design, and tasks and tracks task state. This framework shares their practice of externalizing context into structured documents, but focuses on a different dimension. Rather than prescribing a fixed software-development phase sequence, it distinguishes Static, Runtime, and optional History according to **information stability, modification authority, and time scale**. The same structure can therefore govern research experiments, software releases, and other tasks with staged acceptance, while Runtime additionally carries the current semantics of evidence-backed state transitions and supersession.

**Context engineering / `AGENTS.md` / `CLAUDE.md` / Steering:** Modern coding agents commonly use repository-level instruction or memory files to retain architecture, conventions, commands, and project knowledge. OpenAI Codex, for example, uses [`AGENTS.md`](https://openai.com/index/introducing-codex/); Claude Code uses [`CLAUDE.md`](https://docs.anthropic.com/en/docs/claude-code/memory); and Kiro provides separate [Steering](https://kiro.dev/docs/steering/) files. More generally, [context engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) considers what context a model should receive at each inference. This framework is a narrower execution-governance approach within that broader trend, but it deliberately avoids placing every kind of information in one context file. Durable contracts, current execution state, and cross-task history have different update frequencies and modification authority, so they are physically separated. The aim is not to maximize context, but to give the model sufficient, semantically unambiguous authoritative information for the current step.

**Agent orchestration / runtime frameworks:** Frameworks such as [LangGraph](https://docs.langchain.com/oss/python/langgraph/persistence), the [OpenAI Agents SDK](https://openai.github.io/openai-agents-python/), and [AutoGen](https://microsoft.github.io/autogen/stable/) already provide runtime capabilities such as sessions, checkpoints, memory, handoffs, guardrails, tracing, human-in-the-loop control, and multi-Agent orchestration. These capabilities preserve and control the state of a running Agent system. This framework neither replaces that infrastructure nor treats the degree of autonomy as the main distinction. It manages a higher-level **project semantic state**: which contracts remain valid, which work has been accepted, what evidence permits advancement, which earlier decisions are no longer valid, and from which verified state the next execution should continue. The two layers can be combined: a runtime framework preserves program or Agent execution state, while Static / Runtime / History preserve project execution semantics.

**Traditional SOP / project documentation:** SOPs, requirements documents, task lists, and project logs can all be versioned and updated dynamically, so the distinction cannot be reduced to "traditional SOPs are static." The defining feature of this framework is that it explicitly assigns responsibilities and modification authority across documents, then combines `Static contract → Runtime state → evidence-backed transition → optional History` into an execution loop. Git history records "what happened"; Runtime states what that evidence means for the **current authoritative state**. When new evidence overturns an old conclusion, the framework also requires explicit supersession instead of asking a later Agent to infer which conclusion remains valid from the historical record.

---

*Last updated: August 2026*
