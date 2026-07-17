# Hints — 03 Fixup and autosquash

**Hint 1**
First make the code change and stage it normally:
```
# edit user.py adding the validation
git add user.py
```

**Hint 2**
Instead of `git commit -m "..."`, use:
```
git commit --fixup <hash-of-the-User-commit>
```
This creates a commit whose message automatically starts with
`fixup! feat: add User class` — this is a convention Git recognizes.

**Hint 3**
To fold it automatically:
```
git rebase -i --autosquash <hash-before-the-User-commit>
```
(or `git rebase -i --autosquash HEAD~4` / the hash of the `chore:
initial commit`). Git will reorder the editor plan on its own, placing
the `fixup!` right below its target commit with the `fixup` action
already marked — you just save and close the editor without touching
anything.

**Hint 4**
To skip the editor entirely:
```
GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash <base>
```
`true` is a command that always "succeeds" without opening anything, so
Git applies the auto-generated plan directly.

**Hint 5**
You can set `git config --global rebase.autosquash true` so you don't
need to pass `--autosquash` every time you use `-i`.
