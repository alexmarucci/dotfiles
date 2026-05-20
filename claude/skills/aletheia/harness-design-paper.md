# Anthropic Harness Design: Transferable Principles

Source: Rajasekaran, "Harness design for long-running application development" (Anthropic Labs, 2026)
https://www.anthropic.com/engineering/harness-design-for-long-running-application-development

## 1. Self-Evaluation Is Unreliable

> "When asked to evaluate work they've produced, agents tend to respond by confidently praising the work—even when, to a human observer, the quality is obviously mediocre."

Separating the generator from the evaluator is the highest-leverage intervention. Tuning an external evaluator to be skeptical is far more tractable than making a generator critical of its own work.

## 2. Criteria Make Subjective Quality Gradable

> "'Is this design beautiful?' is hard to answer consistently, but 'does this follow our principles for good design?' gives Claude something concrete to grade against."

The criteria used in the experiment:
- **Design quality** — coherent whole, not collection of parts
- **Originality** — custom decisions, not template/AI defaults (penalise "purple gradients over white cards")
- **Craft** — typography hierarchy, spacing, contrast ratios
- **Functionality** — usability independent of aesthetics

Key: weight criteria where the model is weak (design/originality) more heavily than where it's already strong (craft/functionality).

## 3. The Planner Prevents Under-Scoping

> "Without the planner, the generator under-scoped: given the raw prompt, it would start building without first speccing its work, and end up creating a less feature-rich application."

**Planner rules:**
- Be ambitious about scope — consider adjacent features
- Stay high-level on technical details — wrong granular details cascade into implementation errors
- Constrain on **deliverables**, let generator figure out the **path**

## 4. The Evaluator Must Use Live Testing

The evaluator used Playwright to click through the running application like a user would — not just read code. This caught bugs invisible in code review:
- `fillRectangle` function existed but wasn't triggered properly on mouseUp
- Delete key handler required two conditions, but clicking only set one
- Route ordering caused FastAPI to match 'reorder' as a frame_id integer

**Implication for skill:** Evaluator must run the code, hit endpoints, interact with UI. Reading code alone misses wiring bugs.

## 5. Evaluator Rubber-Stamping Is the Default Failure Mode

> "Out of the box, Claude is a poor QA agent. In early runs, I watched it identify legitimate issues, then talk itself into deciding they weren't a big deal and approve the work anyway."

**Common evaluator failure patterns:**
- Identifies real issues → rationalises them away → approves
- Tests superficially → subtle bugs slip through
- Tends toward leniency toward LLM-generated outputs

**Fix:** Iterative calibration loop — read evaluator logs, find judgment divergences, update prompt. Several rounds needed.

## 6. Few-Shot Calibration Anchors Judgment

> "I calibrated the evaluator using few-shot examples with detailed score breakdowns. This ensured the evaluator's judgment aligned with my preferences, and reduced score drift across iterations."

Without anchors: evaluator may give CORRECT to code with real issues, FIXABLE to architecturally broken code, or invent issues that aren't there.

## 7. Generators Stub Features Frequently

> "The generator was still liable to miss details or stub features when left to its own devices."

Example from QA log: "Audio recording is still stub-only (button toggles but no mic capture)". The evaluator must specifically look for stubs: TODO comments, empty function bodies, UI that looks functional but isn't wired up.

## 8. Harness Complexity Should Match Model Capability

> "Every component in a harness encodes an assumption about what the model can't do on its own, and those assumptions are worth stress testing."

**Evolution of this harness:**
- **V1 (Sonnet 4.5):** Sprint decomposition + context resets + per-sprint evaluator
- **V1.5:** Sprint contracts negotiated between generator and evaluator
- **V2 (Opus 4.6):** Dropped sprints, dropped context resets, single end-of-run evaluator pass

As models improve, remove components that are no longer load-bearing. The evaluator isn't always worth the cost — it adds value when the task sits **beyond what the model does reliably solo**.

## 9. Context Resets vs Compaction

- **Compaction:** Summarises earlier conversation in place. Preserves continuity but doesn't eliminate context anxiety.
- **Context resets:** Clear window entirely, hand off state via structured artifact. Clean slate but requires complete handoff.

Opus 4.6 removed the need for context resets. Default: trust native coherence and automatic compaction.

## 10. The "Interesting Space" Moves, Not Shrinks

> "The space of interesting harness combinations doesn't shrink as models improve. Instead, it moves."

As models improve, some harness components become unnecessary, but new capability frontiers emerge that benefit from fresh harness designs. Re-examine harnesses when new models land: strip what's no longer load-bearing, add what's newly possible.

## 11. V2 Harness Performance (Reference Data)

For a DAW build from a one-line prompt:

| Phase | Duration | Cost |
|-------|----------|------|
| Planner | 4.7 min | $0.46 |
| Build R1 | 2 hr 7 min | $71.08 |
| QA R1 | 8.8 min | $3.24 |
| Build R2 | 1 hr 2 min | $36.89 |
| QA R2 | 6.8 min | $3.09 |
| Build R3 | 10.9 min | $5.88 |
| QA R3 | 9.6 min | $4.06 |
| **Total** | **3 hr 50 min** | **$124.70** |

Planner is cheap. QA is cheap. Build dominates cost and time. Three revision rounds were needed.

## 12. Iteration Can Produce Creative Leaps

> "On the tenth cycle, it scrapped the approach entirely and reimagined the site as a spatial experience: a 3D room with a checkered floor rendered in CSS perspective."

Later iterations aren't always better than middle ones — evaluator sometimes preferred iteration 5 over iteration 10. The generator should make a strategic decision each round: **refine** or **pivot**.
