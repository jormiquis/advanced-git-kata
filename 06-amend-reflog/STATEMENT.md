# 06 — Amend and reflog

This exercise has two independent parts.

## Part A — `git commit --amend`

The last commit (`feat: third improvement, almost ready`) has a poorly
descriptive message, and you also forgot to include a new file
`notes.txt` that belongs to that same change.

**Goal:**
1. Create the file `notes.txt` with the content `todo: review edge
   cases`.
2. Add it to the **same commit** that already exists (without creating
   a new commit), and while you're at it change the message to:
   `feat: improve core logic and add review notes`.

**Verification:** `git log --oneline` should still show the same number
of commits as before (4), but the last one's message should be the new
one, and `git show HEAD --stat` should list `notes.txt` as part of that
commit.

## Part B — Recovering commits with `git reflog`

Once you finish part A, you're going to cause your own "disaster" to
practice recovering from it:

```
git reset --hard HEAD~2
```

This moves the branch 2 commits backward. With `git log --oneline`
you'll see 2 commits have "disappeared" from the tip.

**Goal:** recover the branch to exactly the state it was in right
*after* finishing part A (with all 4 commits, including the amend with
`notes.txt`), using `git reflog` to find the right commit and going
back to it.

**Verification:** `git log --oneline` should show 4 commits again,
ending with the commit whose message is `feat: improve core logic and
add review notes`, and `notes.txt` should exist in the directory.
