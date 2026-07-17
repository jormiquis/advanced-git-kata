# Hints — 09 Rewriting messages

**Hint 1**
```
git rebase -i main~3
```
(or `git rebase -i <hash-of-initial-commit>`). This opens the editor
with the 3 commits to rewrite.

**Hint 2**
Change `pick` to `reword` (or `r`) on all 3, leaving the order as is:
```
reword b2c3d4e changes
reword c3d4e5f various fixes
reword d4e5f6a more stuff
```

**Hint 3**
After saving, Git will open the editor **once for each commit marked
`reword`**, in order, showing you the current message so you can
overwrite it. Just delete the old text and write the new message for
each one.

**Hint 4**
`reword` is different from `edit`: `reword` only lets you touch the
message. `edit` (which you'll use in exercise 10) stops the rebase
entirely at that commit so you can also modify its content.

**Hint 5**
Verify with `git log --oneline` and, if you want to see the full
message of each one, `git log` (without `--oneline`) or
`git show <hash>`.
