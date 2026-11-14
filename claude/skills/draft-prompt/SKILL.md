---
name: draft-prompt
description: Co-draft a detailed, high-quality prompt (task spec) for a coding or research task and write it to a markdown file. Use when the user wants help writing a prompt, spec, brief, or ticket — especially phrases like "draft a prompt", "help me spec this out", "turn this into a prompt", or "/draft-prompt". The skill runs several rounds of adversarial sparring to pressure-test the user's understanding, then does adversarial investigation of the codebase and docs to surface important details they are likely missing, before writing the final prompt.
---

# draft-prompt

Turn a rough idea into a precise, self-contained prompt that another agent (or a future you) could execute with no further clarification. The value is NOT in writing prose quickly — it is in **finding the gaps the user hasn't thought about** before they get baked into a prompt. Default agreement is the failure mode. Your job is to make the user's thinking sharper, then capture the result.

Produce the prompt as a markdown file. Do not start implementing the task itself.

## Operating principles

- **Adversarial, not agreeable.** Assume the user's first description is incomplete and partly wrong. Your job is to find where. Agreeing quickly is failure.
- **Specific over generic.** Every challenge must name a concrete scenario, file, input, or constraint — never "have you thought about edge cases?". Bad questions waste a round.
- **Test understanding, don't just collect answers.** When the user answers, probe whether the answer is coherent and whether they've actually reasoned it through. Surface contradictions.
- **Investigate before finalizing.** Read the actual codebase/docs. Most missing details are discoverable without asking the user — find them, then confirm the risky ones.
- **The user owns the decisions.** You surface gaps, trade-offs, and recommendations. They decide. Don't silently resolve ambiguity in the final prompt.
- **One prompt, self-contained.** The output must stand alone: someone with repo access and no memory of this conversation should be able to execute it.

## Workflow

Run these phases in order. Don't skip to writing the file.

### Phase 1 — Frame the target
1. Restate the task in one or two sentences: the goal, and the single load-bearing assumption that, if wrong, sinks the whole thing.
2. State what you believe "done" looks like. If you can't restate the task crisply, that is itself the first gap — ask about it before anything else.
3. Do a quick read of the relevant code/docs so you're sparring from facts, not guesses (see Phase 3 — light pass now, deeper later). Use `Grep`/`Glob`/`Read` or the Explore agent.

### Phase 2 — Sparring rounds (test understanding)
Run **2–4 rounds**. Each round: pick the highest-leverage unknowns and press on them. Prefer `AskUserQuestion` with concrete, mutually-exclusive options so the user chooses rather than writes essays — but include open-ended questions when the space is genuinely open. Stop early if the picture is clear; add a round if answers reveal new uncertainty.

Pull challenges from these lenses (pick what fits — don't ask all of them):
- **Scope boundary:** What is explicitly NOT in scope? Where does this task end?
- **Success criteria:** How will we know it worked? What's the observable acceptance test?
- **Failure/edge cases:** Concurrency, empty/huge inputs, errors, partial failure, rollback.
- **Hidden constraints:** Backwards compat, performance budget, platform (this repo targets both nix-darwin and linux), existing conventions, security.
- **Interfaces & contracts:** What callers/consumers depend on this? What breaks downstream?
- **Assumptions:** "You're assuming X exists / behaves like Y / is safe — is it?"
- **Alternatives:** Is the proposed approach the right one, or a patch over a root cause?
- **Contradiction check:** Where do two of the user's answers conflict? Name it.

After each round, briefly reflect back what changed in your understanding so the user can correct you.

### Phase 3 — Adversarial investigation
Now actively hunt for what the user is missing, using tools rather than questions where possible:
- Read the files the task touches and their neighbours. Trace callers and dependents.
- Find existing patterns/conventions the prompt should match (naming, module layout, test style).
- Look for landmines: TODOs, related open issues, tests that will break, config that must change in lockstep, docs that reference the behaviour.
- Check build/CI implications (e.g. in this repo, does it need a `make` target run, a flake input, both darwin + linux configs updated?).
- If the task depends on an external library/API/tool, verify current behaviour via `WebSearch`/`WebFetch` rather than trusting memory.

Collect findings as a short list of **"things the prompt must account for that you didn't mention."** Bring the genuinely decision-changing ones back to the user (one more short round via `AskUserQuestion`); fold the rest directly into the draft.

### Phase 4 — Write the prompt file
Only now write the file.
- Default path: `prompts/<kebab-case-slug>.md` in the current repo. If no `prompts/` dir exists, ask whether to create it there or use another path. Honour any path the user gave.
- Use the Template below.
- After writing, give a 2–3 line summary of the sharpest gaps the sparring surfaced and any open decisions you deliberately left to the user. Don't paste the whole file back into chat.
- Do not begin executing the task. This skill ends at a written prompt.

## Template

```markdown
# <Task title>

## Objective
<One paragraph: what to achieve and why. The load-bearing goal.>

## Context
<What an executing agent needs to know: relevant files/modules, current
behaviour, conventions to follow. Link to `path:line` where useful.>

## Scope
**In scope:**
- <...>

**Out of scope (do NOT do):**
- <...>

## Requirements
- <Concrete, testable requirements. Imperative. One per bullet.>

## Constraints & gotchas
- <Compat, performance, platform (darwin/linux), security, things that must
  change in lockstep, tests that will break. Surfaced during investigation.>

## Acceptance criteria
- <Observable checks that prove it's done. How to verify / what command to run.>

## Open decisions
- <Anything deliberately left for the executor or user to decide, with the
  trade-off stated. Omit if none.>
```

## Rules
- Never skip sparring to save time — the gaps are the point.
- Keep questions concrete and few per round; a vague question burns a round.
- Don't invent constraints. State facts from the code/docs or mark them as assumptions to confirm.
- The final prompt reflects the user's decisions; flag, don't bury, unresolved ambiguity under "Open decisions".
- If the user says "just write it", do one fast sparring round plus a quick investigation pass, then write — but tell them what you skipped.

## Example opening
> Here's my read: you want to add a `tailscale` service module that works on both the macpro and linux machines. The load-bearing assumption is that the same module activates cleanly under launchd (darwin) and systemd (linux) — if that's false the whole shape changes. Before I spar: is cross-platform actually required, or is this macpro-only right now?
