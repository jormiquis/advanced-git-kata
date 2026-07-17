# Hints — 10 Splitting a commit

**Hint 1**
```
git rebase -i main~1
```
In the editor, change `pick` to `edit` on the line for the commit you
want to split, then save.

**Hint 2**
Git stops the rebase right *after* applying that commit, with `HEAD`
pointing at it. You need to "undo" it while keeping the changes in the
working directory (not losing them):
```
git reset HEAD~1
```
(`reset` without `--hard` moves the commit pointer backward but leaves
the files as they were — they now show up as uncommitted changes).

**Hint 3**
```
git status
```
You should see `models.py`, `api.py`, and `utils.py` as new
untracked/unstaged files.

**Hint 4**
Now make 3 normal commits, one per file:
```
git add models.py
git commit -m "feat: add Product model"

git add api.py
git commit -m "feat: add get_product endpoint"

git add utils.py
git commit -m "feat: add format_price helper"
```

**Hint 5**
Once you're done recreating the commits, the rebase is still "paused"
— you need to explicitly tell it to continue:
```
git rebase --continue
```

**Hint 6**
If anything goes wrong at any point, `git rebase --abort` takes you
back to the state before you started any of this.
