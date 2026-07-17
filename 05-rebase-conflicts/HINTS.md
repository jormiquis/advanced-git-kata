# Hints — 05 Conflicts during a rebase

**Hint 1**
```
git switch feature/tuning
git rebase main
```
Git will stop at the first conflicting commit and tell you so in the
terminal.

**Hint 2**
```
git status
```
shows you which file is in conflict (`config.py`, marked as "both
modified"). Open it: you'll see `<<<<<<<`, `=======`, `>>>>>>>` markers
delimiting "your version" (HEAD, which during a rebase is temporarily
the branch you're rebasing onto) and the version from the commit being
reapplied.

**Hint 3**
During a `rebase`, watch the orientation: the top part of the conflict
(`<<<<<<< HEAD`) is the state of **main** (the base you're reapplying
onto), and the bottom (`>>>>>>> <hash>`) is your `feature/tuning`
commit being applied. This is the reverse orientation of a `merge`.

**Hint 4**
Edit the file by hand to leave the final result you want (no leftover
`<<<`, `===`, `>>>` markers), then:
```
git add config.py
git rebase --continue
```

**Hint 5**
The second commit (`feat: increase timeout...`) might apply without
conflict since it doesn't touch `MAX_CONNECTIONS` — or it might
conflict anyway because the surrounding context changed. Either way,
repeat: edit → `git add` → `git rebase --continue`.

**Hint 6**
At any point, if you want to bail out without resolving anything:
```
git rebase --abort
```
