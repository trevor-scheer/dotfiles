---
name: review-pr
description: Review pull requests against best practices. Use when reviewing PRs, checking code quality, or providing feedback on changes.
user-invocable: true
---

# Reviewing Pull Requests

Follow this checklist when reviewing PRs.

## Usage

```
/review-pr 123
```

Or just ask: "Review PR #123"

## Review Process

### 1. Fetch PR Information

```bash
gh pr view <number>
gh pr diff <number>
```

### 2. Understand the Changes

- What problem does this PR solve?
- What approach was taken?
- Are there alternative approaches?

### 3. Run the Checklist

## Code Quality Checklist

### Architecture & Design

- [ ] Changes follow existing patterns in the codebase
- [ ] No unnecessary abstractions or over-engineering
- [ ] Code is in the appropriate location/module
- [ ] Dependencies are appropriate

### Correctness

- [ ] Logic is correct and handles edge cases
- [ ] Error handling is appropriate
- [ ] No obvious bugs or regressions
- [ ] Input validation where needed

### Testing

- [ ] New functionality has tests
- [ ] Bug fixes include regression tests
- [ ] Tests are readable and well-named
- [ ] Edge cases are covered

### Performance

- [ ] No O(n) operations where O(1) is possible
- [ ] No unnecessary allocations in hot paths
- [ ] Large inputs won't cause issues
- [ ] No obvious performance regressions

### Code Style

- [ ] Follows project conventions
- [ ] No unnecessary comments (code is self-documenting)
- [ ] Useful comments explain "why", not "what"
- [ ] Reasonable line lengths

### Security

- [ ] No command injection vulnerabilities
- [ ] No path traversal issues
- [ ] No SQL injection (if applicable)
- [ ] Sensitive data not logged
- [ ] No hardcoded credentials

## PR Description Checklist

- [ ] Title is clear and descriptive (no emoji)
- [ ] Summary explains what changed and why
- [ ] Changes section lists specific modifications
- [ ] Test plan has actionable steps
- [ ] **NO mention of CI status** (tests passing, linting clean)

## Bug Fix PRs

Bug fixes should ideally use two-commit structure:

1. **First commit**: Failing test reproducing the bug
2. **Second commit**: Fix + any test updates

Verify:
- [ ] First commit's test actually fails without the fix
- [ ] Second commit makes the test pass
- [ ] No other tests broken

## Review Comments

### Approve When

- All checklist items pass
- No blocking issues found
- Minor suggestions can be addressed in follow-up

### Request Changes When

- Missing tests for new functionality
- Correctness issues or bugs
- Security vulnerabilities
- Significant architecture concerns

### Comment (No Decision) When

- Questions need answers before deciding
- Want discussion on approach
- Minor suggestions only

## Example Review Comment

```markdown
## Review Summary

**Overall**: Approve with minor suggestions

### What I Reviewed
- Changes to `src/auth/validator.js`
- New tests in `tests/auth.test.js`
- PR description and commit history

### Checklist Results
- [x] Architecture: Follows patterns
- [x] Correctness: Logic looks sound
- [x] Testing: Good coverage
- [x] Performance: No concerns
- [ ] Code style: Minor suggestion below

### Suggestions

1. **Line 45**: Consider using early return to reduce nesting
2. **Tests**: Could add test for empty input case

### Questions

None - ready to merge after addressing suggestions.
```

## Providing Feedback

**Be constructive:**
- Explain *why* something should change, not just *what*
- Offer alternatives when suggesting changes
- Distinguish between blocking issues and suggestions

**Be specific:**
- Reference line numbers
- Quote the relevant code
- Provide examples of preferred approach

**Be kind:**
- Assume good intent
- Phrase as questions when unsure
- Acknowledge good work
