# 03 — Fixup and autosquash

## Scenario

Your current history (`git log --oneline`, newest to oldest):

```
d4e5f6a feat: add Order class with total calculation
c3d4e5f feat: add User class
b2c3d4e feat: add formatting.py with truncate()
a1b2c3d chore: initial commit
```

While reviewing the code you notice `User` (commit `feat: add User
class`) has a bug: it doesn't validate that `email` contains an `@`.
You've kept working since then, and there's 1 commit on top of that
(`Order`).

If you fix the bug with a plain commit at the end, the history will
say "added User" and, much later, "fixed a User bug" — as if the bug
had lived in production for a while, when in reality none of these
commits have ever been shared with anyone (they're all local, unpushed).

## Goal

1. Fix the bug in `user.py`: the constructor should raise
   `ValueError("invalid email")` if `"@" not in email`.
2. Use `git commit --fixup` pointing at the `User` commit to create a
   fixup commit.
3. Use `git rebase -i --autosquash` so that fixup gets automatically
   folded into the original `User` commit, without having to manually
   reorder anything in the editor.

## Verification

When you're done:
- `git log --oneline` should still show **4 commits** (not 5): the
  fixup disappears because it got merged.
- `git show <hash-of-the-User-commit>` should now include the email
  validation.
- No other commit should have been altered (neither its content nor its
  message).
