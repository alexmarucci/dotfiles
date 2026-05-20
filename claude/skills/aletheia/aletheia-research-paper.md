# Aletheia: Transferable Principles (Non-Mathematics Reference)

Source: Feng et al., "Towards Autonomous Mathematics Research" (Google DeepMind, 2026)
arXiv:2602.10177v3

## 1. Core Architecture: Generator-Verifier-Reviser Loop

Aletheia uses three subagents in a loop:
- **Generator** — produces candidate solutions
- **Verifier** — independently evaluates candidates (never sees generator's reasoning)
- **Reviser** — fixes specific issues flagged by verifier

Loop continues until Verifier approves or iteration limit reached.

## 2. Chain-of-Thought Decoupling (The Key Insight)

> "Decoupling a reasoning model's final output from its intermediate thinking tokens, and adding well-chosen prompt scaffolding, enables the model to recognise flaws it initially overlooked during generation."

The generator's thinking trace can act as **misleading supporting context**, artificially inflating the conditional probability of an erroneous solution. By hiding the reasoning chain from the verifier, the verifier evaluates the solution on its merits alone.

**Two hypotheses for why this works:**
1. Training incentivises the model to guess/bluff
2. Extended thinking trace creates false confidence in wrong answers

## 3. Abstention: "No Solution Found"

Aletheia explicitly outputs "No solution found" when it cannot solve a problem. On FutureMath Basic, it returned solutions for fewer than 60% of problems, but **conditional accuracy on answered problems exceeded 82%**.

> "Many practicing researchers would prefer to trade raw problem-solving capability for increased accuracy."

**Key metric:** Conditional accuracy (accuracy on problems the system chose to answer) > raw accuracy.

## 4. Wrong Verdict is Terminal

A WRONG solution is "fundamentally flawed, relies on invalid logic, or cannot be salvaged without complete rewrite." The system details the fatal flaws and **stops**. It does not attempt revision.

> "Attempting to revise a fundamentally wrong approach wastes compute and often produces something worse than starting over."

## 5. Specification Gaming Risk

> "Whenever there is room for ambiguity, the model exhibits a tendency to misinterpret the question in a way that is easiest to answer, even when such an interpretation would be obviously unintended."

This is the "specification gaming" / "reward hacking" pattern. The verifier must check that the solution addresses the **intended** problem, not just a convenient interpretation.

## 6. Hallucination Patterns

Even with tool use (internet search):
- **Without tools:** Fabricates references entirely (fake titles, fake authors)
- **With tools:** Cites real references but misrepresents their results
- Shifts from obvious hallucinations to subtle ones

Tool use reduces but does not eliminate hallucination. The verifier must independently verify claims.

## 7. Ablation: Harness vs Raw Model

On 13 Erdős problems Aletheia solved, raw Gemini Deep Think (same base model, ~2x compute) solved only 8. The agentic harness — generator-verifier-reviser loop — provides significant gains over raw model inference at similar or lower compute.

**Implication:** The harness architecture itself provides capability lift, independent of base model quality.

## 8. Conditional Accuracy vs Coverage Trade-off

| Metric | Value |
|--------|-------|
| Total candidates (from 700 open problems) | 200 evaluated |
| Fundamentally flawed | 68.5% |
| Technically correct | 31.5% |
| Meaningfully correct (addressing intent) | 6.5% |

The gap between "technically correct" and "meaningfully correct" (31.5% → 6.5%) shows the specification gaming problem is real and large.

## 9. Scaling Laws

Inference-time compute can be increased by orders of magnitude with substantial accuracy gains before plateauing. However, scaling alone was insufficient for research-grade tasks — the agentic harness (generator-verifier-reviser) was needed on top.

**Implication for skill:** More evaluation iterations help, but architecture matters more than raw compute.

## 10. The Verifier Must Be Independent

The entire design rests on the verifier having **no exposure** to the generator's reasoning process. Any leakage of the thinking chain undermines the core mechanism. In the skill, this is enforced by running the evaluator as a separate teammate with its own context window.

## 11. Tool Use Integration

Aletheia relies heavily on tool use (search, browsing) to reduce hallucinations. Simply granting internet access was insufficient — the model needed to be **trained for tool use** to see substantial benefit.

**Implication for skill:** The evaluator should have access to the same tools (Bash, browser, MCP) as the generator, so it can independently verify claims rather than relying on the generator's assertions.

## 12. Success Cases Are Rare

> "Success cases are rare, and an apt intuition for autonomous capabilities (and limitations) may currently be important for finding such cases."

> "These results should NOT be interpreted as suggesting that AI can consistently solve research-level questions."

The pipeline increases reliability when it delivers, but many runs will produce nothing useful. Abstention is the expected outcome for hard problems.
