# Solution — 02 Squash with interactive rebase

```bash
git rebase -i main
```

In the editor you'll see (oldest→newest):

```
pick q4r5s6t wip
pick m1n2o3p wip login validation
pick i7j8k9l fix typo
pick e4f5g6h wip logout
pick a1b2c3d asdf
```

Change it to:

```
pick q4r5s6t wip
squash m1n2o3p wip login validation
squash i7j8k9l fix typo
pick e4f5g6h wip logout
squash a1b2c3d asdf
```

After saving, Git will ask for the message of the first merged group
(the first 3 commits). Delete everything and write just:

```
feat: implement login with user validation
```

Then it'll ask for the second group's message (logout + the TODO).
Write:

```
feat: implement logout
```

Result:

```
git log --oneline main..feature/login
```
```
xxxxxxx feat: implement logout
yyyyyyy feat: implement login with user validation
```

## Why this is "senior"

- The history that lands on `main` should tell *what* was built, not
  *how* your trial-and-error process went. The process matters while
  you're developing (that's why committing "wip" locally as much as you
  want is fine); what shouldn't survive is that noise reaching a shared
  branch.
- A reviewer looking at 2 clear commits understands the change in
  seconds. With 5 "wip" commits they'd have to mentally reconstruct the
  process.
- If down the line someone needs to `git revert` "the login", with this
  history it's a single commit to revert — with the messy history it
  would be 3 intertwined commits, some broken halfway through.
