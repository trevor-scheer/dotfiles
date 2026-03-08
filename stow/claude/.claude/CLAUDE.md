# Shared Claude Preferences

Global preferences symlinked to `~/.claude/CLAUDE.md` — applies to all projects.

## Default Workflow

Follow this workflow for all tasks unless the change is truly trivial (single-line fix, typo, etc.).

### 1. Question the premise

Before accepting a request at face value, think critically about whether the user is asking the right question. Consider the XY problem — the user may be describing a solution (Y) when the real issue is something else (X). If you suspect the request could be better framed, say so and suggest an alternative approach before proceeding.

### 2. Ask clarifying questions

Remove all ambiguity before writing any code. Do not assume intent, scope, or constraints — ask. This includes:
- Edge cases and expected behavior
- Which parts of the codebase are in scope
- Compatibility or backwards-compatibility requirements
- Whether there are related changes the user hasn't mentioned

Make no assumptions. If something is unclear, ask.

### 3. Plan first

Default to plan mode (`/plan`) for any non-trivial change. Present a concrete implementation plan — files to change, approach, trade-offs — and get approval before writing code. This avoids wasted effort on the wrong approach.

### 4. Ensure a validation mechanism exists

Before building, confirm you have a way to validate your work independently — without requiring the user to manually test or debug for you. The goal is autonomous iteration: you should be able to make a change, verify it works, and fix issues on your own.

Validation is not limited to unit tests. Consider what's appropriate for the change:
- **Tests** (unit, integration, e2e) — the most common mechanism. Run existing tests, add new ones for new behavior.
- **Type checking / linting** — run `tsc`, `eslint`, `shellcheck`, etc. to catch errors statically.
- **Build steps** — confirm the project compiles and bundles successfully.
- **Browser/UI validation** — for frontend changes, set up or use tools like Playwright, Puppeteer, or Storybook to verify visual/interactive behavior programmatically.
- **Script-based validation** — write a small script that exercises the change and asserts expected output.
- **REPL / manual invocation** — run the changed code directly and inspect output.

If no validation mechanism exists for the area you're changing, **create one as part of the plan**. This is not optional overhead — it's a prerequisite. Propose adding a test harness, a Playwright test, a build script, or whatever is appropriate. The user should approve this as part of the plan in step 3.

You are empowered to install tools, create test files, and build whatever framework is needed to validate your work. The investment pays for itself by enabling you to iterate confidently and arrive at correct solutions without user intervention.

### 5. Build and iterate

Once the plan is approved and validation is in place, implement the changes. Run validation after each meaningful step — don't batch up changes and hope they work. When validation fails, diagnose and fix the issue yourself before moving on. The user should receive working, validated code, not a first draft.

## Agent-Oriented CLI Tools

These tools are installed via Brewfile and are **preferred over their traditional counterparts** for context efficiency. Use them proactively.

| Tool | Command | Use instead of | When to use |
|---|---|---|---|
| **ast-grep** | `sg` | `grep`/`rg` for code patterns | Structural code search — find functions, calls, imports by AST pattern rather than regex. E.g. `sg -p 'console.log($$$)' -l ts` finds all console.log calls regardless of formatting. |
| **difftastic** | `difft` | `diff` | Compare files structurally — ignores whitespace/formatting noise, shows only meaningful changes. Use `GIT_EXTERNAL_DIFF=difft git diff` for git diffs. |
| **sd** | `sd` | `sed` | Find-and-replace in files — uses standard regex syntax (no escaping hell). E.g. `sd 'oldName' 'newName' file.ts` |
| **scc** | `scc` | `wc -l`/`cloc` | Get a fast codebase overview — languages, line counts, complexity estimates. Run `scc` at repo root for instant project context. |
| **shellcheck** | `shellcheck` | manual shell review | Validate shell scripts before running them. Always run `shellcheck script.sh` on generated shell code. |
| **yq** | `yq` | manual YAML editing | Query/edit YAML, TOML/XML structurally (like jq for YAML). E.g. `yq '.services.web.ports' docker-compose.yml` |

**Guidance:** Prefer `sg` over regex-based grep when searching for code patterns (function calls, imports, class definitions). Prefer `sd` over `sed` for substitutions. Prefer `difft` over `diff` for reviewing changes. Run `scc` early in a session to understand project scope. Run `shellcheck` on any generated shell scripts.

## Pull Request Templates

When creating or updating PRs, prefer the repo's own template (`.github/PULL_REQUEST_TEMPLATE.md`) if one exists. If not, use the default template at `~/.claude/skills/pr/PULL_REQUEST_TEMPLATE.md`. Always create PRs as drafts unless explicitly told otherwise.
