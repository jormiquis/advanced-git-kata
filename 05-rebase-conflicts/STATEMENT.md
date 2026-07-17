# 05 — Resolving conflicts during a rebase

## Scenario

`main` and `feature/tuning` diverged by modifying the same file
(`config.py`), including the same line (`MAX_CONNECTIONS`):

- `main` has a new commit: `fix: lower MAX_CONNECTIONS to 20 after
  production incident` → set `MAX_CONNECTIONS = 20`.
- `feature/tuning` has 2 commits: the first set `MAX_CONNECTIONS = 50`,
  the second touched `TIMEOUT_SECONDS` and added `RETRY_ATTEMPTS`.

You want to update `feature/tuning` to incorporate the fix from `main`,
keeping your branch as a linear series of commits on top of `main`
(no merge commits).

## Goal

1. Switch to `feature/tuning`.
2. Run `git rebase main`.
3. A conflict will occur on the **first** commit being reapplied
   (`feat: increase MAX_CONNECTIONS to 50`), because both branches
   touched the same line.
4. Resolve the conflict by deciding the value that actually makes
   sense: since `main` lowered the value after a production incident,
   the correct call is to **respect main's value (`20`)** instead of
   overwriting it with your `50` — but the rest of your changes
   (timeout, retries) should be kept in the following commits.
5. The **second** commit might also conflict when reapplied, even
   though it doesn't touch `MAX_CONNECTIONS` directly: since the
   context line changed in the first conflict, the second commit's
   patch may no longer apply cleanly. If it does, resolve it the same
   way (edit, `git add`, `git rebase --continue`).
6. Continue the rebase until it finishes.

## Verification

```
git log --oneline feature/tuning
```
Should show a linear history: `initial commit` → `fix: lower
MAX_CONNECTIONS...` (from main) → your 2 commits reapplied on top.

```
cat config.py
```
Should have `MAX_CONNECTIONS = 20`, `TIMEOUT_SECONDS = 60`, and
`RETRY_ATTEMPTS = 3`.

There should be no merge commit (`git log --graph` shouldn't show any
commit with two parents).
