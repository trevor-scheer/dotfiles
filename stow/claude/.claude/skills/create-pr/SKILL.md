---
name: create-pr
description: Create pull requests following best practices. Use when opening a PR, preparing changes for review, or running gh pr create.
user-invocable: true
---

# Creating Pull Requests

Follow these standards when creating PRs.

## Before Creating the PR

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

Use this template:

```markdown
## Summary

<1-3 bullet points explaining what changed and why>

## Changes

- <Specific change 1>
- <Specific change 2>
- <New/updated tests>

## Test Plan

<Steps a reviewer can follow to verify the changes work>
```

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

## Creating the PR

```bash
# Push your branch first
git push -u origin your-branch-name

# Create the PR
gh pr create \
  --title "feat: your feature description" \
  --body "$(cat <<'EOF'
## Summary

- Added X feature to improve Y

## Changes

- Implemented X in `src/components/`
- Added tests for edge cases
- Updated documentation

## Test Plan

1. Step one
2. Step two
EOF
)"
```

## After Creating the PR

1. Verify the PR looks correct on GitHub
2. Check that CI starts running
3. Address any review feedback promptly
4. Update PR title/description if you push additional commits

## Checklist

- [ ] All tests pass locally
- [ ] Linting/formatting is clean
- [ ] Commits follow conventional format
- [ ] PR title is descriptive (no emoji)
- [ ] Summary explains what and why
- [ ] Changes section lists specifics
- [ ] Test Plan has actionable steps
- [ ] No CI status mentioned in description
