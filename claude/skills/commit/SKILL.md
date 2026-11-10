---
name: commit
description: Author a concise, technical commit for staged changes using Conventional Commits. Use when asked to commit, write a commit message, or run /commit. Produces a `type(scope): subject` line plus terse technical bullets — no prose, no filler, minimal tokens.
---

# commit

Token-efficient commit author. Do the work, don't narrate it.

## Steps
1. `git status --short` and `git diff --staged`. If nothing is staged, `git diff`; stage with `git add -A` only when the user asked to commit everything.
2. Read the diff. Group changes by concern.
3. Emit the message in the Format below and run `git commit`. Do not explain your reasoning in chat — a one-line confirmation after committing is enough.

## Format
```
type(scope): summary
<blank line>
- technical bullet
- technical bullet
```
- **type**: feat | fix | refactor | perf | docs | test | chore | build | upgrade
- **scope**: top-level area or path, e.g. `bash/logout`, `flake`, `claude`
- **summary**: imperative, lowercase, ≤50 chars, no trailing period
- **body**: optional; one change per bullet, what changed (not why it's nice)

## Rules
- Bullets: `- ` prefix, terse noun/verb phrases, no trailing period, max 5. Collapse trivial changes.
- Omit the body entirely for a single-concern one-line change.
- State facts from the diff only. If a change's intent is unclear, omit it — don't guess.
- No "this commit", no "I", no emoji, no restating the diff line-by-line, no marketing adjectives.
- Add trailers (Co-Authored-By, etc.) only when repo convention or the harness requires them.

## Example
```
fix(bash/git): load git-prompt completion from package ref

- swap hardcoded path for ${pkgs.git} store ref
- guard sourcing behind file-exists check
```
