# Solution — 01 Atomic commits

```bash
# 1) Bugfix + its test
git add -p calculator.py
# → answer 'y' to the divide() hunk, 'n' (or simply leave out)
#   the power() one; if they appear together in the same hunk use 's' to split it
git add test_calculator.py
git commit -m "fix: handle division by zero in divide()"

# 2) New feature
git add calculator.py
git commit -m "feat: add power() function"

# 3) Documentation
git add README.md
git commit -m "docs: document available functions in the README"
```

## Why this is "senior"

- **`git add -p`** is the key tool: it lets you build the commit by
  *intent*, not by file. A single file can (and often does) contain
  several distinct logical changes.
- The bugfix goes **with its test** in the same commit: if someone
  later does `git revert` on that commit, the fix and the test get
  reverted together — no orphaned broken test, no fix left untested.
- Separating `feat` from `fix` from `docs` means:
  - `git log --oneline` tells a clear story.
  - If `power()` turns out to have a bug later, `git blame` points
    straight to the `feat` commit, not a giant "various changes" commit.
  - Automated changelog tools (semantic-release, etc.) can generate
    release notes from the `fix`/`feat`/`docs` types.
