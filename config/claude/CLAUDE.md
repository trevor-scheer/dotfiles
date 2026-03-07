# Shared Claude Preferences

Global preferences symlinked to `~/.claude/CLAUDE.md` — applies to all projects.

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
