# Repository-Native Execution Governance for Long-Running LLM Workflows

> A Structured, Constraint-Driven Governance Methodology for Durable Contracts, Runtime State, and Evidence-Backed Transitions

Author: Yeming Dai

Version: 1.2

Canonical repository: [smter6626/structured-llm-execution-framework](https://github.com/smter6626/structured-llm-execution-framework)

DOI: [10.5281/zenodo.21911982](https://doi.org/10.5281/zenodo.21911982)

Copyright © 2026 Yeming Dai. All rights reserved.

---

## Abstract

Long-running LLM work can cross conversations, execution agents, commits, artifacts, and human decisions. In that setting, a conversational plan is a fragile place to store the current contract, and an executor's completion report is a weak basis for acceptance. This article presents a repository-native execution-governance methodology that separates a durable **Static** contract from current **Runtime** state and, when needed, long-horizon **History**. It also separates the Human Owner, Review / Orchestrator LLM, and Execution Agent, and requires meaningful state transitions to be tied to directly locatable evidence.

Version 1.2 sharpens three parts of the methodology. First, independent review requires independent access to evidence, independent verdict formation, and independent judgment of whether the available evidence is sufficient. Second, explicit supersession distinguishes preserved history from currently valid truth. Third, the article separates observed practice, derived methodology, conceptual positioning, and proposed extensions. Two repository-backed cases illustrate the method: a human-mediated career-operations workflow in which inherited facts, untrusted job descriptions, Human Decision Gates, and an executor self-`PASS` later invalidated by independent review had to be governed; and a software-release workflow in which tests, packaging audits, source identity, and downloaded release artifacts formed an evidence chain. These cases demonstrate applicability and traceability, not controlled causal estimates of productivity or reliability.

---

## Scope and Implementation Status

This article describes a **repository-native execution-governance methodology**. It is not a pip-installable SDK, an Agent runtime, an orchestration service, or a production multi-agent platform. Its core abstractions are document responsibilities, mutation authority, evidence-backed transitions, decision gates, and acceptance semantics.

The implementation evidence used here comes from human-mediated reviewer / executor workflows. Static / Runtime separation, Git-backed evidence, task-local state, role separation, Human Decision Gates, independent artifact review, and explicit supersession have all been used in repository work. A fully autonomous reviewer–executor loop, automatic transport between roles, and unattended state advancement remain compatible design directions, but they have not been implemented or evaluated in v1.2.

The article distinguishes **Observed Practice**, **Derived Methodology**, **Conceptual Positioning**, and **Future Work / Proposed Extension**; Appendix A provides component-level claim and evidence status.

---

## 1. Problem Origin

When an LLM executes a long-running, multi-step task, the risk is not limited to whether one response is correct. The task may span context resets, multiple Agents, Git branches, artifact generations, and decisions whose meaning changes over time. Several recurring failure modes then become project-state problems rather than prompt-writing problems.

**Context Loss / Compression.** Conversations, logs, configuration, and intermediate outputs accumulate. Model services may truncate, summarize, or compact earlier context, and an executor often cannot know exactly which details remain available. Internal model context is therefore an unreliable authoritative store for a long-lived project.

**Hallucination and Inherited-Fact Drift.** When evidence is incomplete, a model may fill the gap. A later step may inherit that output from a polished document or previously accepted artifact and treat it as an established fact. The resulting error can survive even when no later Agent actively invents anything.

**Constraint Drift.** A temporary implementation decision can gradually acquire the force of an original requirement. Conversely, a durable constraint can disappear while Runtime is updated. The boundary between “required by the owner” and “chosen for the current attempt” becomes unclear.

**State Ambiguity / Supersession Failure.** A plan or artifact may pass under early evidence and later be overturned. Git preserves both states chronologically, but chronology alone does not tell a future executor which conclusion is authoritative now. Without explicit invalidation, an earlier `PASS` or `validated` record remains easy to reuse.

**Cross-Task Contamination / Provenance Loss.** New tasks may continually overwrite the planning and state documents of earlier work. The original objective, final state, and acceptance basis then become harder to reconstruct, and an artifact can no longer be reliably attributed to the contract under which it was produced.

**Self-Verification Blind Spot.** An Execution Agent commonly helps choose the implementation and the verification path. It may run real tests and sincerely obtain `PASS`, yet the selected tool, fixture, extractor, or interpretation may be unable to expose the implementation's own defect. This is not necessarily laziness or fabricated testing; it is an evidence-selection dependency.

**Evidence-Boundary Failure.** An executor's report can be correct as a narrative and still be insufficient for acceptance. The relevant commit may not have been pushed, the wrong artifact may be reviewed, an external state may not have been captured, or evidence may be incomplete. “The Agent says it is done” is not a state-transition rule.

These failures share a structural property: they cannot be addressed reliably by a better prompt alone. They concern information lifecycle, authority, evidence identity, and current semantics. The methodology therefore externalizes the authoritative contract and state, specifies who may change them, and defines how evidence changes what is currently valid.

Early iterations used one composite document for requirements, detailed plans, and progress. That failed in two directions. Updating progress sometimes changed requirements incidentally, while planning every future step in detail forced later work to proceed from assumptions. The resulting lesson was not that all future detail must remain vague. It was that **known constraints and evidence may be recorded early, while implementation choices that depend on unavailable evidence should remain unresolved until that evidence exists**.

---

## 2. Design Principles

### 2.1 Separation of Responsibilities and Authority

Information is separated by responsibility, update frequency, and mutation authority. The durable contract is physically distinct from current execution state. The same isolation applies across tasks: a new independent objective receives a new task-local document pair instead of rewriting the completed task's records.

Role separation follows the same logic. The owner controls real intent and sensitive facts; the reviewer controls acceptance and state advancement; the executor controls implementation within the Active Step. These responsibilities may be implemented with different tools, but tool identity is not the governing abstraction.

### 2.2 Constraints First, Details Late

Confirmed objectives, hard limits, candidate options, and acceptance criteria should be recorded as soon as they are known. An implementation choice that depends on a later measurement, artifact, or owner decision should not be promoted into the contract prematurely. A detailed future note is information, not execution authorization.

### 2.3 Prompts Should Be Simple

The durable complexity belongs in the repository contract and state, not in repeated ad hoc prompts. The review side can compile the Human's confirmed intent, Static constraints, Runtime state, and acceptance criteria into an instruction for the sole Active Step. The Human should be able to review the important boundaries without becoming a prompt engineer.

### 2.4 Evidence Before Transition

A meaningful state change should be justified by evidence that the review side can locate independently: a commit, diff, test result, job, rendered artifact, hash, external-system observation, or explicit Human decision. An executor report is useful navigation, but it is not a substitute for the evidence it describes.

### 2.5 Explicit Supersession

Preserving history and preserving current truth are different requirements. When new evidence overturns an earlier conclusion, the old record may remain for provenance, but the current state must identify what was superseded, why, and what now governs execution.

### 2.6 Proportional Rigor

Document count, review depth, Git evidence, and acceptance gates should reflect failure cost, reversibility, duration, reproducibility needs, and state complexity. A low-risk one-off artifact may need only a goal and key constraints. A software release, data transformation, expensive experiment, or long-lived repository may justify stricter evidence and state controls. The purpose is not maximal process; it is enough structure for the risk.

---

## 3. Document and State Model

The core model uses Static and Runtime. History is optional for work that spans multiple phases or tasks. All three may be kept in Git, but they answer different questions.

### 3.1 Static: Durable Contract

**Responsibility:** Define the objective, scope, hard constraints, stable inputs, mutation boundaries, and acceptance criteria.

**Update rule:** Static changes only when the contract genuinely changes and the Human Owner, or an authority explicitly delegated by the contract, authorizes the change. Routine execution must not rewrite Static for convenience.

**Typical structure:**

```text
## Objective
[Final deliverable and intended outcome]

## Hard Constraints
- [Boundary that must not be violated]

## Authority and Approval
- [Who may change the contract or authorize sensitive actions]

## Acceptance Criteria
- [Evidence required for acceptance]

## Stable Background
[Confirmed context needed across executions]
```

Unknown requirements should remain explicitly unknown—for example, `TO_CONFIRM` or `REQUIRES_OWNER_DECISION`—rather than being completed by the model and silently frozen.

### 3.2 Runtime: Current Authoritative Execution State

**Responsibility:** Record completed work and its meaning, the sole current Active Step, blockers, residual validation items, and broad subsequent direction. Runtime is a current-state document, not a duplicate Git log.

**Update rule:** Runtime changes when state changes materially: an acceptance gate passes or fails, a blocker appears or clears, evidence invalidates a conclusion, a Human decision resolves an ambiguity, or the Active Step changes.

**Evidence-backed transition:** A material update should identify the evidence that caused it and explain the semantic change. Git answers “what happened and when”; Runtime answers “what is authoritative now.”

**Supersession record:** When needed, Runtime should state:

- the previous conclusion;
- the new evidence or Human correction;
- the current verdict;
- which earlier claim, artifact verdict, plan, or assumption is now `SUPERSEDED`, `DEPRECATED`, or `INVALIDATED`; and
- the locator for the relevant evidence.

**Typical structure:**

```text
## Completed
- Step 1: [result and evidence locator]

## Active Step
### Step 2: [one authoritative active step]
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
- [Known direction; unresolved choices remain conditional]
```

An accepted result with a minor issue does not require pretending that the issue does not exist, and it does not automatically block the whole task. Runtime can advance while retaining a residual validation item and a later gate.

### 3.3 History: Optional Long-Horizon Record

History records milestone-level closures, reopened phases, and direction changes across tasks. It should not reproduce step-level Runtime detail. A completed task's Static and Runtime are frozen by default; a genuinely new objective receives a new task-local pair. If the owner reopens a task, the reopening and its reason become an explicit state transition.

### 3.4 Conflict Handling

No document permanently overrides every other document because each has a different responsibility. A preflight should read Static and Runtime together, plus History when applicable.

- Static constrains the active task's durable contract.
- Runtime states current progress, blockers, and explicit invalidations.
- History records phase and task closure over a longer horizon.

If History says a task is closed while an old Runtime says it is active, execution must pause for state resolution. If Runtime appears to contradict Static, neither document should be “fixed” by the executor unless a contract rule explicitly authorizes it. If Runtime explicitly invalidates an earlier runtime verdict, a later Agent must not restore the old verdict merely because Git still contains it. Explicit supersession governs current Runtime semantics, but it cannot silently cancel a still-valid hard constraint in Static.

---

## 4. Roles and Execution Loop

### 4.1 Human Owner

The Human Owner confirms the real objective, sensitive facts, risk tolerance, subjective preferences, and changes to the durable contract. Human involvement is not required for every machine-verifiable check, but it is required when evidence cannot establish the truth, when value judgment is intrinsic, when an action is high-risk or irreversible, or when the contract itself may need to change.

### 4.2 Review / Orchestrator LLM

The Reviewer reads the governing documents, helps clarify requirements, compiles the current Active Step into an execution instruction, accesses the actual evidence, forms an acceptance verdict, and advances Runtime when justified. It manages contract interpretation and evidence sufficiency; it does not invent an owner's missing intent or factual correction.

### 4.3 Execution Agent

The Executor implements the current Active Step, operates tools, builds or edits artifacts, runs self-checks, and makes the outputs reviewable. It should report locators and limitations accurately. By default, it neither changes Static / Runtime nor acts as its own final accepter.

The operating distinction is:

```text
Human Owner governs real intent and authoritative correction.
Reviewer governs contract interpretation, evidence sufficiency, and acceptance.
Executor governs implementation and execution within the active contract.
```

### 4.4 Git and Artifacts as an Evidence Boundary

The repository is a shared evidence surface between roles. The Executor can write code, diffs, reports, tests, hashes, and artifact locators; the Reviewer can then inspect those materials without sharing the Executor's internal context. This makes review less dependent on copied logs or narrative summaries.

However, Git is an evidence boundary, not an inherently trusted boundary. Commit identity, branch stability, artifact identity, credentials, external state, and repository content still require implementation-specific controls, discussed in the threat model.

Evidence governance also does not require every artifact to be public. Reusable system-layer code may be public while sensitive task artifacts remain private. The requirement is that the authorized Reviewer can access the evidence needed for the verdict and that public claims do not exceed the safe, supportable abstraction.[^privacy-boundary]

### 4.5 Execution Loop

```text
Step 0  Consistency preflight
        Read Static + Runtime (+ History when applicable)
        Stop on unresolved contract/state/closure conflict

Step 1  Requirement alignment
        Human confirms objective, sensitive facts, and required choices
        Reviewer records the contract or current state through authorized paths

Step 2  Active-Step compilation
        Reviewer turns the sole Active Step into a bounded execution instruction
        Include permitted mutations, evidence requirements, and acceptance criteria

Step 3  Execution
        Executor implements, self-checks, and exposes locatable evidence
        Do not change governance state unless explicitly authorized

Step 4  Independent review
        Reviewer inspects contract and evidence directly and forms a verdict
        ├── 4.1 ACCEPTED
        │         → advance Runtime and activate the next step
        ├── 4.2 ACCEPTED WITH MINOR ISSUE
        │         → advance; preserve residual validation item
        ├── 4.3 REJECTED
        │         → issue a bounded repair instruction; return to Step 3
        └── 4.4 HUMAN DECISION REQUIRED
                  → pause state advancement; request owner judgment
```

Repair attempts may be recorded as Step i-a, i-b, and so on. If a later review invalidates an earlier `ACCEPTED` verdict, Runtime records the invalidation rather than appending a new verdict without a semantic relationship.

### 4.6 Independent Review: Three Requirements

Independent review is not “a second model read the first model's summary.” It requires all three of the following:

1. **Independent evidence access.** The Reviewer can inspect the contract, diff, test output, artifact, hash, or relevant external observation directly. The Executor's report is a locator, not the evidence boundary.
2. **Independent verdict formation.** The Reviewer evaluates the acceptance criteria from that evidence rather than inheriting the Executor's conclusion.
3. **Independent judgment of evidence sufficiency.** The Reviewer may decide that the Executor's chosen test or extractor does not adequately challenge the acceptance claim and may select a different verification path.

The third requirement is essential. Repeating the same test can confirm reproducibility of that test while leaving its blind spot unchanged. A review becomes meaningfully falsifiable when the Reviewer can question what would count as sufficient evidence, use another tool or interpretation where justified, and invalidate a prior `PASS` when stronger artifact-level evidence contradicts it.

Independence is primarily a property of the review process, not of model identity.[^review-independence]

In the deployment reported here, GPT-5.6 Sol served as Reviewer and GPT-5.6 Terra as Executor.[^review-capability]

The more durable role distinction is:

```text
Executor optimizes execution success.
Reviewer optimizes acceptance correctness.
```

### 4.7 Human Decision Gate

The loop pauses when a fact cannot be established from available evidence, a subjective intention or tone must be supplied, a durable constraint may change, an action is sensitive or irreversible, or execution and review disagree in a way the evidence cannot resolve. The Reviewer should expose the unresolved choice and its consequences, not guess on the owner's behalf.

---

## 5. Framework Invariants and State Semantics

These invariants summarize the existing protocol; they do not introduce a second state machine.

| Invariant | Engineering meaning |
| --- | --- |
| **Single Active Step** | A task has at most one authoritative Active Step during normal execution. Parallel implementation work, if allowed, still reports into one governing state decision. |
| **Static Mutation Authority** | The durable contract can change only when it genuinely changes and the Human Owner, or an authority explicitly delegated by the contract, authorizes the change. The Executor cannot self-authorize, infer, or broaden that authority. |
| **Evidence-Backed Transition** | A meaningful Runtime transition cites externally locatable artifact evidence or an explicit Human decision. |
| **Supersession Persistence** | Once a conclusion is explicitly superseded, its continued presence in Git or an old artifact does not restore current validity. Reopening requires new evidence or authorization. |
| **Task-Local Freeze** | Completed task governance documents remain frozen by default. New objectives receive new task-local state unless the owner explicitly reopens the old task. |
| **Reviewer Evidence Access** | Final acceptance cannot rest only on executor self-report; the Reviewer must be able to inspect the evidence required by the acceptance claim. |

The invariants constrain authority and semantics, not implementation technology. A team may enforce them manually, with repository checks, or through a future orchestration service.

---

## 6. Mechanistic Rationale: Why the Structure May Help

The following are mechanistic rationales derived from observed workflows. They are not controlled causal findings.

**Constraint-space narrowing.** A durable contract makes fewer requirements available for ad hoc reinterpretation during implementation. The model can still misunderstand the contract, but it no longer has to reconstruct it solely from a long conversation.

**Externalized authoritative state.** Static and Runtime let a later session recover the intended contract and current state from repository artifacts. This provides a basis for tracing back after a context reset.

**Local execution focus.** The sole Active Step gives the Executor a bounded objective, permitted mutation surface, and acceptance target. Future choices may be recorded, but decisions that depend on missing evidence remain conditional.

**Explicit supersession.** An invalidated conclusion remains available as provenance while becoming unavailable as current authority. This removes one source of semantic ambiguity that Git chronology alone does not resolve.

**Independent evidence challenge.** A Reviewer with direct evidence access can test not only whether the Executor ran its checks, but whether those checks support the acceptance claim. This creates a path for an honest self-`PASS` to be overturned without treating disagreement as model voting.

**Proportional rigor.** Matching governance overhead to risk prevents the methodology from becoming the deliverable. A stricter evidence chain is reserved for stateful or costly work; simpler tasks can use a smaller subset.

**Human gates at irreducible boundaries.** Facts known only to the owner, subjective motivations, policy decisions, and high-risk actions are not converted into model guesses merely to keep an automated loop moving.

---

## 7. Case Studies

The two cases deliberately span different governance intensities. Case A represents the higher-rigor end for a persistent, multi-role workflow with evolving state. Case B represents a lower-ceremony proportional subset in which the governance structure covers a more concentrated set of risks.

The cases below are organized around **Observed Problem → Governance Intervention → Observed Outcome**. They show that the methodology can coexist with real execution and preserve reviewable evidence. They do not isolate the methodology as a causal treatment and therefore do not establish productivity, reliability, or cost improvements.[^observational-evidence]

### 7.1 Case A: Governance in a Career-Operations Agent Workflow

#### Operating structure and evidence boundary

This case concerns a sustained workflow for evaluating job descriptions and producing application artifacts under a controlled candidate-fact baseline. Its observed operating structure was:

```text
Human Owner
→ Review / Orchestrator LLM
→ Execution Agent
→ Git and artifact evidence
→ independent review
→ Runtime state transition
```

The Human controlled the real career objective, sensitive facts, subjective choices, and approval boundaries. The Reviewer maintained the contract, checked factual and artifact evidence, decided acceptance, and advanced state. The Executor performed the active implementation: source acquisition within authorization, analysis, artifact generation, rendering, tests, and repository operations. Public system code and private candidate artifacts were separated; review still occurred within an authorized shared evidence boundary.

This was a human-mediated supervised review–repair workflow, not an autonomous multi-agent service. An executor report could locate evidence but could not accept its own output.

#### Inherited fact correction → Human Gate → supersession

**Observed problem.** A historical candidate profile contained an over-specified education credential. Because the profile looked authoritative and had already fed earlier artifacts, the Executor inherited the claim rather than inventing a new one. Independent review identified that the available evidence did not support the credential as stated. The Reviewer also lacked authority to guess the correct replacement.

**Governance intervention.** The issue entered a Human Decision Gate. The owner supplied the authoritative correction, and the active candidate baseline was narrowed to the statement supported by that correction. Historical artifacts were retained for provenance, but the old claim was explicitly marked historical-only and superseded. Current state rules prohibited a later Executor from restoring it merely because an old resume, commit, or prior `PASS` still contained the wording.

**Observed outcome.** Active materials and later generated artifacts used the narrowed fact. The repository retained the chronology of the earlier record, while Runtime established that the record was no longer current truth. The event illustrates inherited-fact drift, owner-only factual authority, and the distinction between preserving provenance and authorizing reuse.

#### External job descriptions as untrusted optimization input

**Observed problem.** A real job-description smoke test contained desirable qualifications that exceeded the candidate's direct evidence. A tailoring system has an optimization incentive to increase lexical overlap, but copying those requirements into the candidate baseline would convert an employer request into a candidate claim.

**Governance intervention.** The workflow treated the external job description as untrusted optimization input. It could influence qualification analysis, evidence selection, and tailoring, but it could not modify candidate facts. The review separated **direct evidence**, **transferable evidence**, and **gap**. Transferable engineering or documentation experience remained transferable; absent enterprise tools or responsibilities remained gaps. Education, experience type, and other sensitive facts were not changed to improve apparent fit.

**Observed outcome.** The completed smoke test produced a conditional route and tailored artifacts whose narrower claims passed the applicable fact checks and independent review within the workflow.[^case-a-evaluation]

#### A short Human Gate for subjective intent

Facts in a required cover letter could be drawn from approved evidence, but motivation for the role and tone could not be safely inferred from the job description or resume. Finalization therefore paused for owner input and approval before source, PDF, and review-side acceptance were completed. Sensitive application answers and final submission remained outside autonomous generation.

#### Executor self-`PASS` → Reviewer overturn → invalidation

**Observed problem.** The Execution Agent generated a final PDF artifact and performed both visual inspection and reading-order verification. The page looked correct, the Agent's selected extraction path appeared to preserve the intended order, and the Agent sincerely reported `PASS`.

The independent Reviewer accessed the same PDF directly and selected a different text-extraction path. That extractor showed that two body-content blocks were placed after the signature in the PDF content stream. The visual layout was correct, but the semantic reading order did not satisfy robust acceptance. The contradiction was in the artifact itself; it did not depend on assuming that the Agent skipped its test or fabricated its report.

**Governance intervention.** The Reviewer judged the earlier evidence insufficient for the acceptance claim and invalidated the original reading-order `PASS`. The old PDF, report, and verdict remained preserved as historical evidence, while Runtime marked that acceptance claim `INVALIDATED`. A minimal renderer repair restored ordinary content flow. The revised PDF was then checked visually and through multiple extraction paths before receiving a new `PASS`.

**Observed outcome.** The artifact-level contradiction was removed in the repaired output, and the current state pointed to the revised evidence rather than the historical verdict. More importantly, the event refined the definition of independent review: the Reviewer must be free to decide what evidence is sufficient, not merely repeat the Executor's chosen test.

Even when self-verification is real and honest, implementation choice and evidence-path selection can be correlated within one execution role; the independent Reviewer's judgment of evidence sufficiency makes the old `PASS` falsifiable.

#### Supporting state semantics

A separate layout observation was accepted as non-blocking: the workflow advanced while Runtime preserved a residual page-utilization issue. Known acceptance constraints—such as preserving text extraction and reading order—were recorded immediately, while an untested layout redesign remained unresolved. This is “constraints first, details late” in practice: preserve known boundaries without guessing an implementation.

The case also demonstrates that evidence governance is compatible with privacy separation. Public system-layer changes can be reviewed openly, while candidate-specific sources and application artifacts remain private and are inspected only within the authorized boundary. No sensitive artifact needs to be copied into the public methodology to support the mechanism-level account.

### 7.2 Case B: AudioShifter Software Release and Artifact Identity

Case B represents the lower-ceremony end of the methodology. The bounded macOS release task did not require the multi-role state loop used in Case A. Governance focused on stable platform and product constraints, necessary owner decisions, and the identity of build, package, and Release artifacts.

The case concerns [AudioShifter](https://github.com/smter6626/AudioShifter), a macOS application rebuilt from an author-owned historical prototype after the earlier macOS source was unavailable. The task had a stable product boundary but substantial release-identity risk: code that ran on the development machine, the packaged application, the tagged source, and the public Release assets needed to refer to the same auditable product.

**Human input remained lightweight.** In this case, the Human's task-level prompts mainly asked for the current work to be completed and then validated; they did not enumerate the specific engineering checks that later appeared in the verification path. Final acceptance did not remain a generic “check that it works.” It became concrete: `165 passed, 0 failed, 0 skipped`; an audit of 75 thin-arm64 Mach-O files, 324 dynamic references, and 20 `LC_RPATH` entries; corresponding source and a checksum; acceptance on a non-development machine; and download-back verification of three public Release assets. In plain terms, the Human input was simple, but execution did not remain at the prompt's literal granularity: the working process became visibly more structured and engineering-oriented.[^case-b-engineering-emergence]

**Observed problem.** Development-environment dependencies could make a local build appear self-contained when the packaged artifact was not. A technically complete candidate also encountered an owner-policy question about licensing, which executable tests could not decide.

**Governance intervention.** Governance intensity was configured around the actual risks rather than by mechanically deploying the entire Framework. Static held the durable platform and product contract without claiming untested compatibility. Runtime recorded implementation, packaging, owner decisions, and release state. The licensing question entered a Human Decision Gate instead of being filled in by the Agent. Release tooling rebuilt from a tagged detached worktree, generated corresponding-source and checksum artifacts, audited the package, and repeated verification against assets downloaded from the Release surface.

**Observed outcome.** The public [`v0.1.0-alpha.3` verification record](https://github.com/smter6626/AudioShifter/blob/main/macos/release/release_verification_v0.1.0-alpha.3.md) records `165 passed, 0 failed, 0 skipped`; an audit of 75 thin-arm64 Mach-O files, 324 dynamic references, and 20 `LC_RPATH` entries; a checksum file and corresponding-source package; acceptance on a non-development machine; and download-back verification of the three public Release assets. These records establish the Release artifact evidence chain.

Case B shows the lower-ceremony end of the methodology: governance intensity can track failure cost, state persistence, and artifact-identity risk. This bounded task did not need a separate History document or the multi-role governance intensity of Case A; Static, Runtime, a Human Gate when needed, and Release evidence covered its principal risks. Case A shows higher rigor for complex persistent state, while Case B shows a proportional subset for a more concentrated risk profile.

---

## 8. Applicability Boundaries and Misuse Risks

### 8.1 Suitable Use

The methodology is most relevant to staged, inspectable work in which state or evidence must survive beyond one conversation: code changes, document production, repository maintenance, data transformations, experiment execution, packaging, release engineering, and other workflows with explicit acceptance conditions.

| Task characteristics | Possible rigor level |
| --- | --- |
| One-off, reversible, low failure cost | Goal + key constraints |
| Multi-step and easy to inspect manually | Static + simplified Runtime |
| Code, data, artifacts, or release work | Static + Runtime + artifact review |
| Long-lived, costly, high-reproducibility work | Task-local Static / Runtime + optional History + strong evidence gates |

The labels are not decisive. A short production migration may need strict control; a low-risk script may not.

### 8.2 Poor Fit

The full methodology is a poor fit when initialization and review cost exceed the task's risk, when work cannot be staged into meaningful acceptance conditions, when the result depends continuously on subjective human judgment, or when external state changes faster than it can be captured through checkpoints or direct inspection.

### 8.3 Misuse Risks

**Freezing an invented requirement.** Unknowns placed into Static as facts turn early speculation into a durable error.

**Allowing Runtime to go stale.** A two-document structure does not help if state changes bypass Runtime or if old `PASS` records remain semantically unqualified.

**Reading only one governance document.** Static without Runtime loses current state; Runtime without Static can normalize a contract violation; both without relevant History may reopen a closed phase.

**Turning Runtime into a second Git log.** Runtime should preserve current meaning and evidence locators, not narrate every command or commit.

**Letting the Executor change and accept the contract.** If one role can rewrite the requirement, implement it, select the evidence, and declare final acceptance, the authority boundary has collapsed.

**Treating model count as independence.** Two models that share only the Executor's summary share its evidence boundary. Conversely, different vendors do not compensate for absent artifact access.

**Publishing all evidence.** Reviewability does not require exposing private, regulated, or personally sensitive artifacts. Access control and public claim minimization remain necessary.

**Applying maximum rigor mechanically.** Governance overhead can exceed task value and can obscure the actual deliverable. The method should be scaled down deliberately.

**Inferring causal benefit from a successful project.** A project that completed with tests and review shows compatibility and traceability, not what would have happened without the methodology.

---

## 9. Threat Model

**Git can serve as an evidence boundary, but it is not inherently a trusted boundary.** The methodology partially structures evidence handling; it does not replace repository security, identity, or deployment controls.

| Threat | Current methodological mitigation | Residual or implementation responsibility |
| --- | --- | --- |
| Repository prompt injection in documents, issues, diffs, or artifacts | Treat repository content as evidence to evaluate, not instructions with automatic authority; preserve role and mutation boundaries | Content sanitization, tool isolation, least privilege, and model-specific defenses remain implementation responsibilities |
| Compromised executor credentials | Reviewer forms a separate verdict and can require signed or reproducible evidence | Credential protection, branch protection, signing, and incident response are outside the document method |
| Mutable branch or HEAD drift | Record commit, tag, hash, or artifact identity for the reviewed state | Pinning, immutable storage, protected refs, and CI policy must enforce identity |
| Review-time race | Review a pinned commit or hashed artifact and record the locator in Runtime | Atomic snapshots and concurrency controls require implementation support |
| Wrong or stale artifact | Tie the acceptance claim to an explicit artifact hash, build, tag, or download source | Build provenance and artifact-store integrity are system concerns |
| Correlated Reviewer / Executor failure | Separate context, objective, evidence access, and verdict formation; permit alternate evidence paths | Shared models, infrastructure, or assumptions can still fail together; diversity and adversarial review remain evaluation questions |
| External state absent from Git | Require direct external observation or an explicit Human evidence record when repository evidence is insufficient | Connectors, freshness guarantees, and capture integrity are deployment-specific |
| Incomplete or selectively presented evidence | Reviewer judges sufficiency and may request missing evidence or reject the transition | The methodology cannot guarantee discovery of deliberately concealed evidence |

The method therefore offers partial mitigation for semantic confusion and self-report dependence. It does not claim to solve credential compromise, malicious repositories, secure provenance, or all correlated model failures. Stronger identity, isolation, and adversarial-review mechanisms are implementation and future-work areas.

---

## 10. Limitations and Evaluation Plan

### 10.1 Current Limitations

The reported cases are observational and were selected because repository or artifact evidence was available; the methodology was not isolated as a treatment, and no counterfactual baseline was established.[^observational-evidence]

The current evidence does not establish quantified process benefit, comparative superiority, or the reliability or advantage of fully autonomous orchestration.

The repository cases may also reflect author familiarity, selection effects, task-specific tooling, and a highly involved Human Owner. Evidence recorded in Git may omit relevant external state. Reviewers and Executors may share correlated assumptions. Explicit governance documents can themselves become stale, incorrect, malicious, or too expensive to maintain.

### 10.2 Evaluation Plan

A future evaluation could compare matched tasks under the following conditions:

```text
Baseline
Single evolving plan and conversational state

Treatment
Task-local Static + Runtime + evidence-backed transitions
```

The comparison should predefine acceptance criteria, task classes, model/tool configurations, Human intervention rules, and how state resets are introduced. Candidate metrics include:

| Metric | Example operational question |
| --- | --- |
| Frozen-constraint violations | How often does output contradict a confirmed hard constraint? |
| Stale superseded-decision reuse | How often is an explicitly invalidated claim or route restored? |
| Recovery after context reset | How much time and Human correction are required to resume from the verified state? |
| Human correction count | How often must the owner repair facts, scope, or intent? |
| Reviewer rejection and rework | How many acceptance cycles are required per completed step? |
| Executor false-`PASS` overturned by review | How often does independent artifact review invalidate self-verification? |
| Context and token use | What context size and token usage are required for accepted completion? |
| Repeated or unnecessary work | How much execution is repeated because state or evidence was unclear? |
| Completion latency | How long does accepted task completion take, including review overhead? |

Any result should distinguish artifact quality from process cost and should report failures as well as successes. Lower token use, fewer steps, or faster completion should count as improvement only when the final output still satisfies the same acceptance criteria. No such experiment was performed for this release; the table is a falsifiable evaluation direction, not evidence of benefit.

---

## 11. Related Work and Conceptual Positioning

The comparisons below use published papers and official documentation to position the semantic layers managed by different methods. They are conceptual comparisons, not empirical superiority tests.[^related-work-scope]

**Chain-of-Thought and ReAct.** [Chain-of-Thought prompting](https://arxiv.org/abs/2201.11903) elicits intermediate reasoning steps within a model task. [ReAct](https://arxiv.org/abs/2210.03629) interleaves reasoning and action in an interaction trajectory. Either may operate inside an Active Step. The governance method discussed here concerns the outer project semantics that survive across executions: durable constraints, current accepted state, evidence identity, and supersession.

**Spec-driven development.** [GitHub Spec Kit](https://github.com/github/spec-kit/blob/main/docs/index.md) documents a default `Spec → Plan → Tasks → Implement` process, while [Kiro Specs](https://kiro.dev/docs/cli/v3/specs/) produces requirements, design, and task artifacts with an execution phase. These systems externalize development intent and planning. Static / Runtime / History classify information instead by stability, mutation authority, and time scale, so the concepts can be used alongside a development-phase workflow rather than replacing it.

**Context engineering and repository instruction files.** Context engineering concerns selection and maintenance of the information made available during inference. Official documentation describes repository or workspace guidance through [Codex `AGENTS.md`](https://learn.chatgpt.com/docs/agent-configuration/agents-md), [Claude Code `CLAUDE.md`](https://code.claude.com/docs/en/memory), and [Kiro Steering](https://kiro.dev/docs/steering/); [Anthropic's context-engineering discussion](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) frames context as a finite resource to curate. Such files can carry conventions, architecture, and instructions. The present method gives durable contract, current state, and optional long-horizon history separate mutation semantics instead of treating all repository context as one class of information.

**Agent orchestration and runtime state.** [LangGraph persistence](https://docs.langchain.com/oss/python/langgraph/persistence) describes checkpointed graph state; the [OpenAI Agents SDK](https://developers.openai.com/api/docs/guides/agents) documents agent loops, state, handoffs, guardrails, tracing, and approval flows; and [AutoGen](https://microsoft.github.io/autogen/) provides AgentChat and Core abstractions for single- and multi-agent applications. These frameworks manage executable Agent and application state. Repository-native governance can sit above or beside that layer, recording which project contract is current, what evidence authorizes advancement, and which earlier verdict no longer governs. A future autonomous implementation could use such runtime infrastructure without making the runtime library itself the methodology.

**Traditional SOPs and project documentation.** Requirements documents, SOPs, task lists, decision records, and project logs can all be versioned and updated. The distinguishing proposal here is a specific responsibility and authority split—`Static contract → Runtime state → evidence-backed transition → optional History`—plus explicit acceptance and supersession semantics. This is a methodological arrangement of familiar artifacts, not a claim that conventional project documentation is inherently static or incompatible.

---

## 12. Conclusion

Repository-native execution governance treats long-running LLM work as a problem of contracts, state, authority, and evidence—not only prompting. Static preserves the durable contract; Runtime states what is authoritative now; optional History preserves long-horizon closure; task-local freeze prevents later work from erasing earlier provenance; and supersession distinguishes historical truth from current validity.

The central v1.2 refinement is epistemic rather than architectural: independent review requires direct evidence access, an independently formed verdict, and an independent decision about whether the evidence is sufficient. The career-operations PDF event shows why that third condition matters, and illustrates higher-rigor governance for persistent state in a multi-role workflow. The AudioShifter Release case shows that the same methodology can use a lower-ceremony proportional subset when risk is concentrated in package and Release identity.

The evidence supports applicability, traceability, and evidence-preserving execution in the reported human-mediated workflows. It does not support quantified benefit or autonomous-orchestration claims. Those boundaries are part of the methodology: a durable execution framework should record not only what is believed to work, but also what remains unimplemented, unmeasured, or dependent on Human judgment.

---

## Appendix A — Claim and Evidence Status

### A.1 Component Status

| Component or claim | Status in v1.2 |
| --- | --- |
| Static / Runtime separation and task-local state | Observed Practice; also abstracted as Derived Methodology |
| Git-backed transition evidence and artifact review | Observed Practice |
| Human / Reviewer / Executor role separation | Observed human-mediated workflow |
| Human Decision Gates and explicit supersession | Observed Practice; also Derived Methodology |
| Independent Review | Observed Practice; includes independent evidence access, independent verdict formation, and independent judgment of evidence sufficiency; the definition was further refined by artifact-level contradiction |
| Positioning relative to specifications, context files, and Agent runtimes | Documentation- and paper-based Conceptual Positioning |
| Fully autonomous reviewer–executor orchestration | Future Work / Proposed Extension; not implemented or evaluated in the evidence reported here |
| Quantified productivity, token, latency, failure-rate, or Reviewer catch-rate gains | Not established |

### A.2 Outcome Claims Not Established in v1.2

Version 1.2 has not established:

- a percentage change in productivity or accepted task completion time;
- a change in failure rate, frozen-constraint violations, or stale-decision reuse;
- token savings or context-size savings;
- faster recovery after context reset;
- fewer Human corrections or repair iterations;
- a Reviewer catch rate, or the effect of Reviewer capability on that rate;
- superiority over a single evolving plan, conversational state, or an Agent runtime; or
- reliability or cost advantages for fully autonomous orchestration.

---

Last updated: August 2026

[^observational-evidence]: The reported cases are observational and were selected where repository or artifact evidence was available. Because the methodology was not isolated as a treatment and no counterfactual baseline was established, the cases do not support causal conclusions about quantified process benefit, comparative superiority, or autonomous-orchestration advantage. Appendix A.2 preserves the detailed inventory of outcome claims not established in v1.2.

[^review-independence]: Here, independence is a property of the review process, not a claim of statistical or complete epistemic independence. Different vendors, model families, accounts, or infrastructure are not required if context, objective, direct evidence access, verdict formation, and judgment of evidence sufficiency are separated. Conversely, different model identities do not create independent review when the Reviewer sees only the Executor's summary or inherits its acceptance judgment. Shared models, infrastructure, assumptions, or evidence sources can still produce correlated failure.

[^review-capability]: In the reported deployment, GPT-5.6 Sol served as Reviewer and GPT-5.6 Terra as Executor. This is an observed deployment configuration, not a model-ranking result or a Framework requirement. v1.2 does not establish a general capability difference between the models or measure the effect of Reviewer capability on catch rate. The Framework requires independent evidence access, independent verdict formation, and independent evidence-sufficiency judgment, not a specific model pairing.

[^case-a-evaluation]: The observed job-description workflow supports only the narrower proposition that the produced candidate claims passed the applicable fact checks and independent review within that workflow. It does not measure ATS ranking, hiring-prediction accuracy, employer decisions, application success, or the generalized quality of resume tailoring.

[^related-work-scope]: Unless a paragraph explicitly says otherwise, these comparisons are based on published papers and official documentation. They position semantic scope; they are not hands-on production integration studies, head-to-head benchmarks, or empirical superiority tests. The cited systems often manage different layers and may be composed with repository-native governance. Product behavior can also change after the cited documentation, so the comparison is limited to the documented capabilities used for the stated positioning.

[^privacy-boundary]: An evidence boundary may be private. Reviewability requires that an authorized Reviewer can inspect the evidence needed for the verdict; it does not require public disclosure of candidate-specific, personally sensitive, regulated, credential-bearing, or otherwise confidential artifacts. Public claims should remain at the safest abstraction supported by the private evidence, and access control still applies.

[^case-b-engineering-emergence]: This note describes an observed difference between Human input and execution structure in this case. The Human task-level prompt mainly asked for the current work to be completed and then validated; it did not enumerate the later engineering checks. The fact that execution proceeded to testing, packaging validation, Release verification, and an evidence-chain structure does not establish that simple prompts generally produce disciplined software engineering, or that a system will automatically adopt appropriate engineering practices without constraints, review, or evidence requirements. “More structured and engineering-oriented” refers only to the practices actually evidenced by the repository and Release artifacts; it does not establish productivity, reliability, quality improvement, or superiority over other development approaches.
