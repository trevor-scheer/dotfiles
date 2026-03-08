---
name: pr
description: Create or update pull requests following best practices. Use when opening a PR, updating an existing PR, preparing changes for review, or running gh pr create.
user-invocable: true
---

# Pull Requests

Follow these standards when creating or updating PRs.

## Before Creating/Updating

### 1. Verify All Checks Pass

Run your project's standard checks:

```bash
# Examples - adapt to your project
npm test              # JavaScript/TypeScript
cargo test            # Rust
pytest                # Python
go test ./...         # Go
```

### 2. Review Your Changes

```bash
git status
git diff main...HEAD
git log main..HEAD --oneline
```

### 3. Ensure Commits Follow Conventions

- `feat:` - New feature
- `fix:` - Bug fix
- `refactor:` - Code restructuring
- `docs:` - Documentation only
- `test:` - Test additions/changes
- `chore:` - Maintenance tasks

## PR Title Guidelines

**Do:**
- Use conventional commit format: `feat: add user authentication`
- Be specific and descriptive
- Keep under 72 characters

**Don't:**
- Use emoji in titles
- Use vague titles like "Updates" or "Fixes"
- Include issue numbers in the title (put in body)

## PR Description Structure

### Template priority

1. **Repo template** — check for `.github/PULL_REQUEST_TEMPLATE.md` (or `.github/PULL_REQUEST_TEMPLATE/` directory) in the current repo. If present, use it.
2. **Default template** — if no repo template exists, use the default template at `~/.claude/skills/pr/PULL_REQUEST_TEMPLATE.md`.

Always populate the template sections based on the actual changes — never leave placeholder text.

## What NOT to Include

**Never mention in PR descriptions:**
- "All tests passing"
- "Linting is clean"
- "No warnings"
- Any CI-related status

These are enforced by CI and mentioning them adds zero value.

## Test Plan Section

This section is ONLY for manual verification steps reviewers can follow:

**Good:**
```markdown
## Test Plan

1. Run `npm start` and navigate to /settings
2. Click the "Dark Mode" toggle
3. Verify the theme changes immediately
```

**Bad:**
```markdown
## Test Plan

- All tests pass
- Ran eslint with no warnings
```

## Creating a PR

**Always create PRs as drafts by default.** Only create a ready-for-review PR if the user explicitly asks.

```bash
# Push your branch first
git push -u origin your-branch-name

# Create the PR (draft by default)
gh pr create --draft \
  --title "feat: your feature description" \
  --body "$(cat <<'EOF'
## Summary

- Added X feature to improve Y

## Changes

- Implemented X in `src/components/`
- Added tests for edge cases

## Test Plan

1. Step one
2. Step two
EOF
)"
```

## Updating a PR

When the user asks to update an existing PR, use `gh pr edit` to modify the title and/or body. Push any new commits first.

```bash
# Push new commits
git push

# Update the PR title and/or body
gh pr edit --title "feat: updated title" --body "$(cat <<'EOF'
...updated body...
EOF
)"
```

If only the description needs updating, omit `--title`. If only the title needs updating, omit `--body`.

## After Creating/Updating

1. Verify the PR looks correct on GitHub
2. Check that CI starts running
3. Address any review feedback promptly
4. Update PR title/description if you push additional commits

## Checklist

- [ ] All tests pass locally
- [ ] Linting/formatting is clean
- [ ] Commits follow conventional format
- [ ] PR is created as draft (unless explicitly told otherwise)
- [ ] PR title is descriptive (no emoji)
- [ ] Summary explains what and why
- [ ] Changes section lists specifics
- [ ] Test Plan has actionable steps
- [ ] No CI status mentioned in description
