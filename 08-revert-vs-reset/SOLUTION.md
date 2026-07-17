# Solution — 08 Revert vs Reset

```bash
# --- Problem 2 first: local commit, unpushed ---
git reset --hard HEAD~1
git log --oneline
cat feature_flags.py    # FEATURE_Y_ENABLED is gone

# --- Problem 1: already-pushed commit ---
git log --oneline
# find the hash of "feat: enable feature X in production"
git revert <that-hash> --no-edit
git log --oneline
cat feature_flags.py    # FEATURE_X_ENABLED = False again
```

## Why this is "senior"

This is probably **the** Git distinction that causes the most
incidents when applied wrong on a team:

| | `reset` | `revert` |
|---|---|---|
| What it does | Moves the branch pointer, optionally discarding commits and changes | Creates a **new** commit that undoes the effect of another one |
| Rewrites existing history | Yes | No |
| Safe on shared/pushed branches | **No** — if others already pulled those commits, after your `reset` + force-push their histories diverge from yours | **Yes** — it's just another commit, anyone can `pull` with no conflict |
| Typical use case | Undoing **local** commits, not yet shared | Undoing a change that's **already public** (code in production, shared branch, already-merged PR) |

The simple mental rule: **"Does anyone else already have this
commit?"**
- No → `reset` (or `rebase`/`amend`) is fine, it doesn't break anything
  for anyone.
- Yes → `revert`, because rewriting history others already have forces
  the whole team to do a careful `git pull --rebase` or, worst case,
  makes the "deleted" code reappear when someone merges their outdated
  copy.

This is the same criterion already used, unnamed, in earlier
exercises: in 02 and 03, rebase/amend were safe because the commits
were local; here, as soon as a commit is already on `origin/main`, the
tool changes.
