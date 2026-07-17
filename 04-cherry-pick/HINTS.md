# Hints — 04 Cherry-pick

**Hint 1**
First identify the exact hash of the commit you want:
```
git log --oneline develop
```
Look for the line `fix: reject requests without a token (security)`.

**Hint 2**
Switch to the target branch before doing anything:
```
git switch release/v1.0
```

**Hint 3**
The command is:
```
git cherry-pick <hash-of-the-develop-commit>
```

**Hint 4**
If Git tells you there's a conflict (shouldn't happen in this exercise,
but just in case, for other scenarios): resolve the conflict in the
files, `git add` the resolved files, and `git cherry-pick --continue`.
To cancel, `git cherry-pick --abort`.

**Hint 5**
Notice the resulting commit's hash on `release/v1.0` is different from
the original one on `develop`, even though the content and message are
the same — cherry-pick creates a brand-new commit with a different
parent, it doesn't "copy" the commit as-is.
