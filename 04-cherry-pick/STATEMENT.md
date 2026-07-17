# 04 — Cherry-pick

## Scenario

There are three branches: `main`, `develop` (where work in progress
lives) and `release/v1.0` (a branch for a version already in
production, created from `main` before the `develop` work started).

`develop` has 4 commits on top of `main`:

```
feat: add token refresh
fix: reject requests without a token (security)
feat: protect endpoint with authentication
feat: add basic authentication
```

You've just discovered that **one of those commits is a critical
security fix** (`fix: reject requests without a token (security)`) that
needs to reach `release/v1.0` **right now**, without dragging along the
rest of the `develop` work (full authentication, token refresh...)
which isn't ready for production yet.

## Goal

1. Switch to `release/v1.0`.
2. Bring over **only** the security fix commit using `git cherry-pick`,
   without bringing the other 3 commits from `develop`.
3. Verify that `server.py` in `release/v1.0` now has the protection
   against requests without a token, but that `auth.py` **does not
   exist** in that branch (because it belongs to a commit you didn't
   bring over).

## Verification

```
git log --oneline release/v1.0
```
Should show 2 commits: the `chore: initial commit` and, on top, one
with a message equivalent to the security fix (the hash will differ
from the one in `develop` — cherry-pick creates a new commit).

```
ls
```
While on `release/v1.0`, `auth.py` should not appear.
