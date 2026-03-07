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

Before building, confirm you have a way to validate your work: tests, type checks, linting, a build step, or a script you can run. If no validation mechanism exists for the area you're changing, encourage creating one first. You should be able to iterate on your own work and catch errors without requiring the user to debug for you.

### 5. Build and iterate

Once the plan is approved and validation is in place, implement the changes. Run validation after each meaningful step. Fix issues as you find them rather than delivering broken work.

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
