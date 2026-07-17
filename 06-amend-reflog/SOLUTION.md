# Solution — 06 Amend and reflog

## Part A

```bash
echo "todo: review edge cases" > notes.txt
git add notes.txt
git commit --amend -m "feat: improve core logic and add review notes"
```

## Part B

```bash
git reset --hard HEAD~2
git log --oneline
# only 2 commits show up now

git reflog
# look for something like:
# a1b2c3d HEAD@{2}: commit (amend): feat: improve core logic and add review notes

git reset --hard a1b2c3d
git log --oneline
# back to 4 commits
cat notes.txt   # exists again
```

## Why this is "senior"

- `--amend` is the right way to fix "I forgot something" or "the
  message is wrong" on the commit you **just** made, without cluttering
  the history with a `fix typo` commit right after it. Same as with
  rebase: only while the commit is local.
- `git reflog` is the reason it's actually very hard to truly lose work
  with Git in practice. Every time `HEAD` moves (commit, amend, rebase,
  reset, checkout...) an entry stays in the reflog for a while (90 days
  by default for reachable commits, 30 for unreachable ones), even
  though the commit no longer shows up in normal `git log` because no
  branch points to it.
- This is exactly what separates someone who panics at an accidental
  `reset --hard` from someone who knows there's almost always a way
  back. The reflog is **local** (it's not pushed to the remote), so
  this only applies to your own copy of the repo — it's not a
  substitute for backups or pushing on time.
