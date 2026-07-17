# Hints — 06 Amend and reflog

## Part A

**Hint 1**
Create the file and stage it normally, like any other commit:
```
echo "todo: review edge cases" > notes.txt
git add notes.txt
```

**Hint 2**
Instead of `git commit -m "..."`, use:
```
git commit --amend -m "feat: improve core logic and add review notes"
```
This **replaces** the last commit with a new one that has the same
parent, and includes both the original changes and whatever you just
staged.

**Hint 3**
`--amend` rewrites the commit (changes its hash). It's only safe to do
this if that commit hasn't been shared/pushed yet — same rule as with
rebase.

## Part B

**Hint 4**
After `git reset --hard HEAD~2`, the amend commit "disappeared" from
`git log`, but it hasn't actually been deleted yet — Git doesn't erase
objects immediately.

**Hint 5**
```
git reflog
```
Lists, in reverse chronological order, every move `HEAD` has made in
this repo (commits, resets, checkouts, rebases...). Look for the line
corresponding to the `commit (amend)` with the message you set.

**Hint 6**
Once you've identified the hash in the reflog (something like
`a1b2c3d HEAD@{2}: commit (amend): feat: improve core logic...`):
```
git reset --hard <that-hash>
```
This moves your branch back to that point, recovering everything.

**Hint 7**
A more "surgical" alternative if you didn't want to use
`reset --hard`: `git cherry-pick <hash>` to bring back only that commit
without discarding anything from the current state.
