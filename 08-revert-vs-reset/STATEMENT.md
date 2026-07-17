# 08 — Revert vs Reset

## Scenario

Your local history (`git log --oneline`, newest to oldest):

```
feat: add experimental flag for feature Y (not pushed)
feat: add audit logging
feat: enable feature X in production
feat: add flag for feature X
chore: initial commit
```

The `origin/main` remote (what your teammates already have / what's
already deployed) reaches up to `feat: add audit logging` — meaning
everything except the last commit is already public. You can check
this with:

```
git log --oneline origin/main
```

There are two problems to solve, each with its own right tool:

### Problem 1

`feat: enable feature X in production` caused an incident. **It's
already on `origin/main`** — your teammates already have it and it may
already be deployed. You need to undo that specific change (set
`FEATURE_X_ENABLED` back to `False`) without rewriting history that's
already public.

**Goal:** undo that commit using the tool that does **not** rewrite
shared history.

### Problem 2

`feat: add experimental flag for feature Y` is yours, from a moment
ago, and **hasn't been pushed yet**. You've changed your mind: you
don't want that commit at all, neither the commit nor its changes to
the file.

**Goal:** remove it completely from the local history, as if it never
happened.

## Verification

After solving Problem 1: `git log --oneline` should show a **new
commit** at the end undoing the change (the original "enable feature
X" commit is still there, in the middle of the history, untouched).
`cat feature_flags.py` should show `FEATURE_X_ENABLED = False` again.

After solving Problem 2: the "feature Y" commit should not appear at
all in `git log --oneline`, and the `feature_flags.py` file should not
contain `FEATURE_Y_ENABLED`.
