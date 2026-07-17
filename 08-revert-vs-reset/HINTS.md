# Hints — 08 Revert vs Reset

**Hint about order**
Solve Problem 2 first (the unpushed commit, which is the most recent
one) and then Problem 1. If you do it the other way around, the
"feature Y" commit stops being the last commit (because the revert adds
one on top), and removing it becomes needlessly complicated.

## Problem 2 (reset)

**Hint 1**
The commit you want to remove is the current `HEAD` and hasn't been
shared with anyone, so you can safely move backward:
```
git reset --hard HEAD~1
```
`--hard` also discards the working directory changes (not just the
commit) — exactly what you want, since you don't care about anything
from `FEATURE_Y_ENABLED`.

**Hint 2**
Check with `git log --oneline` and `cat feature_flags.py`.

## Problem 1 (revert)

**Hint 3**
Find the hash of the `feat: enable feature X in production` commit:
```
git log --oneline
```

**Hint 4**
```
git revert <that-hash>
```
Git will open the editor with a default message like `Revert "feat:
enable feature X in production"` — you can leave it or edit it, then
save.

**Hint 5**
Notice that `git revert`, unlike `reset`, **adds** a new commit (it
doesn't erase or move anything existing). That's why it's safe to use
on commits already on `origin/main`: anyone who does `git pull` gets
the revert commit like any other, with no rewritten-history conflicts.

**Hint 6**
If the commit being reverted weren't the most recent one, and later
commits also touched the same lines, `git revert` could produce
conflicts just like a `cherry-pick` or `rebase` would — resolved the
same way: edit, `git add`, `git revert --continue`.
