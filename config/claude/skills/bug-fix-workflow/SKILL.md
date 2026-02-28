---
name: bug-fix-workflow
description: Fix bugs using the two-commit structure with failing test first. Use when fixing bugs, addressing issues, or correcting incorrect behavior.
user-invocable: true
---

# Bug Fix Workflow

Bug fixes use a **two-commit structure** that proves the bug exists before fixing it.

## The Two-Commit Structure

### Commit 1: Reproduce the Bug

```
test: reproduce <issue description>
```

Adds a **failing test** that demonstrates the bug:
- Must fail BEFORE the fix
- Must pass AFTER the fix
- Prevents future regressions

### Commit 2: Fix the Bug

```
fix: <description of what was fixed>
```

This commit:
- Fixes the actual bug
- Updates the test if needed
- May include additional related fixes

## Why This Structure?

1. **Proves the bug exists** before the fix
2. **Validates the fix** actually resolves the issue
3. **Prevents regressions** by leaving the test in place
4. **Makes review easier** by separating reproduction from fix

## Workflow Steps

### 1. Understand the Bug

- Read the issue/report carefully
- Identify expected vs actual behavior
- Determine the root cause

### 2. Write a Failing Test

```javascript
// Example (adapt to your language/framework)
test('issue #123: handles empty input correctly', () => {
  // This test reproduces the bug
  const result = processInput('');

  // Expected: returns default value
  // Actual (bug): throws exception
  expect(result).toBe('default');
});
```

### 3. Verify the Test Fails

```bash
npm test -- --grep "issue #123"
# Should FAIL - this proves the bug exists
```

### 4. Commit the Failing Test

```bash
git add .
git commit -m "test: reproduce empty input handling (issue #123)"
```

### 5. Implement the Fix

Make the minimal changes needed to fix the bug.

### 6. Verify the Test Passes

```bash
npm test -- --grep "issue #123"  # Should PASS now
npm test                          # All tests should pass
```

### 7. Commit the Fix

```bash
git add .
git commit -m "fix: handle empty input by returning default value

The processInput function was not checking for empty strings
before attempting to parse, causing an exception."
```

## Commit Message Guidelines

### Test Commit

```
test: reproduce <brief description>

- Reference issue number if applicable
- Describe what the test checks
- Note expected vs actual behavior
```

### Fix Commit

```
fix: <what was fixed>

<Why the bug occurred>
<What the fix does>
```

## Common Mistakes

- **Don't combine test and fix** in one commit
- **Don't write a passing test first** - it must fail initially
- **Don't skip the test** for "obvious" fixes
- **Don't forget to run all tests** before the fix commit

## Checklist

- [ ] Bug understood and root cause identified
- [ ] Failing test written that reproduces the bug
- [ ] Test verified to fail before fix
- [ ] Test committed with `test:` prefix
- [ ] Fix implemented
- [ ] Test verified to pass after fix
- [ ] All tests pass
- [ ] Fix committed with `fix:` prefix
