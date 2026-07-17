# Solution — 10 Splitting a commit

```bash
git rebase -i main~1
```
In the editor:
```
edit b2c3d4e feat: add Product model, get_product endpoint and price formatting helper
```

Git stops right after applying that commit:

```bash
git reset HEAD~1
git status
# models.py, api.py, utils.py show up as untracked

git add models.py
git commit -m "feat: add Product model"

git add api.py
git commit -m "feat: add get_product endpoint"

git add utils.py
git commit -m "feat: add format_price helper"

git rebase --continue
```

```bash
git log --oneline
```
```
xxxxxxx feat: add format_price helper
yyyyyyy feat: add get_product endpoint
zzzzzzz feat: add Product model
a1b2c3d chore: initial commit
```

## Why this is "senior"

- `edit` in an interactive rebase is the tool for when you need to
  **rewrite the content** of a past commit, not just its message
  (that's `reword`, exercise 09) nor merge it with another (that's
  `squash`/`fixup`, exercises 02-03).
- The core trick is `git reset HEAD~1` (without `--hard`) *inside* the
  point where the rebase is paused: it separates "remove the commit"
  from "lose the changes". It's the same command from exercise 06, but
  here it's used deliberately as a restructuring tool, not as recovery
  from a disaster.
- Splitting a giant commit into several atomic ones is exactly the
  opposite of exercise 02 (squash) — the same kind of situation (messy
  history before sharing the work), but applying the inverse operation
  depending on what's needed: sometimes there are too many small
  commits that need merging, sometimes one is too big and needs more
  granularity.
